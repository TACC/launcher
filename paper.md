---
title: 'Launcher: A simple tool for executing high throuhput computing workloads'
tags:
  - tools
  - high throughput computing
authors:
 - name: Lucas A. Wilson
   orcid: 0000-0002-0686-3152
   affiliation: 1
 - name: John M. Fonner
   orcid: 0000-0000-0000-1234
   affiliation: 1
 - name: Oscar Esteban
   orcid: 0000-0000-0000-1234
   affiliation: 2
affiliations:
 - name: Texas Advanced Computing Center, The University of Texas at Austin
   index: 1
 - name: Disney Inc.
   index: 2
date: 07 June 2017
bibliography: paper.bib
---

# Summary
Launcher is a utility for performing simple, data parallel, high throughput computing (HTC) workflows on clusters, 
massively parallel processor (MPP) systems, workgroups of computers, and personal machines. It can be easily run from 
userspace or installed for system-wide use on shared resources. Launcher provides a plugin system for adding scheduler 
integration (current integrations for SLURM and GridEngine).
