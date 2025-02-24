local utils = {}
local extension = {}

utils.split = function (str, delm)

    local result = {}
    local count = 1

    local d_from, d_to = string.find(str, delm, 1)

    while d_from do
        table.insert(result, string.sub(str, count, d_from - 1))
        count = d_to + 1
        d_from, d_to = string.find(str, delm, count)
    end

    table.insert(result, string.sub(str, count))
    return result
end

utils.get_or_create_buf = function (name)
    local list = vim.api.nvim_list_bufs()
    for _, entry in pairs(list) do
        local buf_name = vim.api.nvim_buf_get_name(entry)
        if string.find(name, "^/%$metadata%$/.*$") then
            local normalized_buf_name = string.gsub(buf_name, "\\", "/")
            if string.find(normalized_buf_name, name) then
                return entry
            end
        else
            if buf_name == name then
                return entry
            end
        end
    end

    local bufnr = vim.api.nvim_create_buf(true, true)
    vim.api.nvim_buf_set_name(bufnr, name)

    return bufnr
end

utils.hex_to_char = function (hex)
    return string.char(tonumber(hex, 16))
end

utils.url_decode = function (uri)
    if uri == nil then
        return
    end

    uri = uri:gsub("+", " ")
    uri = uri:gsub("%%(%x%x)", utils.hex_to_char)
    return uri
end

utils.set_quickfix_list_locations = function (locations)
    local list = vim.lsp.util.locations_to_items(locations)
    vim.fn.setqflist({}, " ", {
            title = "Language Server",
            items = list 
        })
end

extension.match_expr = 
    "metadata[/\\]projects[/\\](.*)[/\\]assemblies[/\\](.*)[/\\]symbols[/\\](.*).cs"

extension.find_path = function (str)
    return string.gsub(str, "[/\\]", ".")
end

extension.parse_meta_path = function (uri)
    print(uri)
    local found, _, project, assembly, symbol = string.find(uri, extension.match_expr)
    if found ~= nil then
        print(_)
        print(project)
        print(assembly)
        print(symbol)
        return found, extension.find_path(project), extension.find_path(assembly), extension.find_path(symbol)
    end

    return nil
end

extension.get_client = function ()
    local clients = vim.lsp.buf_get_clients(0)
    for _, client in pairs(clients) do
        if client.name == "csharp_ls" then
            return client
        end
    end

    return nil
end

extension.buffer_from_meta = function (result, client_id)
    local normalized = string.gsub(result.source, "\r\n", "\n")

    local normalized_src_name = string.gsub(result.assemblyName, "\\", "/")
    local file_name = "/" .. normalized_src_name

    local bufnr = utils.get_or_create_buf(file_name)
    local api = vim.api
    api.nvim_buf_set_option(bufnr, "modifiable", true)
    api.nvim_buf_set_option(bufnr, "readonly", false)

    local src_lines = utils.split(normalized, "\n")
    api.nvim_buf_set_lines(bufnr, 0, -1, true, src_lines)

    api.nvim_buf_set_option(bufnr, "modifiable", false)
    api.nvim_buf_set_option(bufnr, "readonly", true)
    api.nvim_buf_set_option(bufnr, "filetype", "cs")
    api.nvim_buf_set_option(bufnr, "modified", false)

    vim.lsp.buf_attach_client(bufnr, client_id)
    return bufnr, file_name
end

extension.get_metadata = function (locations)
    local client = extension.get_client()
    if not client then
        return false
    end

    local data = {}
    for _, loc in pairs(locations) do
        local uri = utils.url_decode(loc.uri)
        local is_meta, _, _, _ = extension.parse_meta_path(uri)
        if is_meta then
            local params = {
                timeout = 3000,
                textDocument = { uri = uri }
            }

            local result, err = client.request_sync("csharp/metadata", params, 10000)
            if not err then
                local bufnr, name = extension.buffer_from_meta(result.result, client.id)
                loc.uri = "file://" .. name

                data[loc.uri] = {
                    bufnr = bufnr,
                    range = loc.range
                }
            end
        end
    end

    return data
end

extension.definition_to_locations = function (data)
    if not vim.tbl_islist(data) then
        return { data }
    end

    return data
end

extension.handle_locations = function (locations)
    local data = extension.get_metadata(locations)
    if not vim.tbl_isempty(data) then
        if #locations > 1 then
            utils.set_quickfix_list_locations(locations)
            vim.api.nvim_command("copen")
            return true
        else
            vim.lsp.util.jump_to_location(locations[1], 'utf-32')
            return true
        end
    else
        return false
    end
end

extension.handler = function (err, result, context, config)
    local locations = extension.definition_to_locations(result)
    local handled = extension.handle_locations(locations)
    if not handled then
        return vim.lsp.handers["textDocument/definition"](err, result, context, config)
    end    
end

extension.lsp_definitions = function ()
    local client = extension.get_client()
    if client then
        local params = vim.lsp.util.make_position_params()
        local handler = function (err, result, context, config)
            context.params = params
            extension.handler(err, result, context, config)
        end

        client.request("textDocument/definition", params, handler)
    end
end

return extension

