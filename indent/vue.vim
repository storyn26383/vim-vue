if exists('b:did_indent')
  finish
endif

let s:languages = ['html', 'pug', 'typescript', 'javascript', 'css', 'sass', 'scss', 'stylus', 'yaml']
let s:indentexpr = {}

for s:language in s:languages
  unlet! b:did_indent

  execute 'runtime! indent/' . s:language . '.vim'

  let s:indentexpr[s:language] = &indentexpr
endfor

let b:did_indent = 1

setlocal indentexpr=vue#GetVueIndent()
setlocal indentkeys=o,O,*<Return>,0],0),0},!^F

if exists("*vue#GetVueIndent")
  finish
endif

function! vue#GetVueIndent()
  execute 'let l:indent = ' . get(s:indentexpr, vue#IdentifySyntaxRegion())

  return l:indent
endfunction
