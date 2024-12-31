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

      ls =   "${lib.getExe pkgs.eza} --icons --group-directories-first";
      lsa =  "${lib.getExe pkgs.eza} --icons --group-directories-first -a";
      tree = "${lib.getExe pkgs.eza} --icons --color=auto --tree";
      grep = "grep --color=auto";
      cat = "${lib.getExe pkgs.bat}";
      ":q" = "exit";
      v = lib.getExe pkgs.neovim;
    };
  };
}
