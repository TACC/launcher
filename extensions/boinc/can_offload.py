#!/usr/bin/env python

import os
import subprocess
import commands

class DynamicNonStandardException(Exception): #change this exception depending on what the actual error is for
  pass

class CommandNotFoundException(Exception): #if the command is not found
  pass

def can_offload(fileName):
  try:
    good_path = subprocess.check_output(["which", fileName])[:-1]
    if "ELF" in subprocess.check_output(["file", good_path]):
      #os.access(fileName, os.X_OK)
      try:
        libs = subprocess.check_output(["ldd", good_path])
      except subprocess.CalledProcessError:
        return True
      libArr = libs.split("\n")
      for lineNum in range(1, len(libArr) - 1):
        if any(possibilities in libArr[lineNum] for possibilities in ("/lib/", "/lib64/", "/usr/")):
          continue
      #    raise DynamicNonStandardException("%s contains more than just standard libraries %s" %(fileName, libArr[lineNum]))
      #   I wasn't sure if there should be an error thrown or it should just return false.
        return False
      return True
    else:
      return False
  except subprocess.CalledProcessError:
    raise CommandNotFoundException("Command was not found")
