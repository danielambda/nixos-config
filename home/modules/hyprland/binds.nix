{ config, lib, pkgs, inputs, system, ... }:
let
  resizeStep = "16";

  utils = import ./utils.nix;

  cfg = config.my.hyprland;
  terminal = cfg.terminal;

  zen = inputs.zen-browser.packages."${system}".specific;

in with pkgs // lib;
{
  options.my.hyprland = {
    terminal = mkOption {
      type = types.str;
      default = lib.getExe pkgs.kitty;
    };
  };

  config.wayland.windowManager.hyprland.extraConfig = ''
    bind = ALT, r, submap, resize
    submap = resize
    binde = , h, resizeactive, -${resizeStep} 0
    binde = , j, resizeactive, 0 ${resizeStep}
    binde = , k, resizeactive, 0 -${resizeStep}
    binde = , l, resizeactive, ${resizeStep} 0
    bind = , catchall, submap, reset
    submap = reset

    bind = ALT, m, submap, move
    submap = move
    binde = , h, moveactive, -${resizeStep} 0
    binde = , j, moveactive, 0 ${resizeStep}
    binde = , k, moveactive, 0 -${resizeStep}
    binde = , l, moveactive, ${resizeStep} 0
    binde = , c, centerwindow
    bind = , catchall, submap, reset
    submap = reset

    bind = $mainMod, r, submap, run
    submap = run
    bind = , r, execr, ${getExe rofi-wayland} -show drun
    bind = , r, submap, reset
    bind = , f, execr, ${getExe firefox}
    bind = , f, submap, reset
    bind = , z, execr, ${getExe zen}
    bind = , z, submap, reset
    bind = , c, execr, ${getExe pkgs.chromium}
    bind = , c, submap, reset
    bind = , v, execr, ${getExe vial}
    bind = , v, submap, reset
    bind = , m, execr, ${getExe prismlauncher}
    bind = , m, submap, reset
    bind = , n, execr, ${getExe nekoray}
    bind = , n, submap, reset
    bind = , p, execr, ${getExe wl-color-picker}
    bind = , p, submap, reset
    bind = , catchall, submap, reset
    submap = reset
  '';

  config.wayland.windowManager.hyprland.settings."$mainMod" = "SUPER";

  config.wayland.windowManager.hyprland.settings.bind = [
    "$mainMod, RETURN, exec, ${terminal}"
    "$mainMod, Q, killactive"

    '', print, exec, ${getExe grim} -g "$(${getExe slurp} -w 0)" - | ${wl-clipboard}/bin/wl-copy''
    ''$mainMod, print, exec, ${getExe grim} -o "$(${hyprland}/bin/hyprctl activeworkspace -j | ${getExe jq} -r '.monitor')" - | ${wl-clipboard}/bin/wl-copy''

    # "$mainMod, O, exec, ${getExe (writeShellApplication {
    #   name = "special-workspace";
    #   text = ''
    #     (pgrep -f obsidian && hyprctl dispatch togglespecialworkspace obsidian) || ${getExe obsidian}
    #   '';
    # })}"

    "$mainMod, TAB, workspace, e+1"
    "$mainMod SHIFT, TAB, workspace, e-1"

    "$mainMod, SEMICOLON, togglesplit"
    "$mainMod, F, fullscreen, 0"
    "$mainMod SHIFT, F, togglefloating, active"
    "$mainMod, P, pin, active"
    "$mainMod, C, centerwindow, 1"
  ]
  ++ utils.directionsBind "$mainMod" "movefocus"
  ++ utils.directionsBind "$mainMod CTRL" "swapwindow"
  ++ utils.digitsBind "$mainMod" "workspace"
  ++ utils.digitsBind "$mainMod SHIFT" "movetoworkspace"
  ++ utils.modifiedDirectionsBind "mon:" "$mainMod SHIFT" "movewindow"
  ;

  config.wayland.windowManager.hyprland.settings.bindm = [
    "$mainMod, mouse:272, movewindow"
    "$mainMod SHIFT, mouse:272, resizewindow"
  ];

  config.wayland.windowManager.hyprland.settings.bindel = [
    ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+"
    ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-"

    # ", XF86MonBrightnessUp,   exec, ${getExe brightnessctl} -q set +1%"
    ", XF86MonBrightnessUp,   exec, ${getExe brightnessctl} -q set +1%"
    ", XF86MonBrightnessDown, exec, ${getExe brightnessctl} -q set 1%-"
  ];
  config.wayland.windowManager.hyprland.settings.bindl = [
    ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
  ];
}
