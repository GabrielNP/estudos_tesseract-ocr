#!/usr/bin/env python3

import os
import re
import sys

args = sys.argv[1:]
file = args[0]

rename_file = re.sub(r'([a-zA-Z\d\.\_]+).gt.txt[\.\w]+', '\\1.tif', file)
os.rename(file, rename_file)