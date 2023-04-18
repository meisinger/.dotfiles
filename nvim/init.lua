require('startup')
require('impatient').enable_profile()

vim.g.do_filetype_lua = 1
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.cmd [[
runtime! lua/packages.lua
runtime! lua/modules/options.lua
runtime! lua/modules/telescope.lua
runtime! lua/modules/treesitter.lua
runtime! lua/modules/mappings.lua
runtime! lua/modules/autocmd.lua
runtime! lua/modules/lsp.lua

colorscheme tokyonight
]]

vim.opt.background = 'dark'

vim.g.gruvbox_contrast_dark = 'hard'
vim.g.gruvbox_invert_selection = '0'
vim.g.tokyonight_transparent_sidebar = true
vim.g.netrw_fastbrowse = 0

vim.api.nvim_set_hl(0, 'LineNR', { fg = '#4e4e4e' })
vim.api.nvim_set_hl(0, 'Cursor', { bg = 'green', fg = 'green' })
vim.api.nvim_set_hl(0, 'iCursor', { bg = 'blue', fg = 'blue' })
vim.api.nvim_set_hl(0, 'lCursor', { bg = 'none', fg = 'none' })
vim.api.nvim_set_hl(0, 'TermCursor', { bg = 'none', fg = 'none' })
vim.api.nvim_set_hl(0, 'CursorLineNR', { bg = 'none' })
vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'none' })
vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })

