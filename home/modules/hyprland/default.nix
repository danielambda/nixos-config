{ pkgs, lib, config, inputs, system, ... }:
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

  home.packages = [
    inputs.hyprland-qtutils.packages."${system}".default
    pkgs.rose-pine-hyprcursor
  ];

  wayland.windowManager.hyprland.settings = {
    windowrule = [
      "match:pin true, border_color rgba(${colors.base07}ff)"
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

      enable_hyprcursor = true;
    };

    env = [
      "HYPRCURSOR_THEME,rose-pine-hyprcursor"
      "HYPRCURSOR_SIZE,20"
    ];

    ecosystem = {
      no_update_news = true;
      no_donation_nag = true;
    };

    general = {
      gaps_in = 3;
      gaps_out = 6;
      border_size = 3;

      "col.active_border" = "rgba(${colors.base00}ff)";
      "col.inactive_border" = "rgba(${colors.base03}80)";

      layout = "dwindle";
    };

    decoration = {
      rounding = 8;

      blur = {
        enabled = false;
        xray = true;
      };

      shadow = {
        enabled = true;
        range = 9;
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
      enabled = false;
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

      sensitivity = 0.2;

      touchpad = {
        natural_scroll = true;
        scroll_factor = 0.5;
        clickfinger_behavior = true;
      };
    };

    gesture = [
      "3, horizontal, workspace"
    ];

    monitor = import ./monitor.nix;
  };
}
