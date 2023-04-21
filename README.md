# ELEGANT-Planner

The Heterogeneous-Aware scheduler of the ELEGANT project responsible for finding optimal placements for the user submitted applications.




## Set up

We highly suggest using a virtual environment for the installation of the project. <br> 
Note that some packages like `ProGraML` are developed for UNIX OS only, and hence the Planner is expected to work on these type of operating systems. <br>
Python versions expected to be compatible >=3.6 & <3.11 .

### Install Planner
'''
git clone https://github.com/elegant-h2020/ELEGANT-Planner.git
cd ELEGANT-Planner
pip install -r requirements.txt
'''
<br>


To launch the Planner all you have to do is run `python3 api.py` on your current terminal and open a second one to run your tests. It is highly possible that during the first run of the api.py an error will occur regarding the `dgl` library that `ProGraML` is using. This is not an error of the Planner, but it prevents from running it eitherway. <br>
More specifically the error will conclude to something like this `ImportError: cannot import name DGLHeteroGraph from dgl.heterograph`. This happens because `DGLHeteroGraph` has been deprecated and replaced by `DGLGraph`. In order to fix this you have to run `vim path/to/lib/python/packages/programl/transform_ops.py` and change `DGLHeteroGraph` to `DGLGraph` at the designated lines.
<br>After that, rerun `python3 api.py`.
<br>

## Running experiments

Assuming Flask app is active, open a second terminal and run `cd tests`. <br>
an the `tests` directory you will find different scripts for executing use case examples, alongside with corresponding `.png` images depicting their operators' and network's topology. <br>
<br>
E.g. for running the Medical Wearables Use Case run the following commands: <br>

`python3 change_objectives.py -t 1.0 -p 0.0` <br>
The above's command `-t` and `-p` arguments stand for the optimization weights of execution time and power consumption respectively. These weights must sum up to 1. <br>
`python3 medical_uc.py` <br>
With the above command we produce an optimal scheduling for the use case application. <br>
If we want to change the optimization preference, in order to include power consumption optimization we simply rerun: <br>
'''
python3 change_objectives.py -t 0.5 -p 0.5
python3 medical_uc.py
'''
The operators' assignment will now be different, due to the change of weights. 




