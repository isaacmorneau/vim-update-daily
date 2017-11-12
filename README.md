# vim-update-daily
A little plugin to allow easy plugin updates

This was created to automatically update [vim-plug](https://github.com/junegunn/vim-plug) once a day to keep those great plugins up to date.

#Configuration
There are only two variables for how it should update right now `g:update_file` and `g:update_daily`.

The first handles where to store the file to log when the last update happened while the second is what command to run.
To change either of them simply by initializing them to a diffent path or command.

The defaults are as follows:

```
let g:update_file = '~/.local/share/nvim/lastupdate'
let g:update_daily = 'PlugUpgrade | PlugUpdate'
```

While this was designed for vim-plug if you change the command it runs it can easily update any other plugin manager
