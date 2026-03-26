{ inputs, self, lib, ... }: let
  mkWhichKey = pkgs: menu:
    (self.wrapperModules.which-key.apply {
      inherit pkgs;
      settings = {
        inherit menu;

        font = "JetBrainsMono Nerd Font 12";
        background = "#2b002a";
        color = "#ab00ba";
        border = "#ffffff";
        separator = " ➜ ";
        border_width = 4;
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
    }).wrapper;
in {
  flake.mkWhichKeyExe = pkgs: menu: lib.getExe (mkWhichKey pkgs menu);

  flake.wrapperModules.which-key = inputs.wrappers.lib.wrapModule (
    { config, ... }:
    let
      yamlFormat = config.pkgs.formats.yaml {};
      configFile = yamlFormat.generate "config.yaml" config.settings;
    in {
      options.settings = lib.mkOption {
        type = yamlFormat.type;
      };

      config = {
        package = config.pkgs.wlr-which-key;
        args = [(toString configFile)];
      };
    }
  );
}
