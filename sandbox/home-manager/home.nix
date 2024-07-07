{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {

  home = {
    username = "sandboxer";
    homeDirectory = "/home/sandboxer";
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  nixpkgs = {
    overlays = [];
    # Configure your nixpkgs instance
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];

  programs.home-manager.enable = true;
  programs.git.enable = true;
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    ../neovim
    ../nb
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
