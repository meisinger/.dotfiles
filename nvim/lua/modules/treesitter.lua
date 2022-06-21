
require('nvim-treesitter.configs').setup {
    sync_install = false,
    ensure_installed = { 
        'lua', 
        'json', 
        'javascript',
        'typescript',
        'python', 
        'vim',
        'dockerfile',
        'css',
        'html',
        'c_sharp',
        'rust'
    },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = 'gnn',
            node_incremental = 'grn',
            scope_incremental = 'grc',
            node_decremental = 'grm'
        }
    }
}
