# Spotlight will not index symlinks to applications in the Applications folder
# This makes the default darwin-nix behavior silly (/Applications/Nix Apps)
#
# Official darwin-nix solution is apparently to copy the whole app: https://github.com/nix-darwin/nix-darwin/issues/214
#
# We *CAN* create a hollow .app bundle, and symlink the contents folder
# as a workaround.

{ config, pkgs, lib, ... }:

let
  nixAppsDir = "/Applications/Nix Apps";
  linkedAppsDir = "/Applications/NixLinkedApps";
in
{
  options = {
    nixLinkedApps.enable = lib.mkEnableOption "Create .app wrappers for Spotlight";
  };

  config = {
    system.activationScripts.postActivation.text = ''
      echo "Creating .app links in ${linkedAppsDir}"
      mkdir -p "${linkedAppsDir}"

      for app in "${nixAppsDir}"/*.app; do
        appName=$(basename "$app")
        target="${linkedAppsDir}/$appName"
        contentsTarget="$target/Contents"
        realContents="$app/Contents"

        if [ ! -L "$contentsTarget" ]; then
          echo "Linking $target → $realContents"
          mkdir -p "$target"
          ln -s "$realContents" "$contentsTarget"
        fi
      done
    '';

  };
}
