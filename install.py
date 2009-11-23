#!/usr/bin/python

import os

vimrc_location = "%s/vimrc" % os.getcwd()
dot_vimrc_location = "%s/.vimrc" % os.environ['HOME']

if os.path.exists(dot_vimrc_location):
    os.unlink(dot_vimrc_location) 
#print vimrc_location + "\n" + dot_vimrc_location
os.symlink(vimrc_location, dot_vimrc_location)

