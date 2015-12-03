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
#SBATCH -J Parametric 
#SBATCH -n 16
#SBATCH -p development
#SBATCH -o Parametric.o%j
#SBATCH -t 00:05:00
#          <------ Account String ----->
# <--- (Use this ONLY if you have MULTIPLE accounts) --->
##SBATCH -A
#------------------------------------------------------

export LAUNCHER_PLUGIN_DIR=$LAUNCHER_DIR/plugins
export LAUNCHER_RMI=SLURM
export LAUNCHER_JOB_FILE=jobfile
 
$LAUNCHER_DIR/paramrun

