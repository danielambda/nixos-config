{ pkgs, lib, ... }:
let
  id = "01J9H12Z45YVGP5QMYJ4G6EPFH";
  window = "class:FFPWA-${id}";

  utils = import ./utils.nix { inherit pkgs lib; };
in {
  wayland.windowManager.hyprland.settings.windowrulev2 = [
    "float, ${window}"
    "size 38% 1224, ${window}" # 1224 = 1300 (screen h) - gaps and something more
    "move 100%-w-18 58, ${window}" # TODO replace 6 with gapsout global const
    "monitor 0, ${window}"
    "rounding 6, ${window}"
    "opacity 0.85, ${window}"
    "bordercolor rgba(e34331c0), ${window}" #e34311c0
  ];
  wayland.windowManager.hyprland.settings.bind = [
    (utils.mkFirefoxpwaHidingWindowBind {
      bindKey = "T";
      inherit id;
    })
  ];
}
