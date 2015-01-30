#!/bin/bash
#
# Simple SLURM script for submitting multiple serial
# jobs (e.g. parametric studies) using a script wrapper
# to launch the jobs.
#
# To use, build the launcher executable and your
# serial application(s) and place them in your WORKDIR
# directory.  Then, edit the CONTROL_FILE to specify 
# each executable per process.
#-------------------------------------------------------
#-------------------------------------------------------
# 
#         <------ Setup Parameters ------>
#
#$ -N Parametric 
#$ -pe 4way 48
#$ -q development
#$ -o Parametric.o$JOB_ID
#$ -l h_rt=1:00:00
#$ -V
#$ -cwd
#   <------ You MUST Specify a Project String ----->
#$ -A A-ccsc 
#------------------------------------------------------
#
# Usage:
#	#$ -pe <parallel environment> <number of slots> 
#	#$ -l h_rt=hours:minutes:seconds to specify run time limit
# 	#$ -N <job name>
# 	#$ -q <queue name>
# 	#$ -o <job output file>
#	   NOTE: The env variable $JOB_ID contains the job id. 
#
#module load launcher
export EXECUTABLE=$LAUNCHER_DIR/init_launcher
export CONTROL_FILE=paramlist
export PHI_CONTROL_FILE=phiparamlist
export WORKDIR=.
export PHI_WORKDIR=.
export LAUNCHER_SCHED=interleaved
# 
# Variable description:
#
#  EXECUTABLE       = full path to the job launcher executable
#  CONTROL_FILE     = text input file which specifies
#                     executable for each process
#                     (should be located in WORKDIR)
#  PHI_CONTROL_FILE = text input file which specifies executable
#                     for each process to be run on Intel Xeon Phi
#                     (should be located in PHI_WORKDIR)
#  WORKDIR          = location of working directory
#  PHI_WORKDIR      = location of working directory for Intel Xeon Phi jobs
#  LAUNCHER_SCHED   = scheduling method for lines in CONTROL_FILE
#                     options (k=process, n=num. lines, p=num. procs):
#                       - interleaved (default): 
#                           process k executes every k+nth line
#                       - block:
#                           process k executes lines [ k(n/p)+1 , (k+1)(n/p) ]
#                       - dynamic:
#                           process k executes first available unclaimed line

#      <------ End Setup Parameters ------>
#--------------------------------------------------------
#--------------------------------------------------------

#----------------
# Error Checking
#----------------

if [ ! -d $WORKDIR ]; then
        echo " "
	echo "Error: unable to change to working directory."
	echo "       $WORKDIR"
	echo " "
	echo "Job not submitted."
	exit
fi

if [ ! -x $EXECUTABLE ]; then
	echo " "
	echo "Error: unable to find launcher executable $EXECUTABLE."
	echo " "
	echo "Job not submitted."
	exit
fi

if [ ! -e $WORKDIR/$CONTROL_FILE ]; then
	echo " "
	echo "Error: unable to find input control file $CONTROL_FILE."
	echo " "
	echo "Job not submitted."
	exit
fi

#----------------
# Job Submission
#----------------

cd $WORKDIR/
echo " WORKING DIR:   $WORKDIR/"

$LAUNCHER_DIR/paramrun $EXECUTABLE $WORKDIR $CONTROL_FILE `hostname` $PHI_WORKDIR $PHI_CONTROL_FILE

echo " "
echo " Parameteric Job Complete"
echo " "
