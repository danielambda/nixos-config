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
