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
  mainMonWorkspace = /*bash*/
    ''"$(hyprctl monitors -j | ${jq} 'map(select(.id==0)).[].activeWorkspace.id')"'';

  classToWindowSelector = class: "class:(${class})";

  mkFfpwaBind = { bindMod ? "$mainMod", bindKey, id, ... }:
    mkBind {
      inherit bindMod bindKey;
      launch = "${lib.getExe pkgs.firefoxpwa} site launch ${id}";
      class = "FFPWA-${id}";
    };

  mkBind = { bindMod ? "$mainMod", bindKey, launch, class, ... }:
    let window = "class:${class}"; in
    "${bindMod}, ${bindKey}, exec, ${lib.getExe (pkgs.writeShellApplication {
      name = window;
      text = ''
        # activeWindowClass=$(hyprctl activewindow | grep -oP "initialClass:\K.*" | tr -d " ")
        case $(hyprctl clients -j | ${jq} -r 'map(select(.initialClass=="${class}")).[].workspace.name') in
        "")
            ${launch}
        ;;
        "${hidingWorkspace}")
            hyprctl dispatch movetoworkspace ${mainMonWorkspace},${window}
            hyprctl dispatch alterzorder top,${window}
        ;;
        *)
            hyprctl dispatch movetoworkspacesilent ${hidingWorkspace},${window}
        ;;
        esac
      '';
    })}";

  mkFfpwaWindowrules = { id, windowrules ? {}, ... }:
    mkWindowrules { class = "FFPWA-${id}"; inherit windowrules; };

  mkWindowrules = { class, windowrules ? {}, ... }:
    let window = classToWindowSelector class;
    in ["float, ${window}"] ++
    builtins.attrValues (
      builtins.mapAttrs
        (name: value: "${name} ${toString value}, ${window}")
        windowrules
    );
in {
  imports = [
    ./music.nix
    ./social.nix
    ./task-manager.nix
    ./music-alt.nix
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
