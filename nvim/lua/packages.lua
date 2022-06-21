local plugged_path = vim.fn.stdpath('config') .. '/plugged'
local plug = vim.fn['plug#']

vim.call('plug#begin', plugged_path)

plug('flazz/vim-colorschemes')
plug('gruvbox-community/gruvbox')
plug('folke/tokyonight.nvim')

plug('vim-airline/vim-airline')
plug('vim-airline/vim-airline-themes')

plug('sheerun/vim-polyglot')

plug('nvim-lua/plenary.nvim')
plug('nvim-lua/popup.nvim')
plug('nvim-lua/lsp_extensions.nvim')
plug('nvim-telescope/telescope.nvim')
plug('nvim-telescope/telescope-ui-select.nvim')
plug('nvim-telescope/telescope-fzf-native.nvim', {['do'] = 'make' })
plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate' })

plug('neovim/nvim-lspconfig')
plug('hrsh7th/nvim-cmp')
plug('hrsh7th/cmp-nvim-lsp')
plug('hrsh7th/cmp-vsnip')
plug('hrsh7th/cmp-path')
plug('hrsh7th/cmp-buffer')
plug('hrsh7th/vim-vsnip')

vim.call('plug#end')
