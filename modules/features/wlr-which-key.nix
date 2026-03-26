{ inputs, self, lib, ... }: let
  mkWhichKey = pkgs: menu:
    (self.wrapperModules.which-key.wrap {
      inherit pkgs;
      settings = {
        inherit menu;

        font = "JetBrainsMono Nerd Font 12";
        # background = self.theme.base00;
        # color = self.theme.base06;
        # border = self.theme.base0F;
        separator = " ➜ ";
        border_width = 8;
        corner_r = 16;
        padding = 16;
        rows_per_column = 2;
        column_padding = 24;

        anchor = "bottom-right";
        margin_right = 8;
        margin_bottom = 8;
        margin_left = 0;
        margin_top = 0;
      };
    });
in {
  flake.mkWhichKeyExe = pkgs: menu: lib.getExe (mkWhichKey pkgs menu);

  flake.wrapperModules.which-key = inputs.wrapper-modules.lib.wrapModule (
    { config, lib, pkgs, ... }:
    let yamlFormat = pkgs.formats.yaml {}; in
    {
      options.settings = lib.mkOption {
        type = yamlFormat.type;
      };

      config = {
        package = pkgs.wlr-which-key;
        argv0 = toString (yamlFormat.generate "config.yaml" config.settings);
      };
    }
  );
}
