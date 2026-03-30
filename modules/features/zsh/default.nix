{ self, inputs, ... }: {
  flake.nixosModules.zsh = { lib, pkgs, config, ... }:
  let cfg = config.programs.zsh; in
  {
    options.programs.zsh = {
      direnv = {
        enable = lib.mkEnableOption "direnv, the environment switcher";
        nix-direnv.enable = lib.mkEnableOption ''
          [nix-direnv](https://github.com/nix-community/nix-direnv),
          a fast, persistent use_nix implementation for direnv
        '';
      };
    };
    config = {
      environment.systemPackages
        =  (if cfg.direnv.enable then [pkgs.direnv] else [])
        ++ (if cfg.direnv.nix-direnv.enable then [pkgs.nix-direnv] else [])
        ;
    };
  };

  perSystem = { pkgs, lib, ... }: {
    packages.zsh = inputs.wrapper-modules.wrappers.zsh.wrap {
      inherit pkgs;

      zshAliases = {
        rb = "sudo nixos-rebuild switch --flake ${self.flake-dir}#main";

        ls   = "${lib.getExe pkgs.eza} --icons --group-directories-first";
        ll   = "${lib.getExe pkgs.eza} --icons --group-directories-first -l";
        lsa  = "${lib.getExe pkgs.eza} --icons --group-directories-first -a";
        lla  = "${lib.getExe pkgs.eza} --icons --group-directories-first -la";
        tree = "${lib.getExe pkgs.eza} --icons --color=auto --tree";
        grep = "grep --color=auto";
        cat  = lib.getExe pkgs.bat;
        ":q" = "exit";
        v = "nvim";
        cdtmp = "cd `mktemp -d`";
        rf = "rm -rf";
      };

      zshrc.content = /*zsh*/''
        autoload -U compinit && compinit
        HISTSIZE="10000"
        SAVEHIST="10000"

        HISTFILE="$HOME/.zsh_history"
        mkdir -p "$(dirname "$HISTFILE")"

        # Set shell options
        set_opts=(
          HIST_FCNTL_LOCK HIST_IGNORE_DUPS HIST_IGNORE_SPACE SHARE_HISTORY
          NO_APPEND_HISTORY NO_EXTENDED_HISTORY NO_HIST_EXPIRE_DUPS_FIRST
          NO_HIST_FIND_NO_DUPS NO_HIST_IGNORE_ALL_DUPS NO_HIST_SAVE_NO_DUPS
        )
        for opt in "''${set_opts[@]}"; do
          setopt "$opt"
        done
        unset opt set_opts

        # Prefix-based history search with up/down arrows
        bindkey "^[OA" history-beginning-search-backward   # Up arrow
        bindkey "^[OB" history-beginning-search-forward    # Down arrow

        export MANPAGER='nvim +Man!'

        eval "$(${lib.getExe pkgs.oh-my-posh} init zsh --config ${self.oh-my-posh-config-file})"
        eval "$(${lib.getExe pkgs.direnv} hook zsh)"

        if test -n "$KITTY_INSTALLATION_DIR"; then
          export KITTY_SHELL_INTEGRATION="no-rc"
          autoload -Uz -- "$KITTY_INSTALLATION_DIR"/shell-integration/zsh/kitty-integration
          kitty-integration
          unfunction kitty-integration
        fi

        source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
        ZSH_HIGHLIGHT_HIGHLIGHTERS=(main)
      '';
    };
  };
}
