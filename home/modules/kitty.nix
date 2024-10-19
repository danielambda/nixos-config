{
  programs.kitty = {
    enable = true;

    settings = {
      enable_audio_bell = false;
      dynamic_background_opacity = true;
      allow_remote_control = true;
      map = "ctrl+shift+j launch --type overlay kitten @ set-background-opacity --toggle 1";
    };

    shellIntegration.enableZshIntegration = true;
  };
}
