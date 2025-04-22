{ pkgs, ... }: {
  home.packages = with pkgs; [
    obsidian
    gh
    prismlauncher # minecraft
    nekoray
  ];
}
