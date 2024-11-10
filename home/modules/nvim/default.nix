{ pkgs, ... }: {
  imports = [
    ./plugins.nix
    ./languages
  ];

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
      set tabstop=2
      set softtabstop=2
      set shiftwidth=2
      set expandtab
      set smartindent

      set termguicolors

      set colorcolumn=0
    '';

    defaultEditor = true;
  };

  home.packages = with pkgs; [
    ripgrep

    lua-language-server
    nixd
    rust-analyzer
    omnisharp-roslyn
    clang-tools
  ];
}
