{ pkgs, lib, ... }:
let jq = lib.getExe pkgs.jq;
in rec {
  minimizeWorkspace = "special:minimize";
  mainMonWorkspace = /*bash*/
    ''"$(hyprctl monitors -j | ${jq} 'map(select(.id==0)).[].activeWorkspace.id')"'';

  mkFirefoxpwaHidingWindowBind = { bindMod ? "$mainMod", bindKey, id }:
    mkHidingWindowBind {
      inherit bindMod bindKey;
      launch = "${lib.getExe pkgs.firefoxpwa} site launch ${id}";
      class = "FFPWA-${id}";
    };

  mkHidingWindowBind = { bindMod ? "$mainMod", bindKey, launch, class }:
    let window = "class:${class}"; in
    "${bindMod}, ${bindKey}, exec, ${lib.getExe (pkgs.writeShellApplication {
      name = window;
      text = ''
         case $(hyprctl clients -j | ${jq} -r 'map(select(.initialClass=="${class}")).[].workspace.name') in
         "")
             ${launch}
             hyprctl dispatch movefocus ${window}
         ;;
         "${minimizeWorkspace}")
             hyprctl dispatch movetoworkspace ${mainMonWorkspace},${window}
         ;;
         *)
             hyprctl dispatch movetoworkspacesilent ${minimizeWorkspace},${window}
         ;;
         esac
      '';
    })}";
}
