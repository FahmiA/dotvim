source $VIMRUNTIME/mswin.vim
behave mswin
set nocompatible

" Configure Vundle to manage Pathogen bundles
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'

Plugin 'scrooloose/syntastic'
Plugin 'altercation/vim-colors-solarized'

Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-surround'
Plugin 'bkad/CamelCaseMotion'

Plugin 'mattn/flappyvird-vim'

call vundle#end()

" Set theme
if has('gui_running')
    colorscheme solarized
    set background=light
else
    set background=dark
endif

" Toogle theme on F5
call togglebg#map("<F5>")

" Set fonts
if has("gui_running")
  if has("gui_gtk2")
    set guifont=Hack\ 11
  endif
endif

" Removing the annoying print option from the gvim toolbar
if has('gui_running')
    :aunmenu ToolBar.Print
endif

" Turn on syntax highlighting
syntax enable

" Syntax highlighting extensions
autocmd BufNewFile,BufRead *.json set ft=javascript
autocmd BufNewFile,BufRead .jshintrc set ft=javascript
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" Various tabbing options for writing code
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set expandtab
set autoindent
filetype plugin indent on

" Set spell-check language
set spelllang=en_nz

" Spell-check git commits.
autocmd BufNewFile,BufRead COMMIT_EDITMSG set spell

" Spell-check subversion commits.
autocmd FileType svn setlocal spell

" Show line numbers
set number

" cd to current directory
set autochdir

" Highlight search terms
set hlsearch

" Highlight current line
if has('gui_running')
    set cursorline
endif

" Omnicomplete (like intellisense)
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

" Make Ctrl+] do a wildcard tag match, not an exact tag match
nnoremap <c-]> g<c-]>
vnoremap <c-]> g<c-]>
nnoremap g<c-]> <c-]>
vnoremap g<c-]> <c-]>

" Launch MRU (most recently used files list)
map <leader>f :CtrlPMRU<CR>

" Configure Syntastic with JsHint
let g:syntastic_javascript_checkers = ['jshint']

" Configure CamelCaseMotion
call camelcasemotion#CreateMotionMappings('<leader>')

" Disable arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" Correct :Wq typo for :wq
command W w
command Q q
command Wq wq
command WQ wq

" Ignore some folders for file search
set wildignore+=node_modules,bower_components,target,build

" Functions to rearrange tabs
function TabLeft()
    let tab_number = tabpagenr() - 1
    if tab_number == 0
        execute "tabm" tabpagenr('$') - 1
    else
        execute "tabm" tab_number - 1
    endif
endfunction

function TabRight()
    let tab_number = tabpagenr() - 1
    let last_tab_number = tabpagenr('$') - 1
    if tab_number == last_tab_number
        execute "tabm" 0
    else
        execute "tabm" tab_number + 1
    endif
endfunction

map <silent><C-J> :execute TabLeft()<CR>
map <silent><C-K> :execute TabRight()<CR>
