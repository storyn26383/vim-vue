if exists('b:current_syntax')
  finish
endif

runtime! syntax/html.vim
unlet! b:current_syntax

silent! syntax include @pug syntax/pug.vim
unlet! b:current_syntax

silent! syntax include @css syntax/css.vim
unlet! b:current_syntax

silent! syntax include @sass syntax/sass.vim
unlet! b:current_syntax

silent! syntax include @scss syntax/scss.vim
unlet! b:current_syntax

silent! syntax include @stylus syntax/stylus.vim
unlet! b:current_syntax

silent! syntax include @javascript syntax/javascript.vim
unlet! b:current_syntax

silent! syntax include @typescript syntax/typescript.vim
unlet! b:current_syntax

silent! syntax include @yaml syntax/yaml.vim
unlet! b:current_syntax

syntax keyword htmlTagName contained template i18n router
syntax keyword htmlArg contained lang scoped functional
syntax keyword htmlArg contained ref slot
syntax match   htmlTagName "[-0-9a-zA-Z]" contained
syntax match   htmlArg "[@v:]\?[-:.0-9_a-z]" contained

syntax region  vueTagName contained start=/<\/\?\(template\|script\|style\|i18n\|router\)/ end=/>/ contains=htmlTagN,htmlTagName,htmlArg,htmlString fold

syntax region  vueTemplate keepend start=/<template \+lang="pug"[^>]*>/ end=/<\/template>/ contains=@pug,vueTagName fold
syntax region  vueScript keepend start=/<script[^>]*>/ end=/<\/script>/ contains=@javascript,vueTagName fold
syntax region  vueScript keepend start=/<script \+lang="ts"[^>]*>/ end=/<\/script>/ contains=@typescript,vueTagName fold
syntax region  vueStyle keepend start=/<style[^>]*>/ end=/<\/style>/ contains=@css,vueTagName fold
syntax region  vueStyle keepend start=/<style \+lang="sass"[^>]*>/ end=/<\/style>/ contains=@sass,vueTagName fold
syntax region  vueStyle keepend start=/<style \+lang="scss"[^>]*>/ end=/<\/style>/ contains=@scss,vueTagName fold
syntax region  vueStyle keepend start=/<style \+lang="stylus"[^>]*>/ end=/<\/style>/ contains=@stylus,vueTagName fold
syntax region  vueI18n keepend start=/<i18n>/ end=/<\/i18n>/ contains=@yaml,vueTagName fold
syntax region  vueRouter keepend start=/<router>/ end=/<\/router>/ contains=@yaml,vueTagName fold

let b:current_syntax = 'vue'
