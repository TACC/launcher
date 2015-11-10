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

if [ "x$LAUNCHER_DIR" == "x" ]
then
  module load launcher/3.0
fi

module load python

export LAUNCHER_PLUGIN_DIR=$LAUNCHER_DIR/plugins
export LAUNCHER_RMI=SLURM
 
$LAUNCHER_DIR/paramrun

