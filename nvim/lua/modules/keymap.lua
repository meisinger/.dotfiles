
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
return wrap
