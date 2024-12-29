{ pkgs, ... }: {
  home.packages = with pkgs; [
    telegram-desktop
    obsidian
    gh
    prismlauncher # minecraft
    vscode
    torrential
  ];
}
