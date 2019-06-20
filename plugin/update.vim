" update.vim
" Author: Isaac Morneau
" Version: 1.1
" defaults:
" g:update_file '~/.local/share/nvim/lastupdate' for the update file
" g:update_daily 'PlugUpgrade | PlugUpdate' for the update command to run
" g:update_open_with_args for the check for arguments

if exists('g:loaded_update_daily')
    finish
endif
let g:loaded_update_daily = 1

function! s:run_update()
    "theres no way to do this from within vimscript nicely and it wont work on
    "windows
    "what it does is only run the update if vim or nvim was provided no
    "arguments. this prevents the annoying update when you are trying to
    "quickly edit a file
    if !exists('g:update_noargs')
        let g:update_noargs = 0
    endif

    if !exists('g:update_open_with_args')
        let g:update_open_with_args = 0
    endif
    if g:update_open_with_args || len(split(system("ps -o command= -p ".getpid()))) == 1
        execute 'silent !echo ' . s:today . ' > ' . g:update_file
        execute 'autocmd VimEnter * ' . g:update_daily
    endif
endfunction

function! s:checkupdates()
    if !exists('g:update_file')
        let g:update_file = '~/.local/share/nvim/lastupdate'
    endif
    if !exists('g:update_daily')
        let g:update_daily = 'PlugUpgrade | PlugUpdate'
    endif
    "update once per day
    let s:today = strftime("%Y%m%d") + 0
    if empty(glob(g:update_file, 1))
        call s:run_update()
    else
        let s:savedtimes = readfile(glob(g:update_file, 1))
        let s:savedtime = s:savedtimes[0]
        if (s:savedtime + 0) < s:today
            call s:run_update()
        endif
    endif
endfunction
call s:checkupdates()

