if !&compatible
  set nocompatible
endif

" reset augroup
augroup MyAutoCmd
  autocmd!
augroup END

let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir .','. &runtimepath
let s:toml_dir  = '~/.config/nvim'
let s:toml      = s:toml_dir . '/dein.toml'
let s:lazy_toml = s:toml_dir . '/dein_lazy.toml'
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})
  call dein#end()
  call dein#save_state()
endif
if has('vim_starting') && dein#check_install()
  call dein#install()
endif


" Visual
set autoindent
set number
set smartindent
set termguicolors
set title

" Search
set hlsearch
set ignorecase
set inccommand=split
set incsearch
set smartcase
set wrapscan

" Indent
set expandtab
set shiftround
set shiftwidth=2
set smarttab
set softtabstop=0
set tabstop=2
