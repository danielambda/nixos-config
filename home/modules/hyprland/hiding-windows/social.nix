{ pkgs, lib, ... }:
let
  class = "org.telegram.desktop";
  window = "class:${class}";

  utils = import ./utils.nix { inherit pkgs lib; };
in {
  wayland.windowManager.hyprland.settings.windowrulev2 = [
    "float, ${window}"
    "monitor 0, ${window}"
    "size 38% 1224, ${window}"
    "move 18 58, ${window}" # TODO replace 6 with gapsout global const
    "rounding 6, ${window}"
    "bordercolor rgba(8f99f5c0), ${window}" #8f99f5c0
  ];
  wayland.windowManager.hyprland.settings.bind = [
    (utils.mkHidingWindowBind {
      bindKey = "S";
      inherit class;
      launch = lib.getExe pkgs.telegram-desktop;
    })
  ];
}
