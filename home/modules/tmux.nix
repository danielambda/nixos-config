{ pkgs, lib, config, ... }:
let colors = builtins.mapAttrs (name: value: "#${value}") config.stylix.base16Scheme;
in {
  programs.tmux = {
    enable = true;
    shell = lib.getExe pkgs.zsh;
    plugins = with pkgs.tmuxPlugins; [
      sensible
      vim-tmux-navigator
    ];

    extraConfig = /*tmux*/''
      unbind C-b
      set -g prefix C-a
      bind C-a send-prefix

      set -g mouse on
      set -g status-position top

      set -g mode-keys vi
      setw -g mode-keys vi
      set-option -g status-keys vi

      set -g base-index 1
      set -g pane-base-index 1
      set-window-option -g pane-base-index 1
      set-option -g renumber-windows on

      bind '"' split-window -v -c "#{pane_current_path}"
      bind '%' split-window -h -c "#{pane_current_path}"

      set-option -g status-style bg=black
      set-option -g automatic-rename on

      set-option -g status-left '#{session_name}#(echo "  ")'
      set-option -g status-left-length 50
      set-option -g status-right ' '
      set-option -g window-status-current-format '#[bold,fg=${colors.base08}]#{window_index}#(echo :)#{window_name}'
      set-option -g window-status-format '#[fg=${colors.base03}]#{window_index}#(echo :)#{window_name}'
    '';
  };

  home.packages = [(pkgs.writeShellApplication {
    name = "t";
    text = ''
      cd /home/daniel/projects/
      project=$(find . -maxdepth 2 -mindepth 2 \( -type d -o -type l \) | ${lib.getExe pkgs.fzf})
      cd "$project"

      session_name=$(basename "$project")

      if [[ -z "$project" ]]; then
        echo "No project selected."
        exit 1
      fi

      if ${lib.getExe pkgs.tmux} has-session -t "$session_name" 2>/dev/null; then
        ${lib.getExe pkgs.tmux} attach -t "$session_name"
      else
        ${lib.getExe pkgs.tmux} new-session -d -s "$session_name"
        ${lib.getExe pkgs.tmux} attach -t "$session_name"
      fi
    '';
  })];
}
