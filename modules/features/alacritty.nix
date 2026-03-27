{ self, inputs, ... }:
let hexColors = builtins.mapAttrs (_: c: "0x${c}") self.colors; in
{
  perSystem = { pkgs, ... }: {
    packages.alacritty = inputs.wrapper-modules.wrappers.alacritty.wrap {
      inherit pkgs;
      settings = {
        env.TERM = "xterm-256color";
        bell.duration = 0;
        window.opacity = 1.0;
        cursor = {
          style = {
            shape = "Beam";
            blinking = "Off";
          };
          vi_mode_style = {
            shape = "Block";
            blinking = "Off";
          };
          unfocused_hollow = true;
        };
        mouse.hide_when_typing = true;
        colors = {
          primary = {
            background = hexColors.base00;
            foreground = hexColors.base05;
          };

          cursor = {
            text   = hexColors.base00;
            cursor = hexColors.base05;
          };

          normal = {
            black   = hexColors.base00;
            red     = hexColors.base08;
            green   = hexColors.base0B;
            yellow  = hexColors.base0A;
            blue    = hexColors.base0D;
            magenta = hexColors.base0E;
            cyan    = hexColors.base0C;
            white   = hexColors.base05;
          };

          bright = {
            black   = hexColors.base03;
            red     = hexColors.base08;
            green   = hexColors.base0B;
            yellow  = hexColors.base0A;
            blue    = hexColors.base0D;
            magenta = hexColors.base0E;
            cyan    = hexColors.base0C;
            white   = hexColors.base07;
          };

          dim = {
            black   = hexColors.base01;
            red     = hexColors.base08;
            green   = hexColors.base0B;
            yellow  = hexColors.base0A;
            blue    = hexColors.base0D;
            magenta = hexColors.base0E;
            cyan    = hexColors.base0C;
            white   = hexColors.base04;
          };
        };
      };
    };
  };
}
