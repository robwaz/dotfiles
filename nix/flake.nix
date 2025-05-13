# Todo
# - doxie
# - chrome
# - iterm2
# - office
# - obs
# - tunnelblick
# - vlc
# - vscode
# wine
# crossover
# yubikey-manager
# hopper
# ida
# obsidian
# amethyst
# textlive
# binja
# zotero
# final cut pro
# thinkorswim 
# userscripts
# pixelmator pro
# logic pro
# lightroom classic
# handbrake
# path-of-building

{
  description = "Robwaz nix-darwin flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager }:
  let
    username = "robwaz";
    configuration = { pkgs, ... }: 
      let 
        py313 = with pkgs;
            python313.withPackages (ps: with ps; [
              ipython
              pandas
              pwntools
              ninja
            ]);
        gdb-py313 = with pkgs; 
          gdb.override {
          python3 = py313;
        };
        gef-py313 = with pkgs;
          gef.override {
          python3 = py313;
          gdb = gdb-py313;
        };
      in {
        environment.systemPackages = with pkgs;
          [ alacritty
            bash-language-server
            bat
            binutils
            browsh
            btop
            cilium-cli
            clang
            cmake
            cowsay
            curl
            discord
            doxygen
            feh
            ffmpeg
            file
            firefox
            fzf
            gawk
            gcc
            gdb-py313
            gef-py313
            gh
            ghidra
            git
            gnupg
            hadolint
            hexedit
            hexyl
            hlint
            hping
            htop
            imagemagick
            iperf
            irssi
            llvm
            neovim
            mpv
            nmap
            ollama
            nodejs
            pandoc
            parallel
            patchelf
            podman # docker can't nix :(
            pyright
            py313
            python313Packages.pip
            # Add other python packages to py313
            ranger
            rclone
            ripgrep
            rust-analyzer
            silver-searcher
            slack
            spotify
              #stack # Broken package?
            tesseract
            tmux
            tree
            unzip
            uv
            wget
            yt-dlp
            zoom-us
            zsh
          ];

        # Necessary for using flakes without annoyance
        nix.settings.experimental-features = "nix-command flakes";
        nix.settings.trusted-users = [ "root" "robwaz" ];


        # Set Git commit hash for darwin-version.
        system.configurationRevision = self.rev or self.dirtyRev or null;

        system.stateVersion = 6;
        nixpkgs.hostPlatform = "aarch64-darwin";

        nixpkgs.config.allowUnfree = true;

        nixLinkedApps.enable = true;
        users.users.robwaz = {
          name = "robwaz";
          home = "/Users/robwaz";
        };

      };
  in
  {
    darwinConfigurations."armnhammer" = nix-darwin.lib.darwinSystem {
      specialArgs = {
        inherit username;
        inputs = { inherit home-manager; };
      };
      modules = [
        ./modules/nix-linked-apps.nix
        configuration
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${username} = import "${inputs.self}/home.nix";
        }
     ];
    };
  };
}
