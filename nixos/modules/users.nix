{ pkgs, ... }: {
  programs.zsh.enable = true;

  users.defaultUserShell = pkgs.zsh;
  environment.variables.EDITOR = "nvim";

  users.users.daniel = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "input"];
  };

  security.sudo.wheelNeedsPassword = false;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "Hyprland";
        user = "daniel";
      };
    };
  };
}
