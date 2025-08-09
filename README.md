### NixOS Configuration Setup

This Repo contains my NixOS Configuration Files.
They are based on the Config Files rom Matt but modified a bunch by myself.

## What i've added and changed:
- Added support for the Lenovo T480 Fingerprint Sensor for GDM, Root User and SSH Login.
- Use of Home-Manager alongside Flakes for User-Specific Configurations
- Adding of zsh shell Configuration with a few useful Plugins
- More Aliases for Bash & zsh
- Move firewall section in the flake modules/filesystem.nix to modules/firewall.nix and additon of a Port which allows the use of Localsend.
- Replacement of the default Network, Audio and Bluetooth Interface to more Modern ones (bzmenu, iwmenu etc.)
	- You yourself need to change the program which the buttins in the Waybar open to the new tools with -l fuzzel flag.
	- Replacement of Networkmanager with Connmanager + iwf backend -> required by bzmenu.
- Addition of Parameter to extract Firmwarefiles on Build as some Intel Chips (Wifi & Bluetooth) don't support compressed firmware files.
- Moving User-Specific tools in home.nix and keeping Systemwide Tools in the modules subdir.


## Why is this Rep called nixhyprdots?
- As of right now, it only contains the NixOS Configuration files and not hyprland dotfiles, however i plan on adding my dotfiles as well.
- I also plan on loading the dotfiles into the NixOS Configuration files so that a rebuild on a new System also copies over the hyprland theming.


## Credits
Credits to Matt (YT: TheLinuxCast) for Publishing his Configurations which allowed me to make my Modifications and Give my updated version back to the NixOS Community
