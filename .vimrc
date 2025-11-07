" Disable compatibility with vi
set nocompatible

" Disable file detection prior to adding plugins
filetype off

" Set leader key to <SPACE>
let mapleader = " "

" Install plugins
" Install vim-plug if necessary
" https://github.com/junegunn/vim-plug
call plug#begin()

" List plugins here
Plug 'nvim-lua/plenary.nvim' " don't forget to add this one if you don't have it yet!
Plug 'ThePrimeagen/harpoon'

call plug#end()

" Re-enable filetypes
filetype on

" Enable filetype plugins
filetype plugin on

" Load files for filetype
filetype indent on

" Enable syntax highlighting
syntax on

" Add numbers to left
set number

" Set relative number
set relativenumber

" Highlight cursor line
set cursorline

" Set shift to 4 spaces
set shiftwidth=4

" Set tab width to 4 columns
set tabstop=4

" Use space instead of tab
set expandtab

" Do not save backup files
set nobackup

" Set scroll buffer
set scrolloff=10

" Do not wrap lines
set nowrap

" Enable incremental search
set incsearch

" Ignore case while searching
set ignorecase

" Override ignore case when searching with capital letters
set smartcase

" Show partial command
set showcmd

" Show the current mode
set showmode

" Show matching words to search
set showmatch

" Set comand history to 1000
set history=1000

" Enable auto completion menu after pressing tab
set wildmenu

" Make wildmenu befave similar to Bash completion
set wildmode=list:longest

" Put plugins and dictionaries in this directory
let vimDir = "$HOME/.vim"

if stridx(&runtimepath, expand(vimDir)) == -1
  " Add vimDir to runtime path if it is not already there
  let &runtimepath=','.vimDir
endif

" Keep undo history across sessions and store in vimDir
if has('persistent_undo')
  let myUndoDir = expand(vimDir . '/undodir')
  " Create directories
  call system('mkdir ' . vimDir)
  call system('mkdir ' . myUndoDir)
  let &undodir = myUndoDir
  set undofile
endif
