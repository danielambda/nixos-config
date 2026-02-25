{ lib, pkgs, ... }: {
  home.packages = [pkgs.difftastic];

  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "danielambda";
        email = "daniel.gevorgyan25@gmail.com";
        signingkey = "~/.ssh/id_ed25519.pub";
      };
      commit.gpgSign = true;
      gpg = {
        format = "ssh";
        ssh.allowedSignersFile = "~/.ssh/allowed_signers";
      };

      init.defaultBranch = "main";
      credential.helper = "!${lib.getExe pkgs.gh} auth git-credential";

      merge.conflictStyle = "diff3";
      interactive.diffFilter = "difft --color=always";

      diff = {
        tool = "difftastic";
        external = lib.getExe pkgs.difftastic;
      };
      difftool.prompt = false;
      difftool.difftastic.cmd = "${lib.getExe pkgs.difftastic} \"$LOCAL\" \"$REMOTE\"";
      pager.difftastic = true;
    };
  };
}
