{
  config,
  pkgs,
  ...
}: {
  programs.git = {
    enable = true;
    userName = "Austin Massey";
    userEmail = "austinkmassey@gmail.com";
  };
}
