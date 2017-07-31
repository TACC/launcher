# Launcher
[![Build Status](https://travis-ci.org/marshalllerner/launcher.svg?branch=master)](https://travis-ci.org/marshalllerner/launcher)
[![status](http://joss.theoj.org/papers/7b5df63cd8a40f557d66051695d300a7/status.svg)](http://joss.theoj.org/papers/7b5df63cd8a40f557d66051695d300a7)

Launcher is a utility for performing simple, data parallel, high throughput computing (HTC) workflows on clusters, massively parallel processor (MPP) systems, workgroups of computers, and personal machines.

## Installing Launcher
Launcher does not need to be compiled. Unpack the tarball or clone the repository in the desired directory. Then, set `LAUNCHER_DIR` to point to that location. Python 2.7 or greater and hwloc are required for full functionality. See INSTALL for more information.

## Verifying Installation

Included in the download is a file called "quickstart" found in the folder "tests". In order to verify installation, open the command line and find the launcher file, and then type "cd tests" and then press the enter key. If the quickstart file is in the correct place, there is no need for arguments, so type "./quickstart". However, if the Launcher directory is found somewhere else, type "./quickstart <Launcher directory>". The script will run in the terminal and if there are no errors in the process, the last line will say "Launcher: Done. Job exited without errors".

## Quickstart

* Set `LAUNCHER_JOB_FILE` to point to your job file. Example job files are provided in extras/examples.
* Be sure that `LAUNCHER_DIR` is set to the directory containing the launcher source files (user-installed ONLY. Not required if using system installed version of launcher).
* From the command-line or within your jobscript, run:`$LAUNCHER_DIR/paramrun`

## Available Environment Variables

You should set the following environment variables:

* `$LAUNCHER_JOB_FILE` is the file containing the jobs to run in your parametric submission.
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

## Enviromental Variable descriptions
* '$LAUNCHER_JOB_FILE' - The launcher job file is the specific directory where the specified output statement(s) is/are. Here you will find the file with the jobs that will run in the your 'parametric submission'.
* 'LAUNCHER_WORKDIR' - This is simply the working directory. This directory will hold any relative path as well as the execution of launcher. In most cases, the working directory will be your home directory or your root users home directory.
* 'LAUNCHER_NPROCS' - In your parametric submissions, there are processes that are running. This variable stores the number of processes that are simultaneously running in your submissions . It can simply be stated as the total processes. In this example, when keeping variables their default vales, the value will be 1.
* '$LAUNCHER_NHOSTS' - Just as launcher_nprocs holds the number of processes running simultaneously, this variable contains the number of hosts that are running in your submission simultaneously.
* '$LAUNCHER_PPN' - This is the number of processors used while running the program. Changing the number of processors is an easy way to increase or decrease the time spent running the program. The default for this variable is 1.
* '$LAUNCHER_NJOBS' - This variable is simply the total number of jobs. If only one job is being run, then the variable value is 1. 
* '$LAUNCHER_TSK_ID' - When running the program, this variable is a number from 0 to 'launcher_nprocs-1' which represents the processing core on which the job is running.
* '$LAUNCHER_JID' - Numbered from 1 to the variable 'launcher_njobs', this variable is an active representation of the job instance currently running in the problem.

## Task Scheduling Behavior

The launcher has three available behaviors for scheduling jobs, available by setting the environment variable `$LAUNCHER_SCHED`: (descriptions below assume k = task, p = num. procs, n = num. jobs)

* dynamic (default) - each task k executes first available unclaimed line
* interleaved - each task k executes every (k+p)th line
* block - each task k executes lines [ k(n/p)+1, (k+1)(n/p) ]

## Using Launcher on Multi-/Many-core Processors
Launcher uses the hwloc utility to determine layout of cores on the node. If hwloc is installed on your system and the commands are in the default `PATH`, Launcher will use this to partition the cores on node between the tasks. You can enable task binding by setting `LAUNCHER_BIND=1` before calling `paramrun`.

## Using Launcher with Intel Xeon Phi (KNC) Co-processor Cards

Launcher has the ability to execute appropriately compiled executables natively on first generation Intel Xeon Phi (KNC) cards.

Available Environment Variables for Intel Xeon Phi execution:

* `$LAUNCHER_NPHI` is the number of Intel Xeon Phi cards per node. This is set to zero (0) by default. Acceptable values are '1' and '2'.
* `$LAUNCHER_PHI_PPN` is the number of processes per Intel Xeon Phi card.
* `$LAUNCHER_PHI_JOB_FILE` is the file containing the jobs to run on the Intel Xeon Phi cards.

## Job Submission

Copy the example job submission script `launcher.<sched>` to your working directory to use as a starting point for interfacing with the desired batch system. Note that this script provides some simple error checking prior to the actual submission to aid in diagnosing missing executables and misconfiguration.

The directory containing this README contains several example submission scripts:
  * SGE:   launcher.sge
  * SLURM: launcher.slurm

## Referencing Launcher
If you are using Launcher, please remember to make a reference to it when publishing results. The file `paper/paper.bib` contains the BibTeX-formatted citation list. Please reference entry `Wilson:2014:LSF:2616498.2616533` (i.e., in LaTeX: `\cite{Wilson:2014:LSF:2616498.2616534}`).

