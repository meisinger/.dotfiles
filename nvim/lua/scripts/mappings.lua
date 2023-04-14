local themes = require('telescope.themes')

function bind(op, options)
    options = options or { noremap = true }
    return function(left, right, opts)
        opts = vim.tbl_extend('force', options, opts or {})
        vim.keymap.set(op, left, right, opts)
    end
end

function buffer_bind(op, options)
    options = options or { noremap = true }
    return function(buffer, left, right, opts)
        opts = vim.tbl_extend('force', options, opts or {})
        vim.api.nvim_buf_set_keymap(buffer, op, left, right, opts)
    end
end

local wrap = {}
wrap.nmap = bind('n', { noremap = false })
wrap.vmap = bind('v', { noremap = false })
wrap.nnoremap = bind('n')
wrap.vnoremap = bind('v')
wrap.xnoremap = bind('x')
wrap.inoremap = bind('i')
wrap.lsp_nnoremap = buffer_bind('n')
wrap.lsp_inoremap = buffer_bind('i')

local nmap = wrap.nmap
local vmap = wrap.vmap
local nnoremap = wrap.nnoremap
local vnoremap = wrap.vnoremap
local xnoremap = wrap.xnoremap
local inoremap = wrap.inoremap

nnoremap('Q', '<nop>')
nnoremap('<up>', '<nop>')
nnoremap('<down>', '<nop>')
nnoremap('<left>', '<nop>')
nnoremap('<right>', '<nop>')
-- nnoremap(';', ':')
nnoremap('p', 'gp')
nnoremap('P', 'gP')
nnoremap('Y', 'yg$')
nnoremap('J', 'mzJ`z')

nnoremap('n', 'nzzzv')
nnoremap('N', 'Nzzzv')

nnoremap('<leader>i', '^')
vnoremap('<leader>i', '^')
nnoremap('<leader>n', '$')
vnoremap('<leader>n', '$')
nnoremap('<leader>w', ':bd<cr>')
nnoremap('<leader>l', ':bn!<cr>')
nnoremap('<leader>h', ':bp!<cr>')
nnoremap('<leader>/', ':nohl<cr>')
nnoremap('<C-s>', ':w<cr>')
nnoremap('<M-s>', ':wa<cr>')

nnoremap('<leader>sv', ':vnew<cr>:setlocal buftype=nofile bufhidden=wipe nobuflisted<cr>')

vnoremap('J', ":m '>+1<cr>gv=gv")
vnoremap('K', ":m '<-2<cr>gv=gv")

nmap('<leader>cd', ':cd %:p:h<cr>')
nmap('<leader>s', ':source $MYVIMRC<cr>')
nmap('<leader>e', ':e $MYVIMRC<cr>')

nmap('<leader>y', '"+y')
vmap('<leader>y', '"+y')
nmap('<leader>d', '"_d')
vmap('<leader>d', '"_d')
nmap('<leader>p', '"+p')

xnoremap('<leader>p', '"_dP')

-- something to add later:
-- :bp | sp | bn | bd
--
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
