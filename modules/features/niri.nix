{ inputs, self, ... }:
let colors = self.hashColors; in
{
  perSystem = { pkgs, lib, self', system, ... }: {
    packages.niri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs;
      settings = let noctaliaExe = lib.getExe self'.packages.noctalia; in {
        prefer-no-csd = _: {};

        layout = {
          gaps = 8;
          always-center-single-column = _: {};
          empty-workspace-above-first = _: {};

          focus-ring = {
            on = _: {};
            width = 3;
            active-color = colors.base00;
            inactive-color = colors.base03;
            urgent-color = colors.base08;
          };

          shadow.off = _: {};
          insert-hint.color = "${colors.base03}80";
        };

        input = {
          focus-follows-mouse = _: {
            props.max-scroll-amount = "10%";
            content = {};
          };
          warp-mouse-to-focus = _: {
            props.mode= "center-xy-always";
            content = {};
          };

          keyboard = {
            xkb = {
              layout = "us,ru";
              options = "grp:alt_shift_toggle";
            };
          };

          touchpad = {
            natural-scroll = _: {};
            tap = _: {};
            dwt = _: {}; # disable when typing
            click-method = "clickfinger";
          };
          touch.map-to-output = "eDP-1";
        };

        outputs = let
          secondMonitorSettings = {
            mode = "1920x1080@60.000";
            scale = 1;
            position = _: {
              props = {
                x = -1920;
                y = 0;
              };
              content = _: {};
            };
            hot-corners.top-left = _: {};
          };
        in {
          eDP-1 = {
            focus-at-startup = _: {};
            mode = "3120x2080@60.000";
            scale = 2.88888888;
            position = _: {
              props = {
                x = 0;
                y = 0;
              };
              content = _: {};
            };
            hot-corners.top-right = _: {};
          };
          DP-2 = secondMonitorSettings;
          DP-4 = secondMonitorSettings;
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
              cmd = lib.getExe pkgs.pavucontrol;
            }
            {
              key = "v";
              desc = "Vial";
              cmd = lib.getExe pkgs.vial;
            }
            {
              key = "r";
              desc = "Run";
              cmd = "${noctaliaExe} ipc call launcher toggle";
            }
          ];

          "Mod+Return".spawn = lib.getExe self'.packages.kitty;

          "Mod+Q".close-window = _: {};
          "Mod+C".center-column = _: {};
          "Mod+F".fullscreen-window = _: {};
          "Mod+Ctrl+F".maximize-column = _: {};
          "Mod+G".toggle-window-floating = _: {};
          "Mod+Ctrl+G".focus-monitor-next = _: {};

          "Mod+H".focus-column-left = _: {};
          "Mod+L".focus-column-right = _: {};
          "Mod+K".focus-window-or-workspace-up = _: {};
          "Mod+J".focus-window-or-workspace-down = _: {};

          "Mod+semicolon".focus-monitor-next = _: {};
          "Mod+Ctrl+semicolon".move-window-to-monitor-next = _: {};

          "Mod+Ctrl+H".move-column-left = _: {};
          "Mod+Ctrl+L".move-column-right = _: {};
          "Mod+Ctrl+K".move-window-up-or-to-workspace-up = _: {};
          "Mod+Ctrl+J".move-window-down-or-to-workspace-down = _: {};

          "Mod+Ctrl+Shift+H".move-workspace-to-monitor-left = _: {};
          "Mod+Ctrl+Shift+L".move-workspace-to-monitor-right = _: {};

          "Mod+Shift+H".set-column-width = "-5%";
          "Mod+Shift+L".set-column-width = "+5%";
          "Mod+Shift+J".set-window-height = "+5%";
          "Mod+Shift+K".set-window-height = "-5%";

          "Mod+WheelScrollDown".focus-column-left = _: {};
          "Mod+WheelScrollUp".focus-column-right = _: {};
          "Mod+Ctrl+WheelScrollDown".focus-workspace-down = _: {};
          "Mod+Ctrl+WheelScrollUp".focus-workspace-up = _: {};

          "XF86AudioRaiseVolume".spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+";
          "XF86AudioLowerVolume".spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-";
          "XF86AudioMute".spawn-sh        = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";

          "XF86AudioPlay".spawn-sh  = "${lib.getExe pkgs.playerctl} play";
          "XF86AudioPause".spawn-sh = "${lib.getExe pkgs.playerctl} pause";
          "XF86AudioNext".spawn-sh  = "${lib.getExe pkgs.playerctl} next";
          "XF86AudioPrev".spawn-sh  = "${lib.getExe pkgs.playerctl} previous";

          "XF86MonBrightnessUp".spawn-sh   = "${lib.getExe pkgs.brightnessctl} -q set +1%";
          "XF86MonBrightnessDown".spawn-sh = "${lib.getExe pkgs.brightnessctl} -q set 1%-";

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

          "Print".spawn-sh = /*bash*/''
            ${lib.getExe pkgs.niri} msg action screenshot-screen
          '';
          "Shift+Print".spawn-sh = /*bash*/''
            ${lib.getExe pkgs.niri} msg action screenshot-window
          '';
          "Mod+Print".spawn-sh = /*bash*/''
            ${lib.getExe pkgs.grim} -g "$(${lib.getExe pkgs.slurp} -w 0)" - | ${pkgs.wl-clipboard}/bin/wl-copy
          '';
        };

        xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

        spawn-at-startup = [noctaliaExe];
      };
    };
  };

  flake.nixosModules.niri = { pkgs, ... }: {
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.niri;
    };
    programs.xwayland.enable = true;

    environment.systemPackages = with pkgs; [
      wl-clipboard

      xdg-desktop-portal
      xdg-desktop-portal-gtk
    ];

    systemd.user.services = {
      "xdg-desktop-portal" = {
        enable = true;
        serviceConfig.Environment = [
          "XDG_SESSION_TYPE=wayland"
          "WAYLAND_DISPLAY=wayland-1"
        ];
      };

      "xdg-desktop-portal-gtk" = {
        enable = true;
        serviceConfig.Environment = [
          "XDG_SESSION_TYPE=wayland"
          "WAYLAND_DISPLAY=wayland-1"
        ];
      };
    };
  };
}
