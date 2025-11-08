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

" Harpoon keybindings
map <Leader>h :lua require("harpoon.mark").add_file() <Enter> " Harpoon current file
map <Leader>t :lua require("harpoon.ui").toggle_quick_menu() <Enter> " Open Harpoon menu
map <Leader>1 :lua require("harpoon.ui").nav_file(1) <Enter> " Navigate to page 1
map <Leader>2 :lua require("harpoon.ui").nav_file(2) <Enter> " Navigate to page 2
map <Leader>3 :lua require("harpoon.ui").nav_file(3) <Enter> " Navigate to page 3
map <Leader>4 :lua require("harpoon.ui").nav_file(4) <Enter> " Navigate to page 4
