{ pkgs, lib, ... }:
let
  laptop-virt-w = 1170.0;
  laptop-virt-h = 780.0;
  size-w = toString (laptop-virt-w / 2);
  size-h = toString (laptop-virt-h - 50);
in {
  my.hyprland.hidingWindows.default = [{
    bindKey = "S";
    class = "org.telegram.desktop";
    launch = lib.getExe pkgs.telegram-desktop;
    windowrules = {
      size = "${size-w} ${size-h}";
      bordercolor = "rgba(8f99f5c0)"; #8f99f5c0
    };
  }];
}
