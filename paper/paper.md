---
title: 'Launcher: A simple tool for executing high throughput computing workloads'
tags:
  - tools
  - high throughput computing
  - parallel computing
  - distributed computing
authors:
 - name: Lucas A. Wilson
   orcid: 0000-0002-0686-3152
   affiliation: 1
 - name: John M. Fonner
   affiliation: 1
 - name: Jason Allison
   affiliation: 1
 - name: Oscar Esteban
   affiliation: 2
 - name: Harry Kenya
   affiliation: 1
 - name: Marshall Lerner
   affiliation: 1
affiliations:
 - name: Texas Advanced Computing Center, The University of Texas at Austin
   index: 1
 - name: Stanford University
   index: 2
date: 07 June 2017
bibliography: paper.bib
---

# Summary
Launcher [@Wilson:2014:LSF:2616498.2616534, @Wilson2016, @Wilson201757] is a utility for performing simple, data parallel, 
high throughput computing (HTC) workflows on clusters, massively parallel processor (MPP) systems, workgroups of computers, 
and personal machines. It can be easily run from userspace or installed for system-wide use on shared resources. Launcher 
will perform automatic process binding on multi-/many-core architectures where hwloc [@hwloc] is installed.

# Use Cases
Launcher is commonly used in situations where search or analysis of a large data space on independent points is required. 
Launcher is frequently used for:
* Sequence alignment scoring for many hundreds or thousands of DNA/RNA sequence pairs
* Docking/scoring (protien/ligand dock scoring, drug/immunotherapy development, etc.)
* Immune repetoire analysis
* Statistical analysis on unknown variables

# Workflow
Launcher uses a tree-based parallel startup mechanism (similar to MPI) to scatter jobs to multiple nodes/processors. The filesystem is used to gather data from separate tasks (typically into individual output files). Multiple launcher invocations can be chained together to perform pipelined analysis or to perform chained simulation/analysis workflows.

![launcher workflow](launcher_workflow.png "Launcher Workflow")

# References
