## Todo
# - Install homebrew from within nix?

# # Packages to add
# binja
# ida
# lightroom classic
# pob
# userscripts
# wine

{
  description = "Robwaz nix-darwin flake";
  inputs = {
    pkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.pkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.pkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, pkgs, home-manager }:
  let
    username = "robwaz";
    system = "aarch64-darwin";
    lib = pkgs.lib;

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
        bata24-gef = import ./derivations/bata24-gef.nix {inherit pkgs;};
      in {
        launchd.user.agents = {
          ollama-serve = {
            command = "${pkgs.ollama}/bin/ollama serve";
            serviceConfig = {
              KeepAlive = true;
              RunAtLoad = true;
              StandardOutPath = "/tmp/ollama-serve.out.log";
              StandardErrorPath = "/tmp/ollama-serve.err.log";
            };
          };
        };

        environment.systemPackages = with pkgs; [
          alacritty
          aerospace
          ansible
          bash-language-server
          bat
          bata24-gef
          binutils
          browsh
          btop
          cilium-cli
          clang
          cmake
          colima
          cowsay
          curl
          discord
          doxygen
          elixir
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
          home-manager
          hping
          htop
          imagemagick
          iperf
          irssi
          iterm2
          jq
          llvm
          neovim
          obsidian
          mas
          metasploit
          mpv
          nmap
          ollama
          nodejs
          pandoc
          parallel
          patchelf
          pgcli
          podman
          powershell
          pyright
          py313
          python313Packages.pip
          # Add other python packages to py313
          ranger
          rclone
          ripgrep
          rustup
          rust-analyzer
          silver-searcher
          slack
          skimpdf
            # stack # Broken package?
          tesseract
          texliveFull
          tmux
          tree
          unixtools.watch
          unzip
          uv
          #vscode
          wget
          yt-dlp
          zoom-us
          zsh
          ];

        fonts.packages = with pkgs; [
          nerd-fonts.hack
        ];


        # Necessary for using flakes without annoyance
        nix.settings.experimental-features = "nix-command flakes";
        nix.settings.trusted-users = [ "root" "robwaz" ];
        nix.enable = true;

        # Set Git commit hash for darwin-version.
        system.configurationRevision = self.rev or self.dirtyRev or null;

        system.keyboard.enableKeyMapping = true;
        system.keyboard.remapCapsLockToEscape = true;
        system.defaults = {
          dock.autohide = true;
          dock.persistent-apps = [
            "/Applications/NixLinkedApps/Alacritty.app"
            "/System/Cryptexes/App/System/Applications/Safari.app"
            "/Applications/NixLinkedApps/Discord.app"
            "/Applications/NixLinkedApps/Obsidian.app"
            "/Applications/ChatGpT.app"
            "/Applications/Spotify.app"
            "/System/Applications/Mail.app"
            "/System/Applications/Calendar.app"
            "/Applications/NixLinkedApps/Slack.app"
            "/Applications/Zotero.app"
          ];
        };

        system.stateVersion = 6;
        nixpkgs.hostPlatform = "aarch64-darwin";

        homebrew = {
          enable = true;
          brews = [];
          whalebrews = []; # docker images to auto-pull
          casks = [
            "amethyst"
            "bambu-studio"
            "chatgpt"
            "crossover"
            "doxie"
            "google-chrome"
            "microsoft-office"
            "obs"
            "rode-central"
            "spotify"
            "steam"
            "tunnelblick"
            "transmission"
            "vlc"
            "wine-stable"
            "zotero"
          ];
          masApps = {
            "1Password for Safari" = 1569813296;
            "Amphetamine" = 937984704;
            "BetterSnapTool" = 417375580;
            "Compressor" = 424390742;
            "Developer" = 640199958;
            "Final Cut Pro" = 424389933;
            "Goodnotes" = 1444383602;
            "Keynote" = 409183694;
            "Kindle Classic" = 405399194;
            "Logic" = 634148309;
            "MainStage" = 634159523;
            "Motion" = 434290957;
            "Noir" = 1592917505;
            "Numbers" = 409203825;
            "Pages" = 409201541;
            "Pixelmator Pro" = 1289583905;
            "StopTheMadness Pro" = 6471380298;
            "TestFlight" = 899247664;
            "The Unarchiver" = 425424353;
            "Userscripts" = 1463298887;
            "Windows App" = 1295203466;
            "Xcode" = 497799835;
          };
        };

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
          nixpkgs.config.allowUnfree = true;
        }
      ];
    };
  };
}
