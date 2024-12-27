{ pkgs, lib, config, ... }:
let
  colors = config.stylix.base16Scheme;
in {
  imports = [
    ./hyprlock.nix
    ./hypridle.nix
    ./binds.nix
    ./hyprpaper.nix
    ./hiding-windows
  ];

  wayland.windowManager.hyprland.enable = true;

  my.hyprland.hidingWindows.enable = true;

  wayland.windowManager.hyprland.settings = {
    animation = [
      "specialWorkspace, 1, 6, default, slidefadevert -50%"
    ];
    workspace = [
      "special:obsidian, rounding:false, decorate:false, gapsin:0, gapsout:0, border:false"
    ];
    windowrulev2 = [
      "workspace special:obsidian, class:(obsidian)"
      "bordersize 5, pinned:1"
    ];

    exec-once = [
      (lib.getExe pkgs.waybar)
      (lib.getExe pkgs.hyprpaper)
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
      gaps_in = 8;
      gaps_out = 16;
      border_size = 4;

      "col.active_border" = "rgba(${colors.base08}ff)";
      "col.inactive_border" = "rgba(${colors.base04}80)";

      layout = "dwindle";
    };

    decoration = {
      rounding = 16;

      blur = {
        enabled = true;
        xray = true;
      };

      shadow = {
        enabled = true;
        range = 8;
        color_inactive = "rgba(00000000)";
      };
    };

    misc = {
      disable_hyprland_logo = true;
      disable_autoreload = true;
      background_color = lib.mkForce "rgb(000000)";
      focus_on_activate = true;
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
      kb_options = "grp:alt_shift_toggle";#, caps:swapescape";

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
      workspace_swipe_min_fingers = true;
    };

    monitor = import ./monitor.nix;
  };
}
