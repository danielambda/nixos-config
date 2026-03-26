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

          "Mod+Left".focus-column-left = {};
          "Mod+Right".focus-column-right = {};
          "Mod+Up".focus-window-up = {};
          "Mod+Down".focus-window-down = {};

          "Mod+Ctrl+H".move-column-left = {};
          "Mod+Ctrl+L".move-column-right = {};
          "Mod+Ctrl+K".move-window-up = {};
          "Mod+Ctrl+J".move-window-down = {};

          "XF86AudioRaiseVolume".spawn-sh = "wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 1%+";
          "XF86AudioLowerVolume".spawn-sh = "wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 1%-";

          "Mod+Shift+H".set-column-width = "-5%";
          "Mod+Shift+L".set-column-width = "+5%";
          "Mod+Shift+J".set-window-height = "-5%";
          "Mod+Shift+K".set-window-height = "+5%";

          "Mod+WheelScrollDown".focus-column-left = {};
          "Mod+WheelScrollUp".focus-column-right = {};
          "Mod+Ctrl+WheelScrollDown".focus-workspace-down = {};
          "Mod+Ctrl+WheelScrollUp".focus-workspace-up = {};
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
