{ pkgs, ... }: {
  home.packages = with pkgs; [
    discord
    mattermost-desktop
    cmus
    jq
    postgresql
    zoom-us
  ];
}
