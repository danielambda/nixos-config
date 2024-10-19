{ pkgs, lib, ... }: {
  my.hyprland.hidingWindows.default = [
    {
      bindKey = "S";
      class = "org.telegram.desktop";
      launch = lib.getExe pkgs.telegram-desktop;
      windowrules = {
        monitor = 0;
        size = "38% 1224";
        move = "18 58";
        rounding = 6;
        opacity = 0.85;
        bordercolor = "rgba(8f99f5c0)"; #8f99f5c0
      };
    }
  ];
}
