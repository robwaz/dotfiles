{ config, pkgs, ... }:
  let
    dotfilesDir = ../.;
  in {
    home.username = "robwaz";
    home.homeDirectory = "/Users/robwaz";
    home.stateVersion = "23.11";

    home.packages = with pkgs; [
      home-manager
    ];

    # --- Programs ---
    programs.git = {
      enable = true;
      userEmail = "robwaz@robwaz.net";
      userName = "Robert Wasinger";
      lfs.enable = true;
      signing.format = "openpgp";
      signing.key = "E06883824D3D556D";
      signing.signByDefault = true;
    };

    programs.gpg.publicKeys = [
        {
          source ="${dotfilesDir}/robwaz.asc";
          trust = "ultimate";
        }];

    programs.man.generateCaches = true;

    # TODO: neovim in nix vs file?
    # obs 
    # obsidian 
    # skim
    # ssh
    # tmux vs file?
    # zsh vs file?

    


    # --- Config Files ---
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
