{ inputs, self, ... }:
let colors = self.hashColors; in
{
  perSystem = { pkgs, lib, self', ... }: {
    packages.tmux = inputs.wrapper-modules.wrappers.tmux.wrap {
      inherit pkgs;
      shell = lib.getExe self'.packages.zsh;
      plugins = with pkgs.tmuxPlugins; [
        sensible
        vim-tmux-navigator
      ];

      configAfter = /*tmux*/''
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
  };
}
