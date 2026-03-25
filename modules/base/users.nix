{ self, ... }: {
  flake.nixosModules.users = { pkgs, lib, ... }:
  let selfpkgs = self.packages.${pkgs.system}; in
  {
    programs.zsh.enable = true;

    users.defaultUserShell = selfpkgs.zsh;
    environment.variables.EDITOR = "nvim"; # TODO use wrapped nvim

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
