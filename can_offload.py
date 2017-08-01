#!/usr/bin/env python

import os
import subprocess
import commands

class DynamicExeException(Exception):
    pass

def can_offload(fileName):
    if os.access(fileName, os.X_OK):
        try:
            libs = subprocess.check_output(["ldd", fileName])
        except subprocess.CalledProcessError:
            return True
        libArr = libs.split("\n")
        for lineNum in range(1, len(libArr) - 1):
            if any(possibilities in libArr[lineNum] for possibilities in ("/lib/", "/lib64/", "/usr/")):
                continue
            raise DynamicExeException("%s contains more than just standard libraries %s" %(fileName, libArr[lineNum]))
        return True
    else:
        return False
