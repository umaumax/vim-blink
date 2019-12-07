# vim-blink

vim plugin to blink word

## how to use
```
:call vim_blink#blink('keyword')

" highlight word before word
:call vim_blink#blink('[^ ]* *\%#')

" highlight current line
:call vim_blink#blink('^.*\%#.*$')

" highlight search word
:call vim_blink#blink(@/)

" highlight curent wearch word
:call vim_blink#blink('\c\%#'.@/)
```

```
nnoremap <silent> n nzz:call vim_blink#blink('\c\%#'.@/,'VimBlinkSearch')<CR>
nnoremap <silent> N Nzz:call vim_blink#blink('\c\%#'.@/,'VimBlinkSearch')<CR>
```

## FMI
* `matchaddpos`?

## FYI
* [vimscript \- Interrupting \(blink\-highlighting\) function if mapping is invoked again \- Vi and Vim Stack Exchange]( https://vi.stackexchange.com/questions/8851/interrupting-blink-highlighting-function-if-mapping-is-invoked-again?noredirect=1 )
* [syntax highlighting \- Set cursor colour different when on a highlighted word \- Vi and Vim Stack Exchange]( https://vi.stackexchange.com/questions/2761/set-cursor-colour-different-when-on-a-highlighted-word )
* [qxxxb/vim\-searchhi: Highlight the current search result differently]( https://github.com/qxxxb/vim-searchhi )
* [vim\-slash/slash\.vim at master · junegunn/vim\-slash]( https://github.com/junegunn/vim-slash/blob/master/plugin/slash.vim )
