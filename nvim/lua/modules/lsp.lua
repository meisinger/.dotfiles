local lsp = require('lspconfig')
local util = require('lspconfig.util')
local builtin = require('telescope.builtin')
local cmp = require('cmp')
local map = require('modules.keymap')

local nnoremap = map.lsp_nnoremap
local inoremap = map.lsp_inoremap

local caps = vim.lsp.protocol.make_client_capabilities()
caps.textDocument.completion.completionItem.snippetSupport = true

local attach = function(client, buffer)
    inoremap(buffer, '<C-s>', '', {
        callback = vim.lsp.buf.signature_help,
        silent = true
    })
    nnoremap(buffer, '<C-k>', '', {
        callback = vim.lsp.buf.hover,
        silent = true
    })
    nnoremap(buffer, '<leader>ga', '', {
        callback = vim.lsp.buf.code_action,
        silent = true
    })
    nnoremap(buffer, '<leader>gf', '', {
        callback = vim.lsp.buf.formatting,
        silent = true
    })
    nnoremap(buffer, '<leader>gr', '', {
        callback = builtin.lsp_references,
        silent = true
    })
    nnoremap(buffer, '<leader>gd', '', {
        callback = builtin.lsp_definitions,
        silent = true
    })
    nnoremap(buffer, '<leader>gD', '', {
        callback = builtin.diagnostics,
        silent = true
    })
    nnoremap(buffer, '<leader>g[', '', {
        callback = vim.diagnostic.goto_next,
        silent = true
    })
    nnoremap(buffer, '<leader>g]', '', {
        callback = vim.diagnostic.goto_prev,
        silent = true
    })
    --nnoremap(buffer, '<leader>gl', '', {
    --    callback = vim.lsp.buf.codelens.run,
    --    silent = true
    --})
end

lsp.csharp_ls.setup({
    on_attach = attach,
    root_dir = util.root_pattern('*.csproj')
})

lsp.rust_analyzer.setup({
    on_attach = attach,
    capabilities = caps,
    settings = {
        ['rust-analyzer'] = {
            checkOnSave = {
                command = 'clippy'
            }
        }
    }
})

lsp.html.setup({
    on_attach = attach,
    capabilities = caps
})

lsp.cssls.setup({
    on_attach = attach,
    capabilities = caps
})

cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn['vsnip#anonymous'](args.body)
        end,
    },
    mapping = {
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-.>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<cr>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true
        })
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
        { name = 'path' },
        { name = 'buffer' },
    }
})

