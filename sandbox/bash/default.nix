{
  config,
  pkgs,
  ...
}: {
  programs.bash = {
    enable = true;
  };

  home.file = [
     ".bash_profile".source = ./bash_profile;
     ".bashrc".source = ./bashrc;
  ];
}
