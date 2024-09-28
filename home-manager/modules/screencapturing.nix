{ pkgs, ...}: {
  home.packages = with pkgs; [
    wl-clipboard

    swappy

    wf-recorder
  ];
}
