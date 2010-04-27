#!/usr/bin/python

import os

vimrc_location = "%s/vimrc" % os.getcwd()
dot_vimrc_location = "%s/.vimrc" % os.environ['HOME']

screenrc_location = "%s/screenrc" % os.getcwd()
dot_screenrc_location = "%s/.screenrc" % os.environ['HOME']

source_sshconfig_location = "%s/ssh_config" % (os.getcwd(),)
destination_sshconfig_location = "%s/.ssh/config" % (os.environ['HOME'],)

source_bin_location = "%s/bin/" % (os.getcwd(),)
destination_bin_location = "%s/bin/" % (os.environ['HOME'],)

bash_profile_append = "%s/bash_profile_append.bash" % os.getcwd()

if os.path.exists(dot_vimrc_location) or (os.path.lexists(dot_vimrc_location) and not os.path.exists(os.readlink(dot_vimrc_location))):
    os.unlink(dot_vimrc_location)
os.symlink(vimrc_location, dot_vimrc_location)

if os.path.exists(dot_screenrc_location) or (os.path.lexists(dot_screenrc_location) and not os.path.exists(os.readlink(dot_screenrc_location))):
    os.unlink(dot_screenrc_location)
os.symlink(screenrc_location, dot_screenrc_location)

if os.path.exists(destination_sshconfig_location) or (os.path.lexists(destination_sshconfig_location) and not os.path.exists(os.readlink(destination_sshconfig_location))):
    os.unlink(destination_sshconfig_location)
os.symlink(source_sshconfig_location, destination_sshconfig_location)

if not os.popen('/bin/grep My-Unix-Stuff ~/.bashrc').read():
   os.popen('/bin/cat ' + bash_profile_append + ' >> ~/.bashrc')

if not os.path.exists(destination_bin_location):
    os.mkdir("%s" % (destination_bin_location,))

copy_bin_command_template = "/bin/cp %s* %s"
copy_bin_command = copy_bin_command_template % (source_bin_location, destination_bin_location,)

os.popen(copy_bin_command).read()
os.popen('/bin/chmod o+x %s/*' % (destination_bin_location,)).read()

os.popen('/bin/chmod 600 %s' % (destination_sshconfig_location,)).read()

