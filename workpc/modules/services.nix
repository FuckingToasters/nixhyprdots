{ config, pkgs, ... }:

{
  services.printing.enable = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  services.udisks2.enable = true;
  services.gvfs.enable = true;
  services.envfs.enable=true;
  services.resolved.enable = true;

  services.openssh.enable = true;

  services.flatpak.enable = true; 
  services.xserver.enable = true;

  services.mullvad-vpn.enable = true;

  services.autogitpush.timer.enable = true; # custom

  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  virtualisation.podman = {
  enable = true;
  dockerCompat = true;
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 15d";
  };

  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = false;

  security.polkit.enable = true; # polkit
  services.gnome.gnome-keyring.enable = true; # secret service

}

