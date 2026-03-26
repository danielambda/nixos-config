{ inputs, self, ... }: {
  perSystem = { pkgs, lib, self', system, ... }: {
    packages.niri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs;
      settings = let noctaliaExe = lib.getExe self'.packages.noctalia; in {
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
          "Mod+R".spawn = self.mkWhichKeyExe pkgs [
            {
              key = "b";
              desc = "Bluetooth";
              cmd = "${noctaliaExe} ipc call bluetooth togglePanel";
            }
            {
              key = "w";
              desc = "Wifi";
              cmd = "${noctaliaExe} ipc call wifi togglePanel";
            }
            {
              key = "z";
              desc = "Zen Browser";
              cmd = lib.getExe inputs.zen-browser.packages."${system}".twilight;
            }
            {
              key = "t";
              desc = "Telegram";
              cmd = lib.getExe pkgs.telegram-desktop;
            }
            {
              key = "a";
              desc = "Amnezia VPN";
              cmd = lib.getExe pkgs.amnezia-vpn;
            }
            {
              key = "s";
              desc = "Pavucontrol";
              cmd = "${lib.getExe pkgs.pavucontrol}";
            }
          ];

          "Mod+Return".spawn = lib.getExe pkgs.kitty;

          "Mod+Q".close-window = {};
          "Mod+F".fullscreen-window = {};
          "Mod+Shift+F".toggle-window-floating = {};
          "Mod+C".center-column = {};

          "Mod+H".focus-column-left = {};
          "Mod+L".focus-column-right = {};
          "Mod+K".focus-window-up = {};
          "Mod+J".focus-window-down = {};

          "Mod+Shift+H".focus-monitor-left = {};
          "Mod+Shift+L".focus-monitor-right = {};
          "Mod+Shift+K".focus-workspace-up = {};
          "Mod+Shift+J".focus-workspace-down = {};

          "Mod+Ctrl+H".move-column-left = {};
          "Mod+Ctrl+L".move-column-right = {};
          "Mod+Ctrl+K".move-window-up = {};
          "Mod+Ctrl+J".move-window-down = {};

          "Mod+Shift+Ctrl+H".move-workspace-to-monitor-left = {};
          "Mod+Shift+Ctrl+L".move-workspace-to-monitor-right = {};

          "XF86AudioRaiseVolume".spawn-sh = "wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 1%+";
          "XF86AudioLowerVolume".spawn-sh = "wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 1%-";

          # "Mod+Shift+H".set-column-width = "-5%";
          # "Mod+Shift+L".set-column-width = "+5%";
          # "Mod+Shift+J".set-window-height = "-5%";
          # "Mod+Shift+K".set-window-height = "+5%";

          "Mod+WheelScrollDown".focus-column-left = {};
          "Mod+WheelScrollUp".focus-column-right = {};
          "Mod+Ctrl+WheelScrollDown".focus-workspace-down = {};
          "Mod+Ctrl+WheelScrollUp".focus-workspace-up = {};

          "Mod+1".focus-workspace = 1;
          "Mod+2".focus-workspace = 2;
          "Mod+3".focus-workspace = 3;
          "Mod+4".focus-workspace = 4;
          "Mod+5".focus-workspace = 5;
          "Mod+6".focus-workspace = 6;
          "Mod+7".focus-workspace = 7;
          "Mod+8".focus-workspace = 8;
          "Mod+9".focus-workspace = 9;
          "Mod+0".focus-workspace = 10;

          "Mod+Shift+1".move-column-to-workspace = 1;
          "Mod+Shift+2".move-column-to-workspace = 2;
          "Mod+Shift+3".move-column-to-workspace = 3;
          "Mod+Shift+4".move-column-to-workspace = 4;
          "Mod+Shift+5".move-column-to-workspace = 5;
          "Mod+Shift+6".move-column-to-workspace = 6;
          "Mod+Shift+7".move-column-to-workspace = 7;
          "Mod+Shift+8".move-column-to-workspace = 8;
          "Mod+Shift+9".move-column-to-workspace = 9;
          "Mod+Shift+0".move-column-to-workspace = 10;
        };

        layout = {
          gaps = 3;

          # focus-ring = {
          #   width = 2;
          #   active-color = "#${self.themeNoHash.base09}";
          # };
        };

        xwayland-satellite.path =
          lib.getExe pkgs.xwayland-satellite;

        spawn-at-startup = [
          noctaliaExe
        ];
      };
    };
  };

  flake.nixosModules.niri = { ... }: {
    programs.niri = {
      enable = true;
      package = self.packages."x86_64-linux".niri;
    };
  };
}
