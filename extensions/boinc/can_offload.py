#!/usr/bin/env python

import os
import subprocess
import commands

class DynamicNonStandardException(Exception): #change this exception depending on what the actual error is for
    pass

def can_offload(fileName):
    try:
        if "ELF" in subprocess.check_output(["file", fileName]):
            #os.access(fileName, os.X_OK)
            try:
                libs = subprocess.check_output(["ldd", fileName])
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
        return False
