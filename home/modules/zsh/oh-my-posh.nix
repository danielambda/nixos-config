{ inputs, ... }: {
  programs.oh-my-posh = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    useTheme = "bubbles";
  };

  programs.oh-my-posh.settings = {

  };
}
