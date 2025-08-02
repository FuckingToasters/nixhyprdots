{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  home-manager.users.henrikp = {
    imports = [ ./home.nix ];
  };

  
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  hardware.enableAllFirmware = true;
  hardware.firmware.uncompressed = true;

  networking.hostName = "workpc"; # Define your hostname.
  #networking.networkmanager.enable = true;
  networking.wireless.iwd.enable = true;

  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";
  users.groups.libvirtd.members = ["henrikp"];


  services.xserver.xkb = {
    layout = "de";
  };

  nix.settings.experimental-features =[ "flakes" "nix-command" ];

  environment.variables.KITTY_CONFIG_DIRECTORY = "~/.config/kitty";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
