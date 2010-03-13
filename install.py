#!/usr/bin/python

import os

vimrc_location = "%s/vimrc" % os.getcwd()
dot_vimrc_location = "%s/.vimrc" % os.environ['HOME']

screenrc_location = "%s/screenrc" % os.getcwd()
dot_screenrc_location = "%s/.screenrc" % os.environ['HOME']

if os.path.exists(dot_vimrc_location) or (os.path.lexists(dot_vimrc_location) and not os.path.exists(os.readlink(dot_vimrc_location))):
    os.unlink(dot_vimrc_location)
os.symlink(vimrc_location, dot_vimrc_location)

if os.path.exists(dot_screenrc_location) or (os.path.lexists(dot_screenrc_location) and not os.path.exists(os.readlink(dot_screenrc_location))):
    os.unlink(dot_screenrc_location)
os.symlink(screenrc_location, dot_screenrc_location)

