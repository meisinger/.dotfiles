local plug_path = vim.fn.stdpath('config') .. '/autoload/plug.vim'
local impatient_path = vim.fn.stdpath('data') .. '/site/pack/impatient.nvim/start/impatient.nvim'

if vim.fn.empty(vim.fn.glob(plug_path)) == 1 then
  vim.cmd(string.format([[
    execute "!sh -c 'curl -fLo %s --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'"
  ]], plug_path))
end

if vim.fn.empty(vim.fn.glob(impatient_path)) == 1 then
  vim.cmd(string.format([[
    execute "!git clone --depth 1 https://github.com/lewis6991/impatient.vim %s"
  ]], impatient_path))
end
