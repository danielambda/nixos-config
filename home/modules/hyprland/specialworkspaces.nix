{ ... }:
let 
  specialWorkspace = { 
    bind, 
    launchCommand, 
    name, 
    windowSelector, # TODO maybe this is not needed and exec rules are sufficient
    windowRules ? "", 
    workspaceRules ? null
  }: {
    workspace = if workspaceRules == null then []
      else ["name:${name}, ${workspaceRules}"];

    windowrulev2 = ["workspace special:${name}, ${windowSelector}"];

    bind = ["${bind}, exec, [${windowRules}] ${launchCommand}"];
  };
in {
  wayland.windowManager.hyprland.settings = {}
    // specialWorkspace rec {
      bind = "$mainMod, M";
      launchCommand = "TODO"; # TODO
      name = "music";
      windowSelector = "initialTitle:(TODO)"; # TODO
      windowRules = "float; center; size 865 1210; workspace name: ${name}"; # TODO maybe move workspace name to funciton
    }
    ;
}
