{ config, pkgs, ... }:
  let
    dotfilesDir = ../.;
  in {
    home.username = "robwaz";
    home.homeDirectory = "/Users/robwaz";
    home.stateVersion = "23.11";

    programs.git.enable = true;

    home.packages = with pkgs; [
      home-manager
    ];

    home.file = {
    ".tmux.conf".source = "${dotfilesDir}/tmux.conf";
    ".bashrc".source = "${dotfilesDir}/shellrc";
    ".zshrc".source = "${dotfilesDir}/shellrc";
    ".config/nvim".source = "${dotfilesDir}/neovim";
    ".pylintrc".source = "${dotfilesDir}/pylintrc";
    ".ipython/profile_default/ipython_config.py".source = "${dotfilesDir}/ipython_config.py";
    ".config/alacritty/alacritty.toml".source = "${dotfilesDir}/alacritty.toml";
    ".config/aerospace/aerospace.toml".source = "${dotfilesDir}/aerospace.toml";
    };
  }
