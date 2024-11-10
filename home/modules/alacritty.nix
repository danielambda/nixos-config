{
  programs.alacritty.enable = true;
  programs.alacritty.settings = {
    env.TERM = "xterm-256color";
    window.padding = {
      x = 4;
      y = 4;
    };
  };
}
