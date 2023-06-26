{ pkgs, lib, ... }:
{
  # Networking
  networking.computerName = "Terrence Lam’s 💻";
  networking.hostName = "tlamm2";

  environment.pathsToLink = [
    "/share/zsh"
    ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  environment.etc.bashrc.enable = false;

  # Key repeat
  system.defaults.NSGlobalDomain.InitialKeyRepeat = 12;
  system.defaults.NSGlobalDomain.KeyRepeat = 1;

  # Enable experimental version of nix with flakes support
  # nix.package = pkgs.nixVersions.stable;
  # https://github.com/LnL7/nix-darwin/issues/149 - auto-optimise-store = false
  nix.extraOptions = ''
    auto-optimise-store = false
    experimental-features = nix-command flakes
  '' + lib.optionalString (pkgs.system == "aarch64-darwin") ''
    extra-platforms = x86_64-darwin aarch64-darwin
  '';

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  # system.stateVersion = 4;

  # Keyboard
  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToEscape = true;
}
