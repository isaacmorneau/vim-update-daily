" update.vim
" Author: Isaac Morneau
" Version: 1.0
" defaults:
" g:update_file '~/.local/share/nvim/lastupdate' for the update file
" g:update_daily 'PluginUpgrade | PluginUpdate' for the update command to run

if exists('g:loaded_update_daily')
    finish
endif
let g:loaded_update_daily = 1

function! s:run_update()
    execute 'silent !echo ' . s:today . ' > ' . g:update_file
    execute 'autocmd VimEnter * ' . g:update_daily
endfunction

function! s:checkupdates()
    if !exists('g:update_file')
        let g:update_file = '~/.local/share/nvim/lastupdate'
    endif
    if !exists('g:update_daily')
        let g:update_daily = 'PluginUpgrade | PluginUpdate'
    endif
    "update once per day
    let s:today = strftime("%Y%m%d") + 0
    if empty(glob(g:update_file, 1))
        call s:run_update()
    else
        let s:savedtime = readfile(glob(g:update_file, 1)):0
        if (s:savedtime + 0) < s:today
            call s:run_update()
        endif
    endif
endfunction
autocmd VimEnter * s:checkupdates

