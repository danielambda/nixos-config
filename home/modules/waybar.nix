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
          "custom/startmenu"
          "pulseaudio"
        ];
        modules-center = [
          "hyprland/workspaces"
        ];
        modules-right = [
          "battery"
          "clock"
        ];

        "custom/startmenu" = {
          tooltip = false;
          format = "";
          on-click = "sleep 0.1 && ${lib.getExe pkgs.rofi-wayland} -show drun";
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
          font-size: 16px;
        }
        window#waybar {
          background: rgba(0,0,0,0);
        }

        #workspaces {
          margin: 4px;
          padding: 2px;
          background: #${config.stylix.base16Scheme.base00};
          border-radius: 16px;
        }

        #workspaces button {
          font-weight: bold;
          padding: 0px 6px;
          margin: 2px;
          border-radius: 16px;
          color: #${config.stylix.base16Scheme.base00};
          background-color: #${config.stylix.base16Scheme.base04};
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
          color: #${config.stylix.base16Scheme.base04};
        }

        #pulseaudio, #battery {
          font-weight: bold;
          background: #${config.stylix.base16Scheme.base04};
          color: #${config.stylix.base16Scheme.base00};
          margin: 4px;
          padding: 0px 16px;
          border-radius: 16px;
        }
        #custom-startmenu {
          color: #${config.stylix.base16Scheme.base04};
          background: #${config.stylix.base16Scheme.base00};
          font-size: 24px;
          margin: 4px;
          padding: 0px 15px 0px 4px;
          border-radius: 16px;
        }
        #clock {
          font-weight: bold;
          color: #${config.stylix.base16Scheme.base04};
          background: #${config.stylix.base16Scheme.base00};
          font-size: 16px;
          margin: 4px;
          padding: 0px 16px;
          border-radius: 16px;
        }
      '';
  };
}

