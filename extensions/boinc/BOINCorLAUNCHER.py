#!/usr/bin/env python

import sys
from can_offload import *

if len(sys.argv) < 2 or len(sys.argv) > 2:
  raise EnvironmentError("Too many or not enough variables. Exiting")
  exit(1)
else:
  file_object = open(sys.argv[1])
  bout = open("BOINCcommands.txt", "w")
  lout = open("launchercommands.txt", "w")
  for line in file_object.readlines():
    try:
      if can_offload(line.split()[0]):
        bout.write(line)
      else:
        lout.write(line)
    except IndexError:
      print("There was a line with no command. Skipping this line.")
    except CommandNotFoundException:
      print("The line `{}` contained an error with the command. Skipping this line.".format(line[:-1]))
bout.close()
lout.close()
