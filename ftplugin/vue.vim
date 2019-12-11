if exists('b:plugin_loaded')
  finish
endif

function! vue#IdentifySyntaxRegion()
  let l:line = search('<\(template\|script\|style\|i18n\)[^>]*>', 'bn')
  let l:cline = line('.')
  let l:content = get(getbufline(bufnr('%'), l:line, l:line), '')

  if l:line == l:cline
    return 'html'
  elseif l:content =~ '<style \+lang="sass"[^>]*>'
    return 'sass'
  elseif l:content =~ '<style \+lang="scss"[^>]*>'
    return 'scss'
  elseif l:content =~ '<style \+lang="stylus"[^>]*>'
    return 'stylus'
  elseif l:content =~ '<style[^>]*>'
    return 'css'
  elseif l:content =~ '<script \+lang="ts"[^>]*>'
    return 'typescript'
  elseif l:content =~ '<script[^>]*>'
    return 'javascript'
  elseif l:content =~ '<template \+lang="pug"[^>]*>'
    return 'pug'
  elseif l:content =~ '<i18n>'
    return 'yaml'
  else
    return 'html'
  endif
endfunction

function! vue#SetConfigs()
  let l:type = vue#IdentifySyntaxRegion()

  if l:type == 'html' && &commentstring != '<!-- %s -->'
    setlocal commentstring=<!--\ %s\ -->
  elseif l:type =~ 'css' && &commentstring != '/* %s */'
    setlocal commentstring=/*\ %s\ */
  elseif l:type == 'pug' && &commentstring != '//- %s'
    setlocal commentstring=//-\ %s
  elseif l:type =~ 'typescript\|javascript\|sass\|scss\|stylus' && &commentstring != '// %s'
    setlocal commentstring=//\ %s
  elseif l:type == 'yaml' && &commentstring != '# %s'
    setlocal commentstring=#\ %s
  endif
endfunction

if exists('g:loaded_commentary')
  autocmd CursorMoved,CursorMovedI *.vue call vue#SetConfigs()
endif

nnoremap <silent> <buffer> [[ :call search('^<\(template\<Bar>script\<Bar>style\<Bar>i18n\)', 'bW')<CR>
nnoremap <silent> <buffer> ]] :call search('^<\(template\<Bar>script\<Bar>style\<Bar>i18n\)', 'W')<CR>
nnoremap <silent> <buffer> [] :call search('^</\(template\<Bar>script\<Bar>style\<Bar>i18n\)', 'bW')<CR>
nnoremap <silent> <buffer> ][ :call search('^</\(template\<Bar>script\<Bar>style\<Bar>i18n\)', 'W')<CR>

let b:plugin_loaded = 1
