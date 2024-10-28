{ pkgs, lib, ... }:
let flakeDir = "/home/daniel/projects/nix/nixos-config/";
in {
  imports = [./oh-my-posh.nix];

  programs.zsh = {
    enable = true;
    enableCompletion = true;

    syntaxHighlighting.enable = true;

    shellAliases = {
      hms = "home-manager switch --flake ${flakeDir}";
      hmnews = "home-manager news --flake ${flakeDir}";
      rb = "sudo nixos-rebuild switch --flake ${flakeDir}";

      ls = "${lib.getExe pkgs.eza} --icons --group-directories-first";
      tree = "${lib.getExe pkgs.eza} --color=auto --icons --tree";
      grep = "grep --color=auto";
      ":q" = "exit";
      v = "nvim";
    };
  };
}
