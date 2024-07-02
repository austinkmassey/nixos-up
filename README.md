# nixos-up

nixos-up is a dead-simple install wizard for NixOS. It's the fastest way to get from ISO to working installation.

From the NixOS installation USB/CD:

```
sudo nix-shell https://github.com/austinkmassey/nixos-up/archive/main.tar.gz
```

You can check out a video demonstrating the process here: https://youtu.be/f7DzbiRD99Q.

## Development

In this directory run `servefile --tar --compression gzip --port 12345 .`. Then, while that's running `nix-shell -p ngrok --run "ngrok http 12345"`.

Now in your VM/device, run

```
nix-collect-garbage && sudo nix-shell http://blah-blah-blah.ngrok.io/nixos-up.tar.gz
```

You may need `sudo umount --lazy /mnt` periodically as well.

## WIP - feature-install-from-flake

Nixos-up creates a configuration.nix file by using python string operations.
The generated configuration.nix file is used for nixos-install.

    - change the installer to use a flake template instead of a generated
      file

    - use python or overlays to configure the template files with
      information gathered by installer

While converting the installer to use the flake templates, they will include
hard-coded information that will allow the installation to complete.

After the installer runs using flake configuration, the hardcoded values
will be replaced with dynamic values.

    # Gather system information
    # Ask for desired configuration settings

    # Pull template
    # Merge settings
    # nixos-install...
    # boot.loader.grub.device = /dev/{selected_disk_name}
    # users.users.{username}.{...}
    # swapDevices = [ {{ device = "/swapfile"; size = {swap_mb}; }} ];
    # time.timeZone = {timezone}
    # passwords...
    # hostnmae...
