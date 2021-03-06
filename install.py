#!/usr/bin/python

import os
import sys
import re
import socket
import shutil

hostname = socket.gethostname()
work_or_personal = 'personal'
if re.match(r'redhat\.com', hostname):
    work_or_personal = 'work'

filetype_to_info_hash = {
    'vimrc' : {
        'src'   : "%s/vimrc" % os.getcwd(),
        'dest'  : "%s/.vimrc" % os.environ['HOME'],
    },
    'dot_vim_directory' : {
        'src'   : "%s/vim" % os.getcwd(),
        'dest'  : "%s/.vim" % os.environ['HOME'],
    },
    'screenrc' : {
        'src'   : "%s/screenrc" % os.getcwd(),
        'dest'  : "%s/.screenrc" % os.environ['HOME'],
    },
    'sshconfig' : {
        'src'   : "%s/ssh_config" % (os.getcwd(),),
        'dest'  : "%s/.ssh/config" % (os.environ['HOME'],),
    },
    'devilspie' : {
        'src'   : '%s/dot_devilspie' % (os.getcwd(),),
        'dest'  : '%s/.devilspie' % (os.environ['HOME'],),
    },
    'conky'     : {
        'src'   : '%s/dot_conkyrc' % (os.getcwd(),),
        'dest'  : '%s/.conkyrc' % (os.environ['HOME'],),
    },
    'todo'      : {
        'src'   : '%s/conf/todo.cfg' % (os.getcwd(),),
        'dest'  : '%s/.todo.cfg' % (os.environ['HOME'],),
    },
    'dot_todo' : {
        'src'   : "%s/dot_todo" % os.getcwd(),
        'dest'  : "%s/.todo" % os.environ['HOME'],
    },
    'synergy'   : {
        'src'   : "%s/conf/synergy_%s.conf" % (os.getcwd(), hostname,),
        'dest'  : "%s/synergy_%s.conf" % (os.environ['HOME'], hostname,)
    },
}

to_copy_hash = {
    'bin'           : {
        'src'   : "%s/bin" % (os.getcwd(),),
        'dest'  : "%s/bin" % (os.environ['HOME'],),
    },
    'autostart'     : {
        'src'   : "%s/autostart" % (os.getcwd(),),
        'dest'  : "%s/.config/autostart" % (os.environ['HOME'],),
    },
}

rpm_array = ['devilspie', 'conky', 'lm_sensors', 'lm_sensors-sensord',]

for filetype in filetype_to_info_hash.keys():
    src = filetype_to_info_hash[filetype]['src']
    dest = filetype_to_info_hash[filetype]['dest']
        
    if os.path.exists(dest) or (os.path.lexists(dest) and not os.path.exists(os.readlink(dest))):
        os.unlink(dest)
    #print '%s :: %s' % (src, dest,)
    os.symlink(src, dest)

bash_profile_append = "%s/bash_profile_append.bash" % os.getcwd()
if not os.popen('/bin/grep My-Unix-Stuff ~/.bashrc').read():
   os.popen('/bin/cat ' + bash_profile_append + ' >> ~/.bashrc')

source_bin_location = "%s/bin/" % (os.getcwd(),)
destination_bin_location = "%s/bin/" % (os.environ['HOME'],)

for to_copy in to_copy_hash.keys():
    src = to_copy_hash[to_copy]['src']
    dest = to_copy_hash[to_copy]['dest']

    if not os.path.exists(dest):
        os.mkdir("%s" % (dest))

    statement = '/bin/cp -ra %s/* %s' % (src, dest,)
    os.popen(statement).read()

os.popen('/bin/chmod a+x %s/*' % (dest,)).read()

os.popen('/bin/chmod 600 %s' % (filetype_to_info_hash['sshconfig']['dest'],)).read()

not_installed_rpm_array = []
for rpm in rpm_array:
    rpm_output = os.popen('sudo rpm -qv %s' % (rpm,)).read()
    if re.search(r'not installed', rpm_output):
        not_installed_rpm_array.append(rpm)

if not_installed_rpm_array:
    os.popen('sudo /usr/bin/yum -y install %s' % (' '.join(not_installed_rpm_array),)).read()