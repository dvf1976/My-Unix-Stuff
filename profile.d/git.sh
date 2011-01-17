git config --global color.ui "auto"
git config --global user.name "Daniel Fisher"
git config --global user.email "dan@askingforthirds.org"
hostname=`/bin/hostname`
if [[ $hostname =~ 'redhat.com' ]]
then
    echo 'on redhat host'
    git config --global user.email "dfisher@redhat.com"
fi

# http://library.edgecase.com/git_immersion/lab_01.html
git config --global core.autocrlf input
git config --global core.safecrlf true

