{ config, ... }:
let colors = builtins.mapAttrs (name: value: "#${value}") config.stylix.base16Scheme;
in {
  programs.oh-my-posh = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  programs.oh-my-posh.settings = {
    blocks = [
      {
        alignment = "left";
        type = "prompt";
        newline = true;
        segments = [
          {
            foreground = colors.base0E;
            properties.style = "full";
            style = "plain";
            type = "path";
          }
          {
            foreground = colors.base0D;
            properties.branch_icon = "";
            style = "plain";
            type = "git";
            foreground_templates = [
              "{{ if or (.Working.Changed) (.Staging.Changed) }}${colors.base08}{{ end }}"
              "{{ if and (gt .Ahead 0) (gt .Behind 0) }}#FF0000{{ end }}"
              "{{ if gt .Ahead 0 }}${colors.base0A}{ end }}"
              "{{ if gt .Behind 0 }}${colors.base0F}{{ end }}"
            ];
            template = "{{ .HEAD }}";
            properties = {
              fetch_status = true;
              fetch_upstream_icon = true;
            };
          }
        ];
      }
      {
        alignment = "right";
        type = "prompt";
        overflow = "hide";
        segments = [
          {
            type = "dotnet";
            style = "plain";
            foreground = colors.base0A;
            template = " {{ .Full }}";
          }
          {
            type = "haskell";
            style = "plain";
            foreground = "#5f5287";
            template = " {{ .Full }}";
          }
          {
            type = "lua";
            style = "plain";
            foreground = colors.base0A;
            template = " {{ .Full }}";
          }
          {
            type = "rust";
            style = "plain";
            foreground = colors.base0A;
            template = " {{ .Full }}";
          }
        ];
      }
      {
        alignment = "left";
        type = "prompt";
        newline = true;
        segments = [
          {
            foreground = colors.base0E;
            style = "plain";
            template = " 󰘧";
            type = "text";
          }
        ];
      }
      {
        type = "rprompt";
        alignment = "right";
        overflow = "hide";
        segments = [
          {
            foreground = colors.base03;
            properties = {
              style = "austin";
              threshold = 250;
            };
            style = "plain";
            template = "{{ .FormattedMs }}";
            type = "executiontime";
          }
        ];
      }
    ];
    transient_prompt = {
      foreground = colors.base0E;
      template = " 󰘧 ";
    };
    final_space = true;
    version = 2;
  };
}
