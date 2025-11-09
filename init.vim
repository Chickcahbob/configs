" Disable compatibility with vi
set nocompatible

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

" Enable undo files
set undofile

" Set undo file directory
let undodir =~/.vim/undodir

" Install plugins
"Install vim-plug if necessary
" https://github.com/junegunn/vim-plug
call plug#begin('~/.config/nvim/plugged')

" List plugins here
Plug 'nvim-lua/plenary.nvim' " don't forget to add this one if you don't have it yet!
Plug 'ThePrimeagen/harpoon'
Plug 'nvim-telescope/telescope.nvim', {'tag': '0.1.8'}
Plug 'mason-org/mason.nvim'

call plug#end()

" Set leader key to <SPACE>
let mapleader = " "

" Harpoon keybindings
nnoremap <Leader>h :lua require("harpoon.mark").add_file() <cr> " Harpoon current file
nnoremap <Leader>g :lua require("harpoon.ui").toggle_quick_menu() <cr> " Open Harpoon menu
nnoremap <Leader>1 :lua require("harpoon.ui").nav_file(1) <cr> " Navigate to page 1
nnoremap <Leader>2 :lua require("harpoon.ui").nav_file(2) <cr> " Navigate to page 2
nnoremap <Leader>3 :lua require("harpoon.ui").nav_file(3) <cr> " Navigate to page 3
nnoremap <Leader>4 :lua require("harpoon.ui").nav_file(4) <cr> " Navigate to page 4

" Telescope keybindings
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
