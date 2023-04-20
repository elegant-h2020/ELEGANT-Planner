import pyopencl as cl

platforms = cl.get_platforms()
for pid, platform in enumerate(platforms):
    print('Platform %d: %s' % (pid, platform.name))
    devices = platform.get_devices()
    for did, device in enumerate(devices):
        symbol = '`' if did == len(devices) - 1 else '+'
        print(' %s-- Device %d: %s' % (symbol, did, device.name))
