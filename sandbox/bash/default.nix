{
  config,
  pkgs,
  ...
}: {
  programs.bash = {
    enable = true;
    initExtra = ''
	set -o vi
    '';
  };
}
