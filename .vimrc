" Normally this if-block is not needed, because `:set nocp` is done
" automatically when .vimrc is found. However, this might be useful
" when you execute `vim -u .vimrc` from the command line.
if &compatible
  " `:set nocp` has many side effects. Therefore this should be done
  " only when 'compatible' is set.
  set nocompatible
endif

function! PackInit() abort
  " Start and update minipac package manager
  packadd minpac
  call minpac#init()
  call minpac#add('k-takata/minpac', {'type': 'opt'})

  " Project management
  call minpac#add('scrooloose/nerdtree')
  call minpac#add('ctrlpvim/ctrlp.vim')
  call minpac#add('vimwiki/vimwiki')

  " Text commands
  call minpac#add('scrooloose/nerdcommenter')
  call minpac#add('tpope/vim-surround')
  call minpac#add('bkad/CamelCaseMotion')
  call minpac#add('wellle/targets.vim')

  " Syntax highlighting
  call minpac#add('scrooloose/syntastic')

  " Theme
  call minpac#add('lifepillar/vim-solarized8')

  " ES6 & TypeScript support
  call minpac#add('jelera/vim-javascript-syntax')
  call minpac#add('leafgarland/typescript-vim')
  call minpac#add('Shougo/vimproc.vim')
  call minpac#add('Quramy/tsuquyomi')
endfunction

" Define user commands for updating/cleaning the plugins.
" Each of them calls PackInit() to load minpac and register
" the information of plugins, then performs the task.
command! PackUpdate call PackInit() | call minpac#update()
command! PackClean  call PackInit() | call minpac#clean()
command! PackStatus packadd minpac | call minpac#status()

" Syntax highlighting
syntax enable

" Colour scheme: https://github.com/lifepillar/vim-solarized8
set termguicolors
set background=light
autocmd vimenter * ++nested colorscheme solarized8

" Toogle colour scheme on F5
function! ToggleBackground()
  if &background == "dark"
    set background=light
  else
    set background=dark
  endif
endfunction
nnoremap <F5> :call ToggleBackground()<CR>

" Set fonts
if has("gui_running")
  if has("gui_gtk2")
    set guifont=Hack\ 11
  endif
endif

" Hide the toolbar
set guioptions-=T  "toolbar

" Syntax highlighting extensions
autocmd BufNewFile,BufRead .eslintrc set ft=javascript
autocmd BufNewFile,BufRead .npmrc set ft=dosini
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd BufNewFile,BufReadPost *.ts set filetype=typescript

" Various tabbing options for writing code
set tabstop=2
set shiftwidth=2
set softtabstop=2
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

" Make double-<Esc> clear search highlights
nnoremap <silent> <Esc><Esc> <Esc>:nohlsearch<CR><Esc>

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

" NERDTree
map <leader>r :NERDTreeFind<cr>

" ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
map <leader>f :CtrlPMRU<cr>

" Configure Syntastic with linters
let g:syntastic_yaml_checkers = ['yamllint']

" Configure CamelCaseMotion
let g:camelcasemotion_key = '<leader>'

" VimWiki

let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': 'md'}]
let g:vimwiki_global_ext = 0

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
set wildignore+=node_modules,bower_components,target,build,dist

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

" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Disable bracketed paste mode
set t_BE=

" Organise backup directories
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//

