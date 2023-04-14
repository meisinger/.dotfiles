{pkgs, config, ...}: {
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    escapeTime = 0;
    keyMode = "vi";
    sensibleOnTop = true;
    plugins = [

      (pkgs.callPackage ~/.config/nix-derivations/tmux-status-variable.nix {})
      {
        plugin = pkgs.tmuxPlugins.yank;
        extraConfig = ''
          set -g @yank-action 'copy-pipe'
        '';
      }
      {
        plugin = pkgs.tmuxPlugins.onedark-theme;
        extraConfig = ''
          set -g @onedark_widgets "#{prefix_highlight}"
        '';
      }
      {
        plugin = pkgs.tmuxPlugins.prefix-highlight;
        extraConfig = ''
          set -g @prefix_highlight_show_copy_mode 'on'
        '';
      }
    ];
    extraConfig = ''
      set -g focus-events on

      unbind C-b

      set-option -g prefix C-a
      set-option -g renumber-windows on

      bind-key C-a send-prefix
      bind-key r source-file ~/.config/tmux/tmux.conf \; display-message "tmux reloaded"
    '';
  };
}
