{ pkgs, ... }: {
  home.packages = with pkgs; [
    discord
    cmus
    jq
    postgresql
    zoom-us
  ];
}
