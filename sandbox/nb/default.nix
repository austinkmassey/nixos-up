{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [ nb ];

  home.file.".nbrc" = source "./nbrc";
}
