{ pkgs, inputs, system, ... }: {
  home.packages = with pkgs; [
    telegram-desktop
    obsidian
    gh
    prismlauncher # minecraft
    inputs.zen-browser.packages."${system}".specific
  ];
}
