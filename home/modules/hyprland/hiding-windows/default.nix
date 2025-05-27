{ pkgs, lib, config, ... }:
let
  cfg = config.my.hyprland.hidingWindows;
  defaultHidingWindow = lib.mkOptionType {
    name = "Default Hiding Window";
    check = window:
      builtins.hasAttr "bindKey" window &&
      builtins.hasAttr "launch" window &&
      builtins.hasAttr "class" window;
  };
  ffpwaHidingWindow = lib.mkOptionType {
    name = "Firefox PWA Hiding Window";
    check = window:
      builtins.hasAttr "bindKey" window &&
      builtins.hasAttr "id" window;
  };

  jq = lib.getExe pkgs.jq;

  hidingWorkspace = "special:hiding";

  classToWindowSelector = class: "class:(${class})";

  mkFfpwaBind = { bindMod ? "$mainMod", bindKey, id, centerOnShow ? true, ... }:
    mkBind {
      inherit bindMod bindKey centerOnShow;
      launch = "${lib.getExe pkgs.firefoxpwa} site launch ${id}";
      class = "FFPWA-${id}";
    };

  mkBind = { bindMod ? "$mainMod", bindKey, launch, class, centerOnShow ? true, ... }:
    let window = classToWindowSelector class; in
    "${bindMod}, ${bindKey}, exec, ${lib.getExe (pkgs.writeShellApplication {
      name = class;
      text = ''
        activeWorkspace=$(hyprctl activeworkspace -j | ${jq} -r '.name')
        case $(hyprctl clients -j | ${jq} -r 'map(select(.class=="${class}")).[].workspace.name') in
        "")
          ${launch}
        ;;
        "$activeWorkspace")
          if [ "$(hyprctl activewindow | grep -c 'class:.*${class}')" = "0" ]; then
            hyprctl dispatch alterzorder "top,${window}"
            hyprctl dispatch focuswindow "${window}"
          else
            hyprctl dispatch movetoworkspacesilent "${hidingWorkspace},${window}"
          fi
        ;;
        *) # hiding or any other workspace
          hyprctl dispatch movetoworkspace "+0,${window}"
          hyprctl dispatch alterzorder "top,${window}"
          ${if centerOnShow then /*bash*/''
            hyprctl dispatch focuswindow "${window}"
            hyprctl dispatch centerwindow 1
          '' else ""}
          sleep 0.2
          hyprctl dispatch focuswindow "${window}"
        ;;
        esac
      '';
    })}";

  mkFfpwaWindowrules = { id, windowrules ? {}, centerOnShow ? true, ... }:
    mkWindowrules { class = "FFPWA-${id}"; inherit windowrules centerOnShow; };

  mkWindowrules = { class, windowrules ? {}, centerOnShow ? true, ... }:
    let window = classToWindowSelector class;
    in ["float, ${window}"]
    ++ (if centerOnShow then ["center 1, ${window}"] else [])
    ++ builtins.attrValues (
      builtins.mapAttrs
        (name: value: "${name} ${toString value}, ${window}")
        windowrules
    );
in {
  imports = [
    # ./social.nix
  ];

  options.my.hyprland.hidingWindows = {
    enable = lib.mkEnableOption "Enable Hyprland Hiding Windows";

    default = lib.mkOption {
      type = lib.types.listOf defaultHidingWindow;
      default = [];
      example = [
        {
          bindMod = "$mainMod <optional>";
          bindKey = "S";
          class = "org.telegram.desktop";
          launch = lib.getExe pkgs.telegram-desktop;
          windowrules = {
            windowrulesAreOptional = true;
            monitor = 0;
            bordercolor = "rgba(8f99f5c0)";
          };
        }
      ];
      description = "List of hiding windows with default implemenation";
    };

    ffpwa = lib.mkOption {
      type = lib.types.listOf ffpwaHidingWindow;
      default = [];
      example = [
        {
          bindMod = "$mainMod <optional>";
          bindKey = "T";
          id = "01J9H12Z45YVGP5QMYJ4G6EPFH";
          windowrules = {
            windowrulesAreOptional = true;
            center = true;
            monitor = 0;
            bordercolor = "rgba(fed42bc0)";
          };
        }
      ];
      description = "List of hiding windows tweaked for FFPWA";
    };
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland.settings.bind =
      map mkBind cfg.default ++
      map mkFfpwaBind cfg.ffpwa;

    wayland.windowManager.hyprland.settings.windowrulev2 =
      lib.lists.flatten (
        map mkWindowrules cfg.default ++
        map mkFfpwaWindowrules cfg.ffpwa
      );
  };
}
