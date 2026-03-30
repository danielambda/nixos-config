{ self, ... }: {
  flake.flake-dir = "/home/daniel/projects/nix/nixos-config";
  flake.nixosModules.users = { pkgs, lib, ... }:
  let selfpkgs = self.packages.${pkgs.stdenv.hostPlatform.system}; in
  {
    programs.zsh.enable = true;
    environment.pathsToLink = ["/share/zsh"];
    environment.systemPackages = (with selfpkgs; [
      zsh
      testvim
      nvim
    ]) ++ (with pkgs; [
      smplayer
      mpv-unwrapped
      cmus
      jq
      postgresql
      zoom-us
    ]) ++ [(pkgs.writeShellApplication {
      name = "flakify";
      text = ''
        if [ ! -e flake.nix ]; then
          nix flake new -t ${self.flake-dir}/devshell-flake-template .
        elif [ ! -e .envrc ]; then
          echo "use flake" > .envrc
          direnv allow
        fi
      '';
    })];

    users.defaultUserShell = selfpkgs.zsh;
    environment.variables.EDITOR = lib.getExe selfpkgs.nvim;

    users.users.daniel = {
      isNormalUser = true;
      extraGroups = ["networkmanager" "wheel" "input"];
    };

    security.sudo.wheelNeedsPassword = false;

    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = lib.getExe selfpkgs.niri;
          user = "daniel";
        };
      };
    };
  };
}
