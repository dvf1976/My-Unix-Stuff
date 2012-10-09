function! WhichTab(filename)
    " http://stackoverflow.com/questions/8839846/vim-check-if-a-file-is-open-in-current-tab-window-and-activate-it
    " Try to determine whether file is open in any tab.  
    " Return number of tab it's open in
    let buffername = bufname(a:filename)
    if buffername == ""
        return 0
    endif
    let buffernumber = bufnr(buffername)

    " tabdo will loop through pages and leave you on the last one;
    " this is to make sure we don't leave the current page
    let currenttab = tabpagenr()
    let tab_arr = []
    tabdo let tab_arr += tabpagebuflist()

    " return to current page
    exec "tabnext ".currenttab

    " Start checking tab numbers for matches
    let i = 0
    for tnum in tab_arr
        let i += 1
        "echo "tnum: ".tnum." buff: ".buffernumber." i: ".i
        if tnum == buffernumber
            return i
        endif
    endfor
endfunction

function MoveTestToScratch()
    execute "normal! ? testMethod\<CR>0f{vaBV_\"ky"

    let scratch_location = $CCM.'/src/classes/scratch_Test.cls'
    let tab_number = WhichTab(scratch_location)
    if tab_number == 0
        tabnew $CCM/src/classes/scratch_Test.cls
    else
        exec "tabnext ".tab_number
    endif

    execute "normal! gg"
    execute "normal! /private\<CR>"
    execute "normal! j"
    execute "normal! dG"
    execute "normal! \"kp"
    execute "normal! G"
    execute "normal! o\<CR>}"
    execute "normal! hx"
    execute "normal! gg"
endfunction