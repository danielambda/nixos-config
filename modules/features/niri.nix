{ inputs, self, ... }: {
  flake.wrapperModules.niri = { config, lib, pkgs, ... }: {
    options.terminal = lib.mkOption {
      type = lib.types.str;
      default = lib.getExe pkgs.kitty;
    };

    config = {
      settings = let noctaliaExe = lib.getExe pkgs.noctalia-shell; in {
        prefer-no-csd = {};

        input = {
          focus-follows-mouse = {};

          keyboard = {
            xkb = {
              layout = "us,ru";
              options = "grp:alt_shift_toggle";
            };
          };

          touchpad = {
            natural-scroll = {};
            tap = {};
          };
        };

        binds = {
          "Mod+Return".spawn = config.terminal;

          "Mod+Q".close-window = {};
          "Mod+F".fullscreen-window = {};
          "Mod+Shift+F".toggle-window-floating = {};
          "Mod+C".center-column = {};

          "Mod+H".focus-column-left = {};
          "Mod+L".focus-column-right = {};
          "Mod+K".focus-window-up = {};
          "Mod+J".focus-window-down = {};

          "Mod+Left".focus-column-left = {};
          "Mod+Right".focus-column-right = {};
          "Mod+Up".focus-window-up = {};
          "Mod+Down".focus-window-down = {};

          "Mod+Shift+H".move-column-left = {};
          "Mod+Shift+L".move-column-right = {};
          "Mod+Shift+K".move-window-up = {};
          "Mod+Shift+J".move-window-down = {};

          "XF86AudioRaiseVolume".spawn-sh = "wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+";
          "XF86AudioLowerVolume".spawn-sh = "wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-";

          # "Mod+Ctrl+H".set-column-width = "-5%";
          # "Mod+Ctrl+L".set-column-width = "+5%";
          # "Mod+Ctrl+J".set-window-height = "-5%";
          # "Mod+Ctrl+K".set-window-height = "+5%";

          "Mod+WheelScrollDown".focus-column-left = {};
          "Mod+WheelScrollUp".focus-column-right = {};
          "Mod+Ctrl+WheelScrollDown".focus-workspace-down = {};
          "Mod+Ctrl+WheelScrollUp".focus-workspace-up = {};

        #   "Mod+d".spawn-sh = self.mkWhichKeyExe config.pkgs [
        #     {
        #       key = "b";
        #       desc = "Bluetooth";
        #       cmd = "${noctaliaExe} ipc call bluetooth togglePanel";
        #     }
        #     {
        #       key = "w";
        #       desc = "Wifi";
        #       cmd = "${noctaliaExe} ipc call wifi togglePanel";
        #     }
        #     {
        #       key = "f";
        #       desc = "Firefox";
        #       cmd = "firefox";
        #     }
        #     {
        #       key = "t";
        #       desc = "Telegram";
        #       cmd = "Telegram";
        #     }
        #     {
        #       key = "d";
        #       desc = "Discord";
        #       cmd = "vesktop";
        #     }
        #     {
        #       key = "m";
        #       desc = "Youtube Music";
        #       cmd = "pear-desktop";
        #     }
        #     {
        #       key = "s";
        #       desc = "Pavucontrol";
        #       cmd = "${lib.getExe pkgs.pavucontrol}";
        #     }
        #   ];
        };

        layout = {
          gaps = 3;

          # focus-ring = {
          #   width = 2;
          #   active-color = "#${self.themeNoHash.base09}";
          # };
        };

        workspaces = let
          settings = { layout.gaps = 3; };
        in {
          "w0" = settings;
          "w1" = settings;
          "w2" = settings;
          "w3" = settings;
          "w4" = settings;
          "w5" = settings;
          "w6" = settings;
          "w7" = settings;
          "w8" = settings;
          "w9" = settings;
        };

        xwayland-satellite.path =
          lib.getExe config.pkgs.xwayland-satellite;

        # spawn-at-startup = [
        #   noctaliaExe
        #   (lib.getExe (
        #     pkgs.writeShellScriptBin "wallpaper"
        #     "${lib.getExe pkgs.swaybg} -i ${./../nixos/features/wallpaper/gruvbox-mountain-village.png} -m fill"
        #   ))
        # ];
      };
    };
  };

  perSystem = { pkgs, ... }: {
    packages.niri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs;
      imports = [self.wrapperModules.niri];
    };
  };

  flake.nixosModule.niri = { self', ... }: {
    programs.niri = {
      enable = true;
      package = self'.packages.niri;
    };
  };
}
