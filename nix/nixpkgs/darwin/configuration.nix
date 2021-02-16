{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [ pkgs.vim
    ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  # services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.zsh.enable = true;  # default shell on catalina
  # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  services.yabai = {
    enable = true;
    package = pkgs.yabai;
    enableScriptingAddition = true;
    config = {
      focus_follows_mouse          = "autoraise";
      mouse_follows_focus          = "off";
      window_placement             = "second_child";
      window_opacity               = "off";
      window_opacity_duration      = "0.0";
      window_topmost               = "on";
      window_shadow                = "float";
      active_window_opacity        = "1.0";
      normal_window_opacity        = "1.0";
      split_ratio                  = "0.50";
      auto_balance                 = "on";
      mouse_modifier               = "fn";
      mouse_action1                = "move";
      mouse_action2                = "resize";
      layout                       = "bsp";
      top_padding                  = 10;
      bottom_padding               = 10;
      left_padding                 = 10;
      right_padding                = 10;
      window_gap                   = 10;
    };

    extraConfig = ''
        # rules
        yabai -m rule --add app="^System Preferences$" manage=off
        yabai -m rule --add app="^Finder$" manage=off
        yabai -m rule --add app="^Transmission$" manage=off
        yabai -m rule --add app="^Archive Utility$" manage=off
        yabai -m rule --add app="^Wireless Diagnostics$" manage=off
        yabai -m rule --add app="^GifCapture$" manage=off
        yabai -m rule --add app="^.*Installer$" manage=off
        yabai -m rule --add app="^Calendar$" manage=off
        yabai -m rule --add app="^Vorta$" manage=off
        yabai -m rule --add app="^Outlook$" manage=off
        yabai -m rule --add app="^Books$" manage=off
        yabai -m rule --add app="^Kindle$" manage=off
        yabai -m rule --add app="^calibre$" manage=off
        yabai -m rule --add app="^App Store$" manage=off
        yabai -m rule --add app="^Logi Options$" manage=off

        # signals
        yabai -m signal --add event=window_destroyed action="yabai -m query --windows --window &> /dev/null || yabai -m window --focus mouse"
        yabai -m signal --add event=application_terminated action="yabai -m query --windows --window &> /dev/null || yabai -m window --focus mouse"
      '';
    };
}
