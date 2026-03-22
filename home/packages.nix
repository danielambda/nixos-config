{ pkgs, ... }: {
  home.packages = with pkgs; [
    smplayer
    mpv-unwrapped
    cmus
    jq
    postgresql
    zoom-us
  ];
}
