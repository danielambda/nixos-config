{ inputs, pkgs, lib, ... }: {
  imports = [inputs.xremap.homeManagerModules.default];

  services.xremap = {
    enable = true;
    withWlroots = true;
  };

  services.xremap.config = {
    modmap = [
      { remap = { CapsLock = "esc"; }; }
    ];

    keymap = [
      {
        name = "App launcher";
        remap."super-r".remap = {
          r.launch = [(lib.getExe pkgs.rofi-wayland) "-show" "drun"];
          f.launch = [(lib.getExe pkgs.firefox)];
        };
      }
    ];
  };
}
