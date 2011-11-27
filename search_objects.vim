" Vim global plugin file
" Description:	search_objects provides some nice feature.
" Maintainer:	Israel Chauca F. <israelchauca@gmail.com>
" Version:	0.1
" Last Change:	Sun Nov 27 17:23:53 2011
" License:	Vim License (see :help license)
" Location:	plugin/search_object.vim

if exists("g:loaded_search_objects")
"      \ || v:version < 700 || &compatible
  finish
endif
let g:loaded_search_objects = 1

" Allow use of line continuation.
let s:save_cpo = &cpo
set cpo&vim

" What should we put here?
"
function! s:get_object(...)
  let cur = getpos('.')
  let last = [0] + searchpos(@/, 'ecW') + [0]
  let first = [0] + searchpos(@/, 'bcnW') + [0]
  echom string(first).':'.string(last)
  if first != [0,0,0,0] && last != [0,0,0,0]
    call setpos("'[", (a:0 ? cur : first))
    call setpos("']", last)
    let cmd = "`[v`]"
  else
    let cmd = ""
  endif
  echom cmd
  return cmd
endfunction
vnore <expr><Plug>SearchObjA ":\<C-U>silent! normal! ".<SID>get_object()."\<CR>"
vnore <expr><Plug>SearchObjI ":\<C-U>silent! normal! ".<SID>get_object(1)."\<CR>"
onore <expr><Plug>SearchObjA ":\<C-U>silent! normal! ".<SID>get_object()."\<CR>"
onore <expr><Plug>SearchObjI ":\<C-U>silent! normal! ".<SID>get_object(1)."\<CR>"

if !exists('<Plug>SearchObjA', 'v')
  vmap <silent>a/ <Plug>SearchObjA
endif
if !exists('<Plug>SearchObjI', 'v')
  vmap <silent>i/ <Plug>SearchObjI
endif
if !exists('<Plug>SearchObjA', 'o')
  omap <silent>a/ <Plug>SearchObjA
endif
if !exists('<Plug>SearchObjI', 'o')
  omap <silent>i/ <Plug>SearchObjI
endif


let &cpo = s:save_cpo
unlet s:save_cpo

" vim: et sw=2
