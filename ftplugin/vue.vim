if exists('b:plugin_loaded') || !exists('g:loaded_commentary')
  finish
endif

function! vue#IdentifySyntaxRegion()
  let l:syntax = synIDattr(synID(prevnonblank(line('.')), col('.'), 0), 'name')

  if l:syntax =~ '^pug'
    return 'pug'
  elseif l:syntax =~ '^\(js\|javaScript\)'
    return 'js'
  elseif l:syntax =~ '^\(css\|scss\)'
    return 'css'
  else
    return 'html'
  endif
endfunction

function! vue#SetConfigs()
  let l:type = vue#IdentifySyntaxRegion()

  if l:type == 'html' && &commentstring != '<!-- %s -->'
    setlocal commentstring=<!--\ %s\ -->
  elseif l:type == 'pug' && &commentstring != '//- %s'
    setlocal commentstring=//-\ %s
  elseif l:type =~ 'js\|css' && &commentstring != '// %s'
    setlocal commentstring=//\ %s
  endif
endfunction

autocmd CursorMoved,CursorMovedI * call vue#SetConfigs()

let b:plugin_loaded = 1
