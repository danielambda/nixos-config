{ pkgs, lib, config, ... }:
let colors = config.stylix.base16Scheme;
in {
  imports = [
    ./hyprlock.nix
    ./hypridle.nix
    ./binds.nix
  ];

  # home.packages = [];
  
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      exec = [
        "${pkgs.swww}/bin/swww-daemon &"
        "${lib.getExe pkgs.waybar} &"
      ];

      cursor = { 
        inactive_timeout = 3; 
        hide_on_key_press = true;
        hide_on_touch = true;
        
        no_warps = false;
        persistent_warps = true;
        warp_on_change_workspace = true;

        enable_hyprcursor = false;
      };
        
      general = {
        gaps_in = 3;
        gaps_out = 6;
        border_size = 3;

        "col.active_border" = lib.mkForce "rgba(${colors.base0C}ff) rgba(${colors.base08}ff) 270deg";
        "col.inactive_border" = lib.mkForce "rgba(${colors.base04}80)";

        layout = "dwindle";
      };

      decoration = {
        rounding = 6;

        drop_shadow = false;

        blur = {
          enabled = true;
          xray = true;
        };
      };

      misc = {
        disable_hyprland_logo = true;
        disable_autoreload = true;
        background_color = lib.mkForce "rgb(000000)";
      };

      animations = {
        enabled = true;
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      input = {
        kb_layout = "us, ru";
        kb_options = "grp:alt_shift_toggle";

        follow_mouse = 1;
        mouse_refocus = true;

        sensitivity = 0.5;

        touchpad = { 
          natural_scroll = true;
          scroll_factor = 0.5;
          clickfinger_behavior = true;
        };
      };

      gestures = {
        workspace_swipe = true;
      };

      monitor = import ./monitor.nix;
    };
  };
}
