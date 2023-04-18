local o = vim.opt
local wo = vim.wo

o.encoding = "UTF-8"
o.guicursor = "n-v-c-sm:block-Cursor,i-ci-ve:block-iCursor,r-cr-o:hor20"
o.termguicolors = true

o.number = true
o.relativenumber = true
o.signcolumn = "yes"

o.showmode = true
o.hidden = true
o.errorbells = false
o.lazyredraw = true
o.hlsearch = false
o.incsearch = true
o.expandtab = true
o.smartindent = true
o.shiftround = true

o.backup = false
o.swapfile = false
o.wrap = false
o.showmatch = false

o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.scrolloff = 6
o.cmdheight = 1

o.updatetime = 50
o.shortmess:append("c")
o.isfname:append("@-@")

o.completeopt = 'menuone,noinsert,noselect'

o.foldenable = false
o.foldlevel = 99
wo.foldmethod = "expr"
wo.foldexpr = "nvim_treesitter#foldexpr()"

require('nvim-tree').setup()
