if exists('b:did_indent')
  finish
endif

let b:did_indent = 1

setlocal indentexpr=vue#GetVueIndent()

if exists("*vue#GetVueIndent")
  finish
endif

function! vue#GetVueIndent()
  let l:language = vue#IdentifySyntaxRegion()

  if l:language ==# 'css'
    let l:language = 'scss'
  endif

  unlet! b:did_indent

  execute 'runtime! indent/' . l:language . '.vim'

  return &indentexpr
endfunction
