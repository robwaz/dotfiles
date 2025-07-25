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
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    home-manager.url = "github:nix-community/home-manager/master";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager }:
  let
    username = "robwaz";
    system = "aarch64-darwin";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    lib = nixpkgs.lib;

    configuration = { pkgs, ... }: 
      let 
        py313 = with pkgs;
            python313.withPackages (ps: with ps; [
              ipython
              pandas
              pwntools
              ninja
              aider-chat-full
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
          # pkgs.overlays = [
          #        (final: prev: {
          #clang = prev.clang.override {
          #  apple-sdk = prev.darwin.apple_sdk_11_0;  # Adjust as needed
          #          };
          #        })
          #      ];


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
          apple-sdk
          aerospace
          ansible
          apple-sdk
          asm-lsp
          awscli2
          bash-language-server
          bat
          bata24-gef
          binutils
          browsh
          btop
          cilium-cli
          claude-code
          cmake
          colima
          container
          cowsay
          curl
          doxygen
          elixir
          feh
          ffmpeg
          figlet
          file
          firefox
          fzf
          gawk
          gdb-py313
          gef-py313
          gh
          ghidra
          git
          gnupg
          go
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
          lua-language-server
          mosh
          neovim
          obsidian
          mas
          metasploit
          mpv
          nmap
          ollama
          openssh
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
          ruby
          rustup
          rust-analyzer
          silver-searcher
          slack
          skimpdf
            # stack # Broken package?
          sshfs
          tesseract
          texliveFull
          tmux
          tree
          tree-sitter
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
        system.primaryUser = "robwaz";

        system.keyboard.enableKeyMapping = true;
        system.keyboard.remapCapsLockToEscape = true;
        system.defaults = {
          dock.minimize-to-application = true;
          dock.mru-spaces = false;
          dock.show-recents = false;
          dock.tilesize = 48;
          dock.orientation = "left";
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

          finder.FXPreferredViewStyle = "Nlsv";
          finder.NewWindowTarget = "Home";
          finder.ShowPathbar = true;
          finder.ShowStatusBar = true;

          loginwindow.GuestEnabled = false;
          loginwindow.SHOWFULLNAME = true;

          menuExtraClock.Show24Hour = true;

          # tap to click
          NSGlobalDomain."com.apple.trackpad.forceClick" = true;
          trackpad.TrackpadThreeFingerDrag = true;
          trackpad.TrackpadThreeFingerTapGesture = 2;
          spaces.spans-displays = false;


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
            "discord"
            "docker"
            "doxie"
            "google-chrome"
            "macfuse"
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
              # "MainStage" = 634159523;
              # "Motion" = 434290957;
            "Noir" = 1592917505;
            "Numbers" = 409203825;
            "Pages" = 409201541;
            "Pixelmator Pro" = 1289583905;
            "StopTheMadness Pro" = 6471380298;
            "TestFlight" = 899247664;
            "The Unarchiver" = 425424353;
            "Userscripts" = 1463298887;
              # "Windows App" = 1295203466;
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
      system = system;
      specialArgs = {
        inherit username pkgs;
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
