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
        ['ui-select'] = {
            themes.get_dropdown {
            }
        }
    },
}

require('telescope').load_extension('fzf')
require('telescope').load_extension('ui-select')

nnoremap('<C-p>', '<cmd>lua require("telescope.builtin").find_files()<cr>')
nnoremap('<C-t>', '<cmd>lua require("telescope.builtin").lsp_dynamic_workspace_symbols()<cr>')

