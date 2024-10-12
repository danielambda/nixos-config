{ pkgs, ... }: {
  imports = [./plugins.nix];

  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraLuaConfig = /*lua*/''
      ${builtins.readFile ./lua/set.lua}
      ${builtins.readFile ./lua/remap.lua}
      ${builtins.readFile ./lua/autocommands.lua}
    '';

    extraConfig = /*vim*/''
      set tabstop=4
      set softtabstop=4
      set shiftwidth=4
      set expandtab
      set smartindent
    '';

    defaultEditor = true;

    extraPackages = with pkgs; [
      ripgrep

      lua-language-server
      nixd
      rust-analyzer
      pyright
      omnisharp-roslyn
      clang-tools
    ];
  };
}
