{ pkgs, ... }: {
  imports = [./plugins.nix];

  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraLuaConfig = ''
      ${builtins.readFile ./lua/remap.lua}
      ${builtins.readFile ./lua/set.lua}
    '';

    defaultEditor = true;

    extraPackages = with pkgs; [
      wl-clipboard
      rust-analyzer
      haskell-language-server
      omnisharp-roslyn
      nodePackages.typescript-language-server
      pyright
      lua-language-server
      nixd
      ripgrep
    ];	
  };
}
