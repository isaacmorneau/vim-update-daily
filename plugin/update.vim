" update.vim
" Author: Isaac Morneau
" Version: 1.0

if exists('g:loaded_update_daily')
    finish
endif
let g:loaded_update_daily = 1

" defaults to '~/.local/share/nvim/lastupdate' for the update file
" and 'PluginUpgrade | PluginUpdate' for the update command to run
" each function can be overriden
function! UpdateDaily(...)
    if a:0 > 0
        let s:update_file = a:1
    else
        let s:update_file = '~/.local/share/nvim/lastupdate'
    endif

    if a:0 > 1
        let s:update_daily = a:2
    else
        let s:update_daily = 'PluginUpgrade | PluginUpdate'
    endif

    if a:0 > 2
        echo 'unknown extra arguments to daily'
    endif

    call s:checkupdates()
endfunction

function! s:run_update()
    execute 'silent !echo ' . s:today . ' > ' . s:update_file
    execute 'autocmd VimEnter * ' . s:update_daily
endfunction

function! s:checkupdates()
    "update once per day
    let s:today = strftime("%Y%m%d") + 0
    if empty(glob(s:update_file, 1))
        call s:run_update()
    else
        let s:savedtime = readfile(glob(s:lastupdate, 1)):0
        if (s:savedtime + 0) < s:today
            call s:run_update()
        endif
    endif
endfunction
