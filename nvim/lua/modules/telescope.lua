local map = require('modules.keymap')
local themes = require('telescope.themes')

local nmap = map.nmap
local vmap = map.vmap
local nnoremap = map.nnoremap
local vnoremap = map.vnoremap
local xnoremap = map.xnoremap
local inoremap = map.inoremap

require('telescope').setup {
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = 'smart_case'
        },
        file_browser = {
            theme = "ivy",
            hijack_netrw = true,
        },
        ['ui-select'] = {
            themes.get_dropdown {
            }
        }
    },
    pickers = {
        find_files = {
            theme = "ivy"
        }
    },
}

require('telescope').load_extension('fzf')
require('telescope').load_extension('ui-select')
require('telescope').load_extension('file_browser')
-- require('telescope').load_extension('lazygit')

nnoremap('<C-p>', ':Telescope find_files<cr>')
nnoremap('<C-t>', ':Telescope lsp_dynamic_workspace_symbols<cr>')
nnoremap('<leader>fb', ':Telescope file_browser<cr>')
nnoremap('<leader>ff', ':Telescope current_buffer_fuzzy_find<cr>')
nnoremap('<leader><Tab>', ':Telescope buffers<cr>')
