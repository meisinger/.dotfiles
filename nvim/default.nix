{ pkgs, config, ... }:
let
  leaderKey = "\\<Space>";
in
{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    extraPackages = [
      pkgs.omnisharp-roslyn
      pkgs.nodePackages.typescript
      pkgs.nodePackages.typescript-language-server
      pkgs.nodePackages.bash-language-server
      pkgs.nodePackages.vim-language-server
      pkgs.nodePackages.yaml-language-server
      pkgs.rnix-lsp
      pkgs.lua-language-server
      pkgs.stylua
      pkgs.shfmt
      pkgs.statix
      pkgs.nodePackages.eslint
      pkgs.nodePackages.prettier
      pkgs.nodePackages.cspell
    ];
    extraConfig = ''
      let mapleader = "${leaderKey}"

      lua << EOF
        local tsserver_path = "${pkgs.nodePackages.typescript-language-server}/bin/typescript-language-server"
        local typescript_path = "${pkgs.nodePackages.typescript}/lib/node_modules/typescript/lib"
        local omnisharp_bin = "${pkgs.omnisharp-roslyn}/bin/omnisharp"

        ${builtins.readFile ./init.lua}
        ${builtins.readFile ./lua/scripts/options.lua}
        ${builtins.readFile ./lua/scripts/mappings.lua}
        ${builtins.readFile ./lua/scripts/configuration.lua}
        ${builtins.readFile ./lua/scripts/lsp.lua}
      EOF
    '';
    plugins = with pkgs.vimPlugins; [
      vim-nix
      vim-colorschemes
      gruvbox
      tokyonight-nvim
      nvim-web-devicons

      vim-polyglot
      vim-floaterm

      which-key-nvim
      nvim-autopairs
      plenary-nvim
      gitsigns-nvim
      popup-nvim
      lualine-nvim
      nvim-gps
      nvim-notify
      comment-nvim

      telescope-nvim
      telescope-file-browser-nvim
      telescope-ui-select-nvim
      telescope-fzf-native-nvim

      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-tmux
      cmp_luasnip

      nvim-lspconfig
      null-ls-nvim

      (nvim-treesitter.withPlugins (
        plugins:
          with plugins; [
            tree-sitter-lua
            tree-sitter-vim
            tree-sitter-html
            tree-sitter-yaml
            tree-sitter-json
            tree-sitter-markdown
            tree-sitter-comment
            tree-sitter-bash
            tree-sitter-javascript
            tree-sitter-nix
            tree-sitter-typescript
            tree-sitter-c_sharp
            tree-sitter-query # for the tree-sitter itself
            tree-sitter-dockerfile
          ]
      ))

      luasnip
      lspkind-nvim
      friendly-snippets

      nvim-neoclip-lua
      indent-blankline-nvim
      nvim-tree-lua
      vim-tmux-clipboard
      symbols-outline-nvim

      noice-nvim
      nui-nvim
      fidget-nvim
      nvim-lightbulb

      neoscroll-nvim
      neogit
      undotree
      diffview-nvim
      goto-preview
      nvim-dap
      trouble-nvim
      lsp_lines-nvim

      omnisharp-extended-lsp-nvim
    ];
  };
}
