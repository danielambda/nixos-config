{ config, lib, pkgs, ... }: 
let
  resizeStep = "16";
  
  todoistId = "01J9H12Z45YVGP5QMYJ4G6EPFH";
  musicId =   "01J9MHDYPWYKKGS4QS9YDRYJ25";

  utils = import ./utils.nix; 

  cfg = config.my.hyprland;
  terminal = cfg.terminal;
in with pkgs // lib;
{
  options.my.hyprland = {
    terminal = mkOption {
      type = types.str;
      default = "kitty";
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
  '';

  config.wayland.windowManager.hyprland.settings."$mainMod" = "SUPER";

  config.wayland.windowManager.hyprland.settings.bind = [
    "$mainMod, RETURN, exec, ${terminal}"
    "$mainMod, Q, killactive"
    "$mainMod SHIFT, M, exit"

    '', print, exec, ${getExe grim} -g "$(${getExe slurp} -w 0)" - | ${wl-clipboard}/bin/wl-copy''
    ''$mainMod, print, exec, ${getExe grim} -o "$(${hyprland}/bin/hyprctl activeworkspace -j | ${getExe jq} -r '.monitor')" - | ${wl-clipboard}/bin/wl-copy''

    "$mainMod, T, exec, hyprctl dispatch togglespecialworkspace tasks && ${lib.getExe pkgs.firefoxpwa} site launch ${todoistId}"
    "$mainMod, M, exec, hyprctl dispatch togglespecialworkspace music && ${lib.getExe pkgs.firefoxpwa} site launch ${musicId}"
    "$mainMod, S, exec, hyprctl dispatch togglespecialworkspace social && ${lib.getExe pkgs.telegram-desktop}"
    "$mainMod, O, exec, ${lib.getExe (pkgs.writeShellApplication {
      name = "special-workspace";
      # text = "(pgrep -f obsidian && hyprctl dispatch togglespecialworkspace obsidian) || ${lib.getExe pkgs.obsidian}";
      text = ''
        (pgrep -f obsidian && hyprctl dispatch togglespecialworkspace obsidian) || ${lib.getExe pkgs.obsidian}'';
        # pgrep -f obsidian && hyprctl dispatch togglespecialworkspace obsidian || ${lib.getExe pkgs.obsidian} && ${lib.getExe pkgs.kitty} -d /home/daniel/obsidian ${lib.getExe pkgs.neovim}'';
    })}"

    "$mainMod, TAB, workspace, e+1"
    "$mainMod SHIFT, TAB, workspace, e-1"

    "$mainMod, F, fullscreen, 0"
    "$mainMod SHIFT, F, togglefloating, active"
    "$mainMod, P, pin, active"
    "$mainMod, C, centerwindow,"
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
  ];
  config.wayland.windowManager.hyprland.settings.bindl = [
    ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
  ];
}
