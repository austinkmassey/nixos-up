{
  config,
  pkgs,
  ...
}: {
  home.sessionVariables.EDITOR = "nvim";

  programs.neovim = {
    enable = true;

    extraConfig = ''
        "Tabs
        set tabstop=4 "4 char-wide tab
        set expandtab "Use spaces
        set softtabstop=0 "Use same length as 'tabstop'
        set shiftwidth=0 "Use same length as 'tabstop'

    '';
  };
}
