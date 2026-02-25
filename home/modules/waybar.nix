{ pkgs
, lib
, config
, ...
}: {
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    settings = [
      {
        layer = "top";
        position = "top";

        modules-left = [
          "pulseaudio"
        ];
        modules-center = [
          "hyprland/workspaces"
        ];
        modules-right = [
          "tray"
          "battery"
          "clock"
        ];

        "custom/startmenu" = {
          tooltip = false;
          format = "";
          on-click = "sleep 0.1 && ${lib.getExe pkgs.rofi} -show drun";
        };

        "pulseaudio" = {
          format =                 "{icon} {volume}%  {format_source}";
          format-bluetooth =       " {icon} {volume}%  {format_source}";
          format-muted =           "  {format_source}";
          format-bluetooth-muted = " {icon}  {format_source}";
          format-source =          " {volume}%";
          format-source-muted =    " ";
          format-icons = {
            headphone = " ";
            hands-free = " ";
            headset = " ";
            phone = " ";
            portable = " ";
            default = [ " " " " ];
          };
          on-click = "sleep 0.1 && ${lib.getExe pkgs.pavucontrol}";
        };

        "hyprland/workspaces" = {
          format = "{name}";
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
        };

        "battery" = {
          tooltip = true;
          states = {
            warning = 30;
            critical = 16;
          };
          format = "{icon} {capacity}%";
          format-icons = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
          format-charging = "󰂄 {capacity}%";
          tooltip-format = "{timeTo}";
          interval = 60; #seconds
        };

        "clock" = {
          tooltip = false;
          format = "{:L%H:%M}";
          format-alt = "{:L%d %b %Y %a %R}";
          interval = 60; #seconds
        };
      }
    ];
    style =
      /*css*/''
        * {
          font-family: 'JetBrainsMono Font Propo', sans-serif;
          font-size: 12px;
          font-weight: bold;
          padding: 0px;
          margin: 0px;
        }
        window#waybar {
          background: rgba(0,0,0,0.4);
        }

        #workspaces {
          margin: 0px 4px;
          font-weight: bold;
          background: #${config.stylix.base16Scheme.base00};
          border-radius: 0px 0px 16px 16px;
        }

        #workspaces button {
          font-weight: bold;
          padding: 0px 4px;
          margin: 0px 2px 2px 2px;
          border-radius: 0px 0px 12px 12px;
          color: #${config.stylix.base16Scheme.base00};
          background-color: #${config.stylix.base16Scheme.base05};
          opacity: 0.5;
        }
        #workspaces button.active {
          opacity: 1.0;
        }
        #workspaces button:hover {
          opacity: 0.75;
        }

        tooltip {
          background: #${config.stylix.base16Scheme.base00};
          border-radius: 8px;
        }
        tooltip label {
          color: #${config.stylix.base16Scheme.base05};
        }

        #pulseaudio {
          font-weight: bold;
          background: #${config.stylix.base16Scheme.base05};
          color: #${config.stylix.base16Scheme.base00};
          margin: 0px 4px 0px 0px;
          padding: 0px 12px;
          border-radius: 0px 0px 12px 0px;
        }

        #battery {
          font-weight: bold;
          background: #${config.stylix.base16Scheme.base05};
          color: #${config.stylix.base16Scheme.base00};
          margin: 0px 4px;
          padding: 0px 12px;
          border-radius: 0px 0px 12px 12px;
        }

        #clock {
          font-weight: bold;
          color: #${config.stylix.base16Scheme.base05};
          background: #${config.stylix.base16Scheme.base00};
          margin: 0px 0px 0px 4px;
          padding: 0px 12px;
          border-radius: 0px 0px 0px 12px;
        }
      '';
  };
}

