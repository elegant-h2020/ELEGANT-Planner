import csv
from datetime import datetime
import statistics
import tempfile
import sys
import os
from oclude import profile_opencl_kernel
from openclio import argsIOrole

def write_message(msg):
    sys.stderr.write('<<< OCLUDIFY INFO >>> ' + msg + '\n')



machine = 'silver1'
model = 'CPU'
#model = 'Tesla'
exp ='exp2' #'exp1'

KERNELS_FILE = 'cgo17-amd.csv'
CONFIG_FILE = 'uncompiledkernels_silver1_cpu_exp1.csv' # uncompiled kernels from experiment1
#CONFIG_FILE = 'benchmarks_config.csv'
DEVICES_FILE = f'devices_{machine}.txt'

DEFAULT_GSIZES = [100, 1000, 100] #[1000,21000,2000]
DEFAULT_SAMPLES = 200
DEFAULT_TIMEOUTS =[35, 40] #[10,15,20] exp1

RESULTS_FILE = f'results_{machine}_{model}_{exp}.csv'
TIMESTAMP_FORMAT = '%Y-%m-%d_%H-%M-%S'


oclude_args = dict(
    file=None,
    kernel='A',
    gsize=None, lsize=None,
    platform_id=None, device_id=None,
    instcounts=False,
    timeit=True,
    samples=None,
    timeout=None,
    ignore_cache=True,
)

# read the kernels file and create a dict <kernel name> -> <kernel source>
sources = {}
with open(KERNELS_FILE, 'r') as f:
    kernelsfile = csv.DictReader(f)
    for row in kernelsfile:
        sources[row['benchmark']] = row['src']

# read the devices file and create a list [(<custom device name>, <platform id>, <device id>), ...]
devices = []
with open(DEVICES_FILE, 'r') as f:
    for line in f:
        line = line.strip()
        if line:
            data = line.split()
            devices.append((data[0], int(data[1]), int(data[2])))

# read the config file one first time to see if there is a range of kernels to run
# if there is, we will only read the config file again for the kernels in the range
# if there is no range, we will read the config file again for all kernels
kernels_range = (1, -1)
with open(CONFIG_FILE, 'r') as f:
    configfile = csv.DictReader(f)
    config = [row['config'] for row in configfile]
    kernels_range = (1, len(config))
found_start, found_end = (-1, -1)
for i, c in enumerate(config, 1):
    if '<' in c and found_start == -1:
        found_start = i
    if '>' in c and found_start != -1:
        found_end = i
        break

if found_end != -1:
    kernels_range = (found_start, found_end)

if kernels_range != (1, len(config)):
    write_message(
        'Range specified. Running kernels {} to {}.'
        .format(*kernels_range)
    )
else:
    write_message('No range specified. Running all kernels.')

# read the config file again, this time only for the kernels in the range
with open(CONFIG_FILE, 'r') as f:
    configfile = csv.DictReader(f)
    kernels = []
    for i, row in enumerate(configfile, 1):
        if i < kernels_range[0] or i > kernels_range[1]:
            continue
        kernels.append(row)

# find if there are kernels in the specified range have a '!' config value
# in this case, we will only run the kernels with a '!' config value
for kernel in kernels:
    if '!' in kernel['config']:
        write_message(
            'Found kernel(s) with a "!" config value. Running only this/these kernel(s).'
        )
        # filter out the kernels that don't have a '!' config value
        kernels = [k for k in kernels if '!' in k['config']]
        break

# run the kernels
results = []
n_kernels = len(kernels)
for i, kernel in enumerate(kernels, 1):
    if 'X' in kernel['config']:
        write_message(
            'Skipping kernel `{}` ({}/{})'
            .format(kernel['benchmark'], i, n_kernels)
        )
        continue

    write_message(
        'Running kernel `{}` ({}/{})'
        .format(kernel['benchmark'], i, n_kernels)
    )

    # set the kernel source using a temporary file with tempfile
    with tempfile.NamedTemporaryFile(mode='w', delete=False) as f:
        f.write(sources[kernel['benchmark']])
        oclude_args['file'] = f.name

    # set the samples
    oclude_args['samples'] = int(
        kernel['samples']
    ) if kernel['samples'] else DEFAULT_SAMPLES

    # set the gsize range
    gsize_range = DEFAULT_GSIZES
    if kernel['gsizes']:
        gsize_range = [int(x) for x in kernel['gsizes'].split()]
        gsize_range[1] += 1

    # set the devices
    kernel_devices = devices
    if kernel['devices']:
        kernel_devices = []
        for device in kernel['devices'].split():
            found_device = False
            for d in devices:
                if device == d[0]:
                    kernel_devices.append(d)
                    found_device = True
                    break
            if not found_device:
                kernel_devices.append((device, -1, -1))

    # set the timeouts
    timeouts_list = [
        int(x) for x in kernel['timeouts'].split()
    ] if kernel['timeouts'] else DEFAULT_TIMEOUTS

    for gsize in range(*gsize_range):
        oclude_args['gsize'] = gsize

        for device, pid, did in kernel_devices:
            if pid == -1:
                write_message(
                    'Unknown device `{}`. Skipping.'.format(device)
                )
                continue

            oclude_args['platform_id'], oclude_args['device_id'] = pid, did
            write_message(
                'Running kernel `{}` on device `{}` with gsize {} and {} samples.'
                .format(kernel['benchmark'], device, gsize, oclude_args['samples'])
            )

            success = False
            for timeout in timeouts_list:
                oclude_args['timeout'] = timeout
                write_message('Timeout set to {} seconds.'.format(timeout))

                # run the kernel
                try:
                    res = profile_opencl_kernel(**oclude_args)
                except TimeoutError as e:
                    write_message('Timeout error: {}'.format(e))
                    continue

                success = True
                result = dict(
                    kernel=kernel['benchmark'],
                    gsize=gsize,
                    device=device,
                    samples=oclude_args['samples'],
                )

                # compute time statistics
                hostcode_times = []
                device_times = []
                transfer_times = []
                for measurement in res['results']:
                    hostcode_times.append(
                        measurement['timeit']['hostcode']
                    )
                    device_times.append(measurement['timeit']['device'])
                    transfer_times.append(
                        measurement['timeit']['transfer']
                    )

                result['hostcode_mean'] = statistics.mean(hostcode_times)
                result['hostcode_median'] = statistics.median(
                    hostcode_times
                )
                result['hostcode_var'] = statistics.pvariance(
                    hostcode_times
                )

                result['device_mean'] = statistics.mean(device_times)
                result['device_median'] = statistics.median(device_times)
                result['device_var'] = statistics.pvariance(device_times)

                result['transfer_mean'] = statistics.mean(transfer_times)
                result['transfer_median'] = statistics.median(
                    transfer_times
                )
                result['transfer_var'] = statistics.pvariance(
                    transfer_times
                )

                # compute input/output bytes
                result['input_bytes'] = 0
                result['output_bytes'] = 0
                args_io_role = argsIOrole(
                    'A', sources[kernel['benchmark']], filename=oclude_args['file']
                )

                for arg, role in args_io_role.items():
                    argtype = arg.split(' %')[0]
                    vf = gsize if argtype.endswith('*') else 1
                    vecsize = 1
                    if argtype.startswith('<'):
                        vecsize = int(argtype.split('<')[1].split('x')[0])

                    n_bytes = 0
                    if argtype.startswith('i') or 'x i' in argtype:
                        n_bytes = int(
                            argtype
                            .split('i')[1]
                            .split('*')[0]
                            .split('>')[0]
                        ) // 8
                    elif 'float' in argtype:
                        n_bytes = 4
                    elif 'double' in argtype:
                        n_bytes = 8

                    if 'input' in role:
                        result['input_bytes'] += (n_bytes * vf * vecsize)
                    if 'output' in role:
                        result['output_bytes'] += (n_bytes * vf * vecsize)

                results.append(result)

                break

            if not success:
                write_message(
                    'All timeouts failed. Skipping current kernel run configuration.'
                )

    # delete the temporary file
    os.remove(oclude_args['file'])

# write the results to a csv file
results_filename = RESULTS_FILE if RESULTS_FILE else 'results_{}.csv'.format(
    datetime.now().strftime(TIMESTAMP_FORMAT)
)
with open(results_filename, 'w') as f:
    writer = csv.DictWriter(
        f,
        fieldnames=[
            'kernel',
            'gsize',
            'device',
            'input_bytes',
            'output_bytes',
            'samples',
            'device_mean',
            'device_median',
            'device_var',
            'hostcode_mean',
            'hostcode_median',
            'hostcode_var',
            'transfer_mean',
            'transfer_median',
            'transfer_var',
        ],
    )
    writer.writeheader()
    writer.writerows(results)


import pandas as pd

results_df = pd.read_csv(results_filename)
results_df.head()
