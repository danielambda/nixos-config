{ pkgs, lib, ... }:
let
  id = "01J9MHDYPWYKKGS4QS9YDRYJ25";
  window = "class:FFPWA-${id}";

  utils = import ./utils.nix { inherit pkgs lib; };
in {
  wayland.windowManager.hyprland.settings.windowrulev2 = [
    "float, ${window}"
    "center, ${window}"
    "monitor 0, ${window}"
    "opacity 0.85, ${window}"
    "size 720 1080, ${window}"
    "bordercolor rgba(fed42bc0), ${window}" #fed42bc0
  ];
  wayland.windowManager.hyprland.settings.bind = [
    (utils.mkFirefoxpwaHidingWindowBind {
      bindKey = "M";
      inherit id;
    })
  ];
}
