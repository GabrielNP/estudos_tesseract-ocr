#!/usr/bin/env python3

import sys

args = sys.argv[1:]
text_file = args[0]
output_dir = args[1] if len(args) == 2 else '.'

with open(text_file) as file:

    read_file = file.read()
    index = 1
    for line in read_file.split('\n'):
        line = line.strip()
        if len(line):
            new_file = open(f'{text_file}_splitted_{index}.gt.txt', 'w')
            new_file.write(line)
            new_file.close()
            index+=1
            
        