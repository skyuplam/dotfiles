{ pkgs, ... }:
{
  # Networking
  networking.computerName = "Terrence Lam’s 💻";
  networking.hostName = "tlamsmbpro16";
  networking.knownNetworkServices = [
    "Wi-Fi"
    "USB 10/100/1000 LAN"
  ];
  networking.dns = [
    "1.1.1.1"
    "8.8.8.8"
  ];

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [
      #pkgs.yabai
      pkgs.skhd
    ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Enable experimental version of nix with flakes support
  nix.package = pkgs.nixFlakes;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  services.yabai = {
    enable = false;
    package = pkgs.yabai;
    enableScriptingAddition = false;
    config = {
      focus_follows_mouse          = "off";
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

    services.skhd = {
      enable = true;
      package = pkgs.skhd;
    };
}
