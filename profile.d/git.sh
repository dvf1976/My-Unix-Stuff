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

# http://library.edgecase.com/git_immersion/lab_11.html
# http://davidwalsh.name/git-aliases

git config --global alias.co checkout
git config --global alias.ci commit
git config --global alias.st status
git config --global alias.br branch
git config --global alias.hist 'log --pretty=format:"%h %ad | %s%d [%an]" --graph --date=short'
git config --global alias.type 'cat-file -t'
git config --global alias.dump 'cat-file -p'

# http://library.edgecase.com/git_immersion/lab_11.html
alias gs='git status '
alias ga='git add '
alias gb='git branch '
alias gc='git commit'
alias gd='git diff'
alias go='git checkout '
alias gk='gitk --all&'
alias gx='gitx --all'

alias got='git '
alias get='git '

