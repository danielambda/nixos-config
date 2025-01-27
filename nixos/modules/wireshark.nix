{ pkgs, ... }: {
  programs.wireshark.enable = true;
  programs.wireshark.package = pkgs.wireshark;

  users.users.daniel.extraGroups = ["wireshark"];
}
