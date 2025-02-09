{ pkgs, lib, ... }: {
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;

    nix-direnv.enable = true;
  };

  home.packages = [(pkgs.writeShellApplication {
    name = "flakify";
    text = ''
      if [ ! -e flake.nix ]; then
        nix flake new -t github:danielambda/devshell-flake-template .
      elif [ ! -e .envrc ]; then
        echo "use flake" > .envrc
        ${lib.getExe pkgs.direnv} allow
      fi
    '';
  })];
}
