git config --global color.ui "auto"
git config --global user.name "Daniel Fisher"
git config --global user.email "dan@askingforthirds.org"
hostname=`/bin/hostname`
if [[ $hostname =~ 'redhat.com' ]]
then
    echo 'on redhat host'
    git config --global user.email "dfisher@redhat.com"
fi
    

