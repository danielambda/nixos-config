{ lib, pkgs, ... }: {
  wayland.windowManager.hyprland.settings.exec = [
    # "${lib.getExe pkgs.hyprlock} --immediate"
  ];

  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        grace = 5;
        hide_cursor = true;
      };

      background = [
        {
          path = "/home/daniel/Downloads/desert_sands_3.png"; #TODO
          blur_passes = 2;
          blur_size = 6;
        }
      ];

      input-field = [
        {
          size = "250, 60";
          outer_color = "rgb(000000)";
          inner_color = "rgb(6040A0)";
          font_color = "rgb(B024C0)";
          placeholder_text = "";
        }
      ];

      label = [
        {
          text = "Hello";
          color = "rgba(00ff00)";
          # font_family = theme.fonts.default.name;
          font_size = 64;
          text_align = "center";
          halign = "center";
          valign = "center";
          position = "0, 160";
        }
        {
          text = "$TIME";
          # color = "rgba(${hexToRgb colours.subtext1}, 1.0)";
          # font_family = theme.fonts.default.name;
          font_size = 32;
          text_align = "center";
          halign = "center";
          valign = "center";
          position = "0, 75";
        }
      ];
    };
  };
}
