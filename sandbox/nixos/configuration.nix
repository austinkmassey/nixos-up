{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
  ];

  nixpkgs = {
    overlays = [];
    config = {
      allowUnfree = true;
    };
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  swapDevices = [ { device = "/swapfile"; size = 1024; } ];

  time.timeZone = "America/Chicago";
  networking.hostName = "sandbox";

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      experimental-features = "nix-command flakes";
      # Opinionated: disable global registry
      flake-registry = "";
      # Workaround for https://github.com/NixOS/nix/issues/9574
      nix-path = config.nix.nixPath;
    };
    # Opinionated: disable channels
    channel.enable = false;

    # Opinionated: make flake registry and nix path match flake inputs
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  users.users = {
    sandboxer = {
      isNormalUser = true;
      extraGroups = ["wheel"];
      initialPassword = "horsebattery";
      openssh.authorizedKeys.keys = [];
      # TODO: Be sure to add any other groups you need (such as networkmanager, audio, docker, etc)
    };
  };

  environment.systemPackages = with pkgs; [
    tmux
    tree
    htop
  ];

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = true;
    };
  };

  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings = {
        main = {
	  capslock = "overload(control, esc)";
	  esc = "capslock";
	};
      };
    };
  };
  users.groups.keyd = {};
  systemd.services.keyd.serviceConfig.CapabilityBoundingSet = ["CAPSETGID" ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05";
}
