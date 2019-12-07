if exists('g:loaded_vim_blink')
    finish
endif
let g:loaded_vim_blink = 1

let s:save_cpo = &cpo
set cpo&vim

let &cpo = s:save_cpo
unlet s:save_cpo
