#!/bin/bash
#
# Laucher batch script file for TACC systems (like Frontera, Stampede2, etc.)
# Si Liu
# July 13, 2020
#
# Simple SLURM script for submitting multiple serial
# jobs (e.g. parametric studies) using a script wrapper
# to launch the jobs.
#
# To use, build the launcher executable and your
# serial application(s) and place them in your WORKDIR
# directory.  Then, edit the LAUNCHER_JOB_FILE to specify 
# each executable per process.
#-------------------------------------------------------
# 
#         <------ Setup Parameters ------>
#
#SBATCH -J launcher
#SBATCH -N 2 
#SBATCH -n 16
#SBATCH -p development
#SBATCH -o Parametric.%j.out
#SBATCH -e Parametric.%j.err
#SBATCH -t 00:24:00
#SBATCH -A <------ Account String ----->

#------------------------------------------------------

module load launcher
export LAUNCHER_WORKDIR=Your-Working-Directory-Here
export LAUNCHER_JOB_FILE=helloworld_multi_output

$LAUNCHER_DIR/paramrun

