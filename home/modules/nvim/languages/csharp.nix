{ pkgs, ... }: {
  home.packages = with pkgs; [
    omnisharp-roslyn
    dotnet-sdk_8
  ];
}

