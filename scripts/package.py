#!/usr/bin/env python2.7

import json
import os
import shutil
import sys
from os.path import join, getsize


def main():
    indir, outdir, data_file = sys.argv[1:4]
    extensions = {'xm', 'mod', 'it', 'v2m'}
    max_size = 256 * 1024
    tunes = []
    for root, dirs, files in os.walk(indir):
        for file in files:
            full_path = join(root, file)
            name, ext = file.rsplit('.', 1)
            if ext not in extensions or getsize(full_path) > max_size:
                continue
            try:
                author, title = [x.strip() for x in name.split('-', 1)]
            except ValueError:
                author, title = 'Unknown', name
                continue
            shutil.copy(full_path, join(outdir, str(len(tunes))))
            tunes.append((author, title))

    with open(data_file, 'w') as f:
        json.dump(tunes, f)


main()
