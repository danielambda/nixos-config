{ pkgs, lib, ... }:
let
  musicId = "01J9MHDYPWYKKGS4QS9YDRYJ25";
  musicClass = "FFPWA-${musicId}";
  musicWindow = "class:${musicClass}";
  minimizeWorkspace = "special:minimize";
in {
  wayland.windowManager.hyprland.settings.windowrulev2 = [
    "pin, ${musicWindow}"
    "float, ${musicWindow}"
    "center, ${musicWindow}"
    "size 720 1080, ${musicWindow}"
    "bordercolor rgba(fed42bc0), ${musicWindow}" #fed42bc0
  ];
  wayland.windowManager.hyprland.settings.bind = [
    "$mainMod, M, exec, ${lib.getExe (pkgs.writeShellApplication {
      name = "ToggleMusic";
      text = ''
        case $(hyprctl clients -j | ${lib.getExe pkgs.jq} -r 'map(select(.class=="${musicClass}")).[].workspace.name') in
        "")
            ${lib.getExe pkgs.firefoxpwa} site launch ${musicId}
            hyprctl dispatch movefocus ${musicWindow}
        ;;
        "${minimizeWorkspace}")
            hyprctl dispatch movetoworkspace +0,${musicWindow}
            hyprctl dispatch pin ${musicWindow}
        ;;
        *)
            hyprctl dispatch pin ${musicWindow}
            hyprctl dispatch movetoworkspacesilent ${minimizeWorkspace},${musicWindow}
        ;;
        esac
      '';
    })}"
  ];
}
