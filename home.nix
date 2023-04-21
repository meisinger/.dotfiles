{ config, pkgs, lib, ... }:

{
  home.stateVersion = "22.05";
  home.packages = with pkgs; [
    coreutils
    gnugrep
    curl
    wget
    bat
    fd
    ripgrep

    jq
    nodejs
    nodePackages.typescript
    dotnet-sdk

    # Useful nix related tools
    cachix
    nodePackages.node2nix

  ] ++ lib.optionals stdenv.isDarwin [
    cocoapods
    m-cli # useful macOS CLI commands
  ];

  imports = [
    ./tmux
    ./nvim
  ];

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  programs.htop.enable = true;
  programs.htop.settings.show_program_path = true;

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;

    shellAliases = {
      ll = "ls -l";
      cat = "bat";
      update = "darwin-rebuild switch --flake ~/.config/nix#meisinger";
      zsh_edit = "nvim ~/.zshrc";
      zsh_reload = "source ~/.zshrc";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };
  };

  home.file.".stack/config.yaml".text = lib.generators.toYAML { } {
    templates = {
      scm-init = "git";
      params = {
        author-name = "Mike Meisinger";
        author-email = "mike.meisinger@gmail.com";
        github-username = "meisinger";
      };
    };
    nix.enable = true;
  };

}
