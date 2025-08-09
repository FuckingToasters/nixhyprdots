{ config, pkgs, ... }:

{
  home.file."~/.config/networkmanager-dmenu/config.ini".source = ./managed/networkmanager-dmenu-config.ini;

  home.stateVersion = "25.05";

}
