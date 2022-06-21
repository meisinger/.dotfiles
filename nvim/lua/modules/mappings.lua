local map = require('modules.keymap')
local nmap = map.nmap
local vmap = map.vmap
local nnoremap = map.nnoremap
local vnoremap = map.vnoremap
local xnoremap = map.xnoremap
local inoremap = map.inoremap

nnoremap('Q', '<nop>')
nnoremap('<up>', '<nop>')
nnoremap('<down>', '<nop>')
nnoremap('<left>', '<nop>')
nnoremap('<right>', '<nop>')
nnoremap(';', ':')
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
