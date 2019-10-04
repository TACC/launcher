# Launcher
[![Build Status](https://travis-ci.org/marshalllerner/launcher.svg?branch=master)](https://travis-ci.org/marshalllerner/launcher)
[![status](http://joss.theoj.org/papers/7b5df63cd8a40f557d66051695d300a7/status.svg)](http://joss.theoj.org/papers/7b5df63cd8a40f557d66051695d300a7)

Launcher is a utility for performing simple, data parallel, high throughput computing (HTC) workflows on clusters, 
massively parallel processor (MPP) systems, workgroups of computers, and personal machines.

## Installing Launcher in User Space
Launcher does not need to be compiled. 
Unpack the tarball or clone the repository in your $HOME directory (or another convenient directory). 
Then, set `LAUNCHER_DIR` to point to that directory (usually: `export LAUNCHER_DIR=$HOME/launcher`).
`Python 2.7` or greater and `hwloc` are required for full functionality. 
See INSTALL file for more information.

## Verifying Installation

## Quickstart Batch
Obtain a `commands` file and a batch job script with the launcher command to set up and run an initial test.
For systems with `modules` (Software Mananagement System), load the launcher modulefile:

```shell
       module load launcher                #Sites with modules and launcher installed
```
   
or, for a User-Space installed `launcher` set `LAUNCHER_DIR` to its top-level directory 
   
```shell
       export LAUNCHER_DIR=$HOME/launcher  #For user-installed launcher in $HOME dir.
```
   
Create a directory in your `HOME` directory to run a launcher test, and `cd` into it;
   
```shell
       cd; mkdir launcher_test; cd launcher_test
```
   
Copy a SLURM job script and a job file (list of execution commands) into this directory:
   
```shell
       cp $LAUNCHER_DIR/extras/examples/helloworldshort             commands
       cp $LAUNCHER_DIR/extras/batch-scripts/job_script_test.slurm  job
```

Submit the job script. 
(You may need to supply an account for the `#SBATCH -A` option in the script.)
(If compute nodes have less than 16 cores, you may need to reduce the `#SBATCH -n` value.)
The `$LAUNCHER_DIR/paramrun` line in the job script will execute the commands in the `commands` file.

```shell
       sbatch job
```

results will be written to the job output file (`launcher_test.o`...) in the present directory.
Modify the `commands` and `job` files for your own work plan.  There are many other features
available for more complex workflow executions. 

## Quickstart Interactive
Execute all the above commands for the Qucikstart Batch section above, stopping
after executing  cp to obtain the commands file.

Copy the quicktest commands to the present directory:

```shell
       cp $LAUNCHER_DIR/extras/tests/quicktest*  .
```

Interactively obtain a compute node (in SLURM).  
At TACC, execute the idev command, and wait for a compute node prompt.
For non-TACC sites, see site instructions for node access through `srun` (for SLURM).

```shell
       idev   # at TACC
       srun ... #at non-TACC sites
```

Once you are on a compute node interactively, execute the `quicktest` (or `quicktest2`) command.

```shell
       ./quicktest
```

Output will be displayed to the terminal window.
Modify the `commands` file for your own work plan.  There are many other features
available for more complex workflow executions. 

## Environment Variables

You should set the following environment variables:

* `$LAUNCHER_JOB_FILE` is the file containing the "jobs" (commands) to run in your parametric submission.
* `$LAUNCHER_WORKDIR` is the directory where the launcher will execute. All relative paths will resolve to this directory.

The launcher defines the following environment variables for each job that is started:

* `$LAUNCHER_NPROCS` contains the number of processes running simultaneously in your parametric submission.
* `$LAUNCHER_NHOSTS` contains the number of hosts running simultaneously in your parametric submission.
* `$LAUNCHER_PPN` contains the number of processes per node.
* `$LAUNCHER_NJOBS` contains the number of jobs in your job file.
* `$LAUNCHER_TSK_ID` is the particular processing core that the job is running on, from 0 to `$LAUNCHER_NPROCS-1`.
* `$LAUNCHER_JID` represents the particular job instance currently running. `$LAUNCHER_JID` is numbered from 1 to `$LAUNCHER_NJOBS`.

Example: If you want to redirect stdout to a file containing the unique ID of each line, you can specify the following in the paramlist file: ```a.out > out.o$LAUNCHER_JID```

If this particular execution instance of a.out was the first line in the job file, the output would be placed in the file "out.o1".

Note: you can also use the launcher to run a sequence of serial jobs when you have more jobs to run than the requested number of processors.  

## Task Scheduling Behavior

The launcher has three scheduling methods, available by setting the environment variable `$LAUNCHER_SCHED`: (descriptions below assume k = task, p = num. procs, n = num. jobs)

* dynamic (default) - task k executes first available unclaimed line
* interleaved - task k executes lines k, k+p, k+p*2, k+p*3, etc.
* block - task k executes lines [ k(n/p)+1, (k+1)(n/p) ]

## Using Launcher on Multi-/Many-core Processors
Launcher uses the hwloc utility to determine layout of cores on the node. If hwloc is installed on your system and the commands are in the default `PATH`, Launcher will use this to partition the cores on node between the tasks. You can enable task binding by setting `LAUNCHER_BIND=1` before calling `paramrun`.

## Job Submission

Copy the example job submission script `job_script.<sched>` to your working directory to use as a starting point for interfacing with the desired batch system.
The `commands` file contains the list of execution (commands) to run, one per line.

In the `extras/batch-scripts`  directory there are example submission scripts:
  * SGE:   launcher.sge
  * SLURM: launcher.slurm

## Reference
The file `paper/paper.bib` contains the BibTeX-formatted citation list. 
Reference entry `Wilson:2014:LSF:2616498.2616533` (i.e., in LaTeX: `\cite{Wilson:2014:LSF:2616498.2616534}`).
