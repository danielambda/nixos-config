{ pkgs, lib, config, shared, ... }:
let 
  colors = config.stylix.base16Scheme;

  wallpapersCycle = lib.getExe (import /${shared}/scripts/wallpapersCycle { inherit pkgs; });
  swwwRunnerScript = pkgs.writeShellApplication {
    name = "swwwRunnerScript";
  
    runtimeInputs = [pkgs.swww];

    text = ''
      swww-daemon &
      ${wallpapersCycle} &
      swww kill
      swww-daemon &
      swww kill
      swww-daemon
    ''; #don't even ask me why, for some reason swww wants its daemon to be killed at least 2 times
  };
in {
    imports = [
      ./hyprlock.nix
      ./hypridle.nix
      ./binds.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      exec-once = [
        (lib.getExe pkgs.waybar)
        (lib.getExe swwwRunnerScript)
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

        "col.active_border" = "rgba(${colors.base0C}ff) rgba(${colors.base08}ff) 270deg";
        "col.inactive_border" = "rgba(${colors.base04}80)";

        layout = "dwindle";
      };

      decoration = {
        rounding = 12;

        drop_shadow = true;
        shadow_range = 12;
        shadow_render_power = 2;
        "col.shadow" = "rgba(${colors.base01}ff)";
        "col.shadow_inactive" = "rgba(00000000)";

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

      windowrule = [
        "opacity 0.7 override, title:^(Mozilla Firefox)$"
      ];
    };
  };
}
