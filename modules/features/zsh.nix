{ inputs, self, ... }: {
  perSystem = { pkgs, lib, ... }: {
    packages.zsh = inputs.wrapper-modules.wrappers.zsh.wrap {
      inherit pkgs;

      zshAliases = {
        rb = "sudo nixos-rebuild switch --flake /home/daniel/projects/nix/nixos-config#main";

        ls   = "${lib.getExe pkgs.eza} --icons --group-directories-first";
        lsa  = "${lib.getExe pkgs.eza} --icons --group-directories-first -a";
        tree = "${lib.getExe pkgs.eza} --icons --color=auto --tree";
        grep = "grep --color=auto";
        cat  = "${lib.getExe pkgs.bat}";
        ":q" = "exit";
        v = "nvim";
        cdtmp = "cd `mktemp -d`";
        rf = "rm -rf";
      };
    };
  };
}
