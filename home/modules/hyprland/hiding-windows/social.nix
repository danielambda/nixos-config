{ pkgs, lib, ... }: {
  my.hyprland.hidingWindows.default = [
    {
      bindKey = "S";
      class = "org.telegram.desktop";
      launch = lib.getExe pkgs.telegram-desktop;
      windowrules = {
        size = "750 1220";
        bordercolor = "rgba(8f99f5c0)"; #8f99f5c0
      };
    }
  ];
}
