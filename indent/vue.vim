if exists('b:did_indent')
  finish
endif

let b:did_indent = 1

setlocal autoindent
setlocal indentexpr=vue#GetVueIndent()
setlocal indentkeys=o,O,*<Return>,0],0),0},!^F

if exists("*vue#GetVueIndent")
  finish
endif

function! vue#GetVueIndent()
  let lnum = prevnonblank(v:lnum - 1)

  if lnum == 0
    return 0
  endif

  let line = substitute(substitute(getline(lnum), '\s\+$', '', ''), '^\s\+', '', '')
  let cline = substitute(substitute(getline(v:lnum), '\s\+$', '', ''), '^\s\+', '', '')
  let indent = indent(lnum)
  let increase = indent + &sw
  let decrease = indent - &sw

  if line =~ '[{([]$' && cline =~ '^[})\]]'
    return indent
  elseif cline =~ '^[})\]]'
    return decrease
  elseif line =~ '[{([]$'
    return increase
  elseif synIDattr(synID(lnum, indent, 1), 'name') == 'pugBegin'
    if line =~ '^\(|\|meta\|link\|img\|hr\|br\|input\)[#.(]\?'
      return indent
    else
      return increase
    endif
  elseif line =~ '^<[a-z0-9-]\+[^>]*>$' && cline =~ '^</[a-z0-9-]\+>$'
    return indent
  elseif cline =~ '^</[a-z0-9-]\+>$'
    return decrease
  elseif line =~ '^<[a-z0-9-]\+[^>]*>$'
    if line =~ '^<\(meta\|link\|img\|hr\|br\|input\)[^>]*>$' || line =~ '^<[^>]\+/>$'
      return indent
    else
      return increase
    endif
  else
    return indent
  endif
endfunction
