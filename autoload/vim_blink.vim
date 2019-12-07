if !exists('g:loaded_vim_blink')
  finish
endif
let g:loaded_vim_blink = 1

let s:save_cpo = &cpo
set cpo&vim

if !exists("g:vim_blink_blink_length")
  let g:vim_blink_blink_length = 200
endif
if !exists("g:vim_blink_blink_freq")
  let g:vim_blink_blink_freq = 20
endif
if !exists("g:vim_blink_blink_match_gruop")
  let g:vim_blink_blink_match_gruop = 'VimBlink'
endif

" WARN: gui=reverse is used at search mode
highlight VimBlink gui=reverse ctermfg=233 ctermbg=253
" highlight VimBlinkSearch gui=none ctermfg=7  ctermbg=57  guibg=#5f00ff guifg=#ffffff"
highlight link VimBlinkSearch Normal

let s:blink_match_group_name = g:vim_blink_blink_match_gruop
let s:blink_match_id = 0
let s:blink_timer_id = 0
let s:blink_stop_id = 0

" Toggle the blink highlight. This is called many times repeatedly in order
" to create the blinking effect.
function! s:BlinkToggle(timer_id)
  if s:blink_match_id > 0
    " Clear highlight
    call s:BlinkClear()
  else
    " Set highlight
    let s:blink_match_id = matchadd(s:blink_match_group_name, s:target_pat, 101)
    redraw
  endif
endfunction

" Remove the blink highlight
function! s:BlinkClear()
  call matchdelete(s:blink_match_id)
  let s:blink_match_id = 0
  redraw
endfunction

" Stop blinking
"
" Cancels all the timers and removes the highlight if necessary.
function! s:BlinkStop(timer_id)
  " Cancel timers
  if s:blink_timer_id > 0
    call timer_stop(s:blink_timer_id)
    let s:blink_timer_id = 0
  endif
  if s:blink_stop_id > 0
    call timer_stop(s:blink_stop_id)
    let s:blink_stop_id = 0
  endif
  " And clear blink highlight
  if s:blink_match_id > 0
    call s:BlinkClear()
  endif
endfunction

" augroup vim_blink_die_blinkmatchen
" autocmd!
" autocmd CursorMoved * call s:BlinkStop(0)
" autocmd InsertEnter * call s:BlinkStop(0)
" augroup END

function! vim_blink#blink(pattern, ...)
  let s:blink_match_group_name = get(a:, 1, g:vim_blink_blink_match_gruop)
  let s:target_pat = a:pattern
  " Reset any existing blinks
  call s:BlinkStop(0)
  " Start blinking. It is necessary to call this now so that the match is
  " highlighted initially (in case of large values of a:blink_freq)
  call s:BlinkToggle(0)
  " Set up blink timers.
  let s:blink_timer_id = timer_start(g:vim_blink_blink_freq, function('s:BlinkToggle'), {'repeat': -1})
  let s:blink_stop_id = timer_start(g:vim_blink_blink_length, function('s:BlinkStop'))
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
