{ self, ... }: {
  flake.flake-dir = "/home/daniel/projects/nix/nixos-config";
  flake.nixosModules.users = { pkgs, lib, ... }:
  let selfpkgs = self.packages.${pkgs.stdenv.hostPlatform.system}; in
  {
    imports = [self.nixosModules.zsh];

    programs.zsh = {
      enable = true;
      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
    };

    environment.pathsToLink = ["/share/zsh"];
    environment.systemPackages = (with selfpkgs; [
      zsh
      testvim
      nvim
      git
      tmux
      t
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
      extraGroups = ["networkmanager" "wheel" "input" "docker"];
    };
    virtualisation.docker.enable = true;

    security.sudo.wheelNeedsPassword = false;

    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

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
