{ pkgs, lib, ... }: {
  imports = [./oh-my-posh.nix];

  programs.zsh = {
    enable = true;
    enableCompletion = true;

    syntaxHighlighting.enable = true;

    shellAliases = {
      hms = "home-manager switch --flake /home/daniel/nix";
      hmnews = "home-manager news --flake /home/daniel/nix";
      rb = "sudo nixos-rebuild switch --flake /home/daniel/nix";

      ls = "${lib.getExe pkgs.eza} --icons --group-directories-first";
      tree = "${lib.getExe pkgs.eza} --color=auto --icons --tree";
      grep = "grep --color=auto";
      ":q" = "exit";
      v = "nvim";
    };
  };
}
