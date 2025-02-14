{
  imports = [
    ./modules
    ./packages.nix
  ];

  home.username = "daniel";
  home.homeDirectory = "/home/daniel";

  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;

  home.stateVersion = "23.11"; # Please read the comment
}
