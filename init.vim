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
set undodir =~/.vim/undodir

" Send file name being edited to tmux
autocmd BufReadPost,FileReadPost,BufNewFile * call system("tmux rename-window " . expand("%:t"))

" Install plugins
"Install vim-plug if necessary
" https://github.com/junegunn/vim-plug
call plug#begin('~/.config/nvim/plugged')

" List plugins here

" Plenary required for harpoon and telescope
Plug 'nvim-lua/plenary.nvim' " don't forget to add this one if you don't have it yet!

" Harpoon to quickly navigate
Plug 'ThePrimeagen/harpoon'

" Telescope for fuzzy find
Plug 'nvim-telescope/telescope.nvim', {'tag': '0.1.8'}

" Treesitter for enhanced syntax highlighting
Plug 'nvim-treesitter/nvim-treesitter'

" Required for mason LSP
Plug 'mason-org/mason.nvim'
Plug 'neovim/nvim-lspconfig'

" Install mason LSP
Plug 'mason-org/mason-lspconfig.nvim'

" Autocomplete
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'

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

lua << EOF

vim.lsp.config('*', {
    capabilities = vim.lsp.protocol.make_client_capabilities()
})

require('mason').setup()

require('nvim-treesitter.configs').setup{
    ensure_installed = { 'c', 'lua', 'rust' },
    auto_install = true,

    highlight = {

        enable = true,
        additional_vim_regex_highlightin = false,

    },
}

require('mason-lspconfig').setup{
    ensure_installed = { 'clangd', 'lua_ls', 'rust_analyzer' }
}

 -- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)

        -- For `mini.snippets` users:
        -- local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
        -- insert({ body = args.body }) -- Insert at cursor
        -- cmp.resubscribe({ "TextChangedI", "TextChangedP" })
        -- require("cmp.config").set_onetime({ sources = {} })
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
  -- Set configuration for specific filetype.
  --[[ cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' },
    }, {
      { name = 'buffer' },
    })
 })
 require("cmp_git").setup() ]]--

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  vim.lsp.config('<YOUR_LSP_SERVER>', {
    capabilities = capabilities
  })
  vim.lsp.enable('<YOUR_LSP_SERVER>')

-- TODO: Override vim deprecate function, remove later when lsp pluggin is updated
vim.deprecate = (function(overriden)
  return function(_, _, _, xx)
    if xx == 'nvim-lspconfig' then return end
    return overriden(_, _, _, xx)
  end
end)(vim.deprecate)

EOF
