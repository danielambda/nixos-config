{ self, inputs, ... }: {
  perSystem = { pkgs, ... }: {
    packages.kitty =
      (inputs.wrappers.wrapperModules.kitty.apply {
        inherit pkgs;

        settings = {
          enable_audio_bell = "no";
          dynamic_background_opacity = "no";
          allow_remote_control = "yes";

          disable_ligatures = "cursor";

          font_family = "JetBrainsMono Nerd Font";

          shell_integration = "enabled";

          background = self.hashColors.base00;
          foreground = self.hashColors.base06;

          cursor = self.hashColors.base07;

          selection_foreground = self.hashColors.base02;
          selection_background = self.hashColors.base01;

          active_tab_foreground   = self.hashColors.base0B;
          active_tab_background   = self.hashColors.base03;
          inactive_tab_background = self.hashColors.base01;

          color0  = self.hashColors.base00;
          color8  = self.hashColors.base02;
          color1  = self.hashColors.base08;
          color9  = self.hashColors.base08;
          color2  = self.hashColors.base0B;
          color10 = self.hashColors.base0B;
          color3  = self.hashColors.base0A;
          color11 = self.hashColors.base0A;
          color4  = self.hashColors.base0D;
          color12 = self.hashColors.base0D;
          color5  = self.hashColors.base0E;
          color13 = self.hashColors.base0E;
          color6  = self.hashColors.base0C;
          color14 = self.hashColors.base0C;
          color7  = self.hashColors.base03;
          color15 = self.hashColors.base03;
        };
      }).wrapper;
  };
}
