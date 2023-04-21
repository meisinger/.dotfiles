local cmd = vim.cmd
local lsp = vim.lsp

local lspconfig = require("lspconfig")

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    local function mapB(mode, l, r, desc)
        local opts = { noremap = true, silent = true, buffer = bufnr, desc = desc }
        map(mode, l, r, opts)
    end

    -- Mappings.

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    mapB("n", "<leader>rn", lsp.buf.rename, "lsp rename")
    mapB("n", "<leader>gD", lsp.buf.declaration, "lsp goto declaration")
    mapB("n", "<leader>gd", telescope_builtin.lsp_definitions, "lsp goto definition")
    mapB("n", "<leader>gi", telescope_builtin.lsp_implementations, "lsp goto implementation")
    mapB("n", "<leader>f", lsp.buf.format, "lsp format")
    mapB("n", "<leader>gs", telescope_builtin.lsp_document_symbols, "lsp document symbols")
    mapB("n", "<Leader>gws", telescope_builtin.lsp_dynamic_workspace_symbols, "lsp workspace symbols")
    mapB("n", "<leader>ca", lsp.buf.code_action, "lsp code action")

    mapB("n", "K", lsp.buf.hover, "lsp hover")
    mapB("n", "<Leader>gr", telescope_builtin.lsp_references, "lsp references")
    mapB("n", "<leader>sh", lsp.buf.signature_help, "lsp signature")

    if client.server_capabilities.documentFormattingProvider then
        cmd([[
            augroup LspFormatting
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
            augroup END
            ]])
    end
end

local null_ls = require("null-ls")
local spell_check_enabled = false
null_ls.setup({
    sources = {
        null_ls.builtins.formatting.shfmt,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.diagnostics.eslint_d,
        null_ls.builtins.code_actions.eslint_d,
        null_ls.builtins.diagnostics.cspell.with({
            -- Force the severity to be HINT
            diagnostics_postprocess = function(diagnostic)
                diagnostic.severity = diag.severity.HINT
            end,
        }),
        null_ls.builtins.code_actions.cspell,
        null_ls.builtins.code_actions.statix,
        null_ls.builtins.diagnostics.statix,
    },
    on_attach = function(client, bufnr)
        local function mapB(mode, l, r, desc)
            local opts = { noremap = true, silent = true, buffer = bufnr, desc = desc }
            map(mode, l, r, opts)
        end
    end,
})
if not spell_check_enabled then
    null_ls.disable({ name = "cspell" })
end
map("n", "<leader>ss", function()
    if spell_check_enabled then
        null_ls.disable({ name = "cspell" })
        spell_check_enabled = false
    else
        null_ls.enable({ name = "cspell" })
        spell_check_enabled = true
    end
end, { desc = "toggle spell check", noremap = true })

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local servers = { "bashls", "vimls", "rnix", "yamlls", "lua_ls" }
for _, lsp_entry in ipairs(servers) do
    lspconfig[lsp_entry].setup({
        on_attach = on_attach,
        capabilities = capabilities,
        -- after 150ms of no calls to lsp, send call
        -- compare with throttling that is done by default in compe
        -- flags = {
        --   debounce_text_changes = 150,
        -- }
    })
end

local capabilities_no_format = lsp.protocol.make_client_capabilities()
capabilities_no_format.textDocument.formatting = false
capabilities_no_format.textDocument.rangeFormatting = false
capabilities_no_format.textDocument.range_formatting = false

require("lspconfig")["tsserver"].setup({
    on_attach = function(client, buffer)
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false
        on_attach(client, buffer)
    end,
    capabilities = capabilities_no_format,
    cmd = {
        tsserver_path,
        "--stdio",
        "--tsserver-path",
        typescript_path
    }
})

local function buffer_bind(op, options)
    options = options or { noremap = true }
    return function(buffer, left, right, opts)
        opts = vim.tbl_extend('force', options, opts or {})
        vim.api.nvim_buf_set_keymap(buffer, op, left, right, opts)
    end
end

local inoremap = buffer_bind('i')
local nnoremap = buffer_bind('n')

local omni_pid = vim.fn.getpid()
local omni_caps = vim.lsp.protocol.make_client_capabilities()
omni_caps.textDocument.completion.completionItem.snippetSupport = true

local omni_attach = function(client, buffer)
    if client.name == "omnisharp" then
        client.server_capabilities.semanticTokensProvider = {
            full = vim.empty_dict(),
            legend = {
                tokenModifiers = { "static_symbol" },
                tokenTypes = {
                    "comment",
                    "excluded_code",
                    "identifier",
                    "keyword",
                    "keyword_control",
                    "number",
                    "operator",
                    "operator_overloaded",
                    "preprocessor_keyword",
                    "string",
                    "whitespace",
                    "text",
                    "static_symbol",
                    "preprocessor_text",
                    "punctuation",
                    "string_verbatim",
                    "string_escape_character",
                    "class_name",
                    "delegate_name",
                    "enum_name",
                    "interface_name",
                    "module_name",
                    "struct_name",
                    "type_parameter_name",
                    "field_name",
                    "enum_member_name",
                    "constant_name",
                    "local_name",
                    "parameter_name",
                    "method_name",
                    "extension_method_name",
                    "property_name",
                    "event_name",
                    "namespace_name",
                    "label_name",
                    "xml_doc_comment_attribute_name",
                    "xml_doc_comment_attribute_quotes",
                    "xml_doc_comment_attribute_value",
                    "xml_doc_comment_cdata_section",
                    "xml_doc_comment_comment",
                    "xml_doc_comment_delimiter",
                    "xml_doc_comment_entity_reference",
                    "xml_doc_comment_name",
                    "xml_doc_comment_processing_instruction",
                    "xml_doc_comment_text",
                    "xml_literal_attribute_name",
                    "xml_literal_attribute_quotes",
                    "xml_literal_attribute_value",
                    "xml_literal_cdata_section",
                    "xml_literal_comment",
                    "xml_literal_delimiter",
                    "xml_literal_embedded_expression",
                    "xml_literal_entity_reference",
                    "xml_literal_name",
                    "xml_literal_processing_instruction",
                    "xml_literal_text",
                    "regex_comment",
                    "regex_character_class",
                    "regex_anchor",
                    "regex_quantifier",
                    "regex_grouping",
                    "regex_alternation",
                    "regex_text",
                    "regex_self_escaped_character",
                    "regex_other_escape",
                },
            },
            range = true,
        }
    end

    on_attach(client, buffer)
end

lspconfig.omnisharp.setup({
    on_attach = omni_attach,
    capabilities = omni_caps,
    handlers = {
        ["textDocument/definition"] = require('omnisharp_extended').handler,
    },
    cmd = { omnisharp_bin, "--languageserver", "--hostpid", tostring(omni_pid) },
    root_dir = lspconfig.util.root_pattern("*.csproj", "*.sln"),
})
