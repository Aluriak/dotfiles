#!/bin/python3
"""Print an integer in stdout, function to state of dir sent as first parameter.

usage:
    verbosels.py /path/to/dir

print:
    1   populated (have at least one file)
    2   hidden files only
    3   empty
    4   is a file, not a dir

"""

import os
import sys
import subprocess
from enum import Enum
from collections import namedtuple


# used if python < 3.5
DirEntry = namedtuple('DirEntry', 'is_file, is_dir, path, name')


class FileState(Enum):
    hidden = 'hidden'
    file = 'file'
    dir = 'dir'

    @staticmethod
    def of(filename:str):
        if os.path.basename(filename).startswith('.'):
            return FileState.hidden
        if os.path.isfile(filename):
            return FileState.file
        if os.path.isdir(filename):
            return FileState.dir
        raise ValueError('Filename {} is not a file nor a dir.'.format(filename))


class DirState(Enum):
    populated = 1
    hidden_only = 2
    empty = 3
    # errors
    isfile = 4
    not_exist = 5

    @staticmethod
    def of(dirname):
        if os.path.isfile(dirname):
            return DirState.isfile
        elif not os.path.exists(dirname):
            return DirState.not_exist
        have_hidden = False
        for entry in walk(dirname):
            state = FileState.of(entry)
            if state in (FileState.file, FileState.dir):
                return DirState.populated
            if state == FileState.hidden:
                have_hidden = True
        if have_hidden:
            return DirState.hidden_only
        else:  # no hidden nor file nor dir
            return DirState.empty


def walk(dirname:str) -> iter:
    if hasattr(os, 'scandir'):
        names = (entry.name for entry in os.scandir(dirname))
    else:  # python < 3.5
        names = os.listdir(dirname)
    for name in names:
        yield os.path.join(dirname, name)


if __name__ == "__main__":
    print(DirState.of(sys.argv[1]).value)
