#!/usr/bin/python

import os
import sys
import re
import socket

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
        'ttree' : {
            'cfg'   : '%s/ttree/%s' % (os.getcwd(),work_or_personal),
            'src'   : '%s/tmpl/devilspie' % (os.getcwd(),),
            'dest'  : '%s/dot_devilspie' % (os.getcwd(),),
        },
    },
    'conky'     : {
        'src'   : '%s/dot_conkyrc' % (os.getcwd(),),
        'dest'  : '%s/.conkyrc' % (os.environ['HOME'],),
    },
}
rpm_array = ['devilspie','conky','perl-Template-Toolkit',]

for filetype in filetype_to_info_hash.keys():
    src = filetype_to_info_hash[filetype]['src']
    dest = filetype_to_info_hash[filetype]['dest']
    if filetype_to_info_hash[filetype].has_key('ttree'):
        cfg = filetype_to_info_hash[filetype]['ttree']['cfg']
        src = filetype_to_info_hash[filetype]['ttree']['src']
        dest = filetype_to_info_hash[filetype]['ttree']['dest']
        statement = '/usr/bin/ttree -f %s --src="%s" --dest="%s"' % (cfg,src,dest,)
        output = os.popen(statement).read()
        
    if os.path.exists(dest) or (os.path.lexists(dest) and not os.path.exists(os.readlink(dest))):
        os.unlink(dest)
    os.symlink(src, dest)

bash_profile_append = "%s/bash_profile_append.bash" % os.getcwd()
if not os.popen('/bin/grep My-Unix-Stuff ~/.bashrc').read():
   os.popen('/bin/cat ' + bash_profile_append + ' >> ~/.bashrc')

if not os.path.exists(destination_bin_location):
    os.mkdir("%s" % (destination_bin_location,))

source_bin_location = "%s/bin/" % (os.getcwd(),)
destination_bin_location = "%s/bin/" % (os.environ['HOME'],)

copy_bin_command_template = "/bin/cp %s* %s"
copy_bin_command = copy_bin_command_template % (source_bin_location, destination_bin_location,)

os.popen(copy_bin_command).read()
os.popen('/bin/chmod a+x %s/*' % (destination_bin_location,)).read()

os.popen('/bin/chmod 600 %s' % (filetype_to_info_hash['sshconfig']['dest'],)).read()

not_installed_rpm_array = []
for rpm in rpm_array:
    rpm_output = os.popen('rpm -qv %s' % (rpm,)).read()
    if re.match(r'not installed', rpm_output):
        not_installed_rpm_array.append(rpm)

if not_installed_rpm_array:
    os.popen('su -c "/usr/bin/yum -y install %s"' % (' '.join(not_installed_rpm_array),)).read()
