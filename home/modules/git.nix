{ lib, pkgs, ... }: {
  programs.git = {
    enable = true;
    userName = "danielambda";
    userEmail = "daniel.gevorgyan25@gmail.com";

    extraConfig = {
      init.defaultBranch = "main";
      credential.helper = "!${lib.getExe pkgs.gh} auth git-credential";
    };
  };
}
