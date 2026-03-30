{
  perSystem = { pkgs, lib, self', ... }:
  let tmuxExe = lib.getExe self'.packages.tmux; in
  {
    packages.t = pkgs.writeShellApplication {
      name = "t";
      text = ''
        cd ~/projects/
        project=$(find . -maxdepth 2 -mindepth 2 \( -type d -o -type l \) | ${lib.getExe pkgs.fzf})
        cd "$project"

        session_name=$(basename "$project")

        if [[ -z "$project" ]]; then
          echo "No project selected."
          exit 1
        fi

        if ${tmuxExe} has-session -t "$session_name" 2>/dev/null; then
          ${tmuxExe} attach -t "$session_name"
        else
          ${tmuxExe} new-session -d -s "$session_name"
          ${tmuxExe} attach -t "$session_name"
        fi
      '';
    };
  };
}
