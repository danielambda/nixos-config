{ inputs, ... }: {
  perSystem = { pkgs, lib, ... }: {
    packages.git = inputs.wrapper-modules.wrappers.git.wrap {
      inherit pkgs;
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
        color.ui = "auto";

        diff = {
          tool = "difftastic";
          external = lib.getExe pkgs.difftastic;
        };
        difftool.prompt = false;
        difftool.difftastic.cmd = "${lib.getExe pkgs.difftastic} \"$LOCAL\" \"$REMOTE\"";
        pager.difftastic = true;

        rerere.enabled = true;
        rebase = {
          updateRefs = true;
          autoSquash = true;
        };

        alias = {
          pushstack = "push --force-with-lease --force-if-includes origin";
          l = "log --oneline --graph --decorate -20";
          ll = "log --graph --pretty=format:'%C(yellow)%h%Creset %C(cyan)%ad%Creset %C(green)%an%Creset %s %C(auto)%d%Creset' --date=short";
          lg = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all";
          graph = "log --all --graph --decorate --oneline --simplify-by-decoration";
          fix = "!git commit --fixup=$(git log --oneline | fzf | cut -d\" \" -f1)";
          ri = "rebase -i";
        };
      };
    };
  };
}
