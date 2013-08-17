export MARKPATH=$HOME/.marks
function jump { 
    cd -P $MARKPATH/$1 2>/dev/null || echo "No such mark: $1"
}
function mark { 
    mkdir -p $MARKPATH; ln -s $(pwd) $MARKPATH/$1
}
function unmark { 
    rm -i $MARKPATH/$1 
}
function marks {
    ls -l $MARKPATH | sed 's/  / /g' | cut -d' ' -f9- | sed 's/ -/\t-/g' && echo
}

function _jump {
    local cur=${COMP_WORDS[COMP_CWORD]}
    local marks=$(find $MARKPATH -type l -printf "%f\n")
    COMPREPLY=($(compgen -W '${marks[@]}' -- "$cur"))
    return 0
}
complete -o default -o nospace -F _jump jump

