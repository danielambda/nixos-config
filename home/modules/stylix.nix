{ inputs, pkgs, shared, ... }: {
  imports = [inputs.stylix.homeManagerModules.stylix];

  stylix = import /${shared}/stylix { inherit pkgs; }
  // { targets.neovim.enable = false; };
}
