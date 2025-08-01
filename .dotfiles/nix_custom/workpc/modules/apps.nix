{ config, pkgs, ... }:

{
  users.users.henrikp = {
    isNormalUser = true;
    description = "Henrik Petersen";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      wofi
      waybar
      brightnessctl
      playerctl
      pipewire # Provides wpctl Binary
      grim
      rofi-wayland
      slurp
      swayidle
      swaynotificationcenter
      kdePackages.kate
      rustup
      libnotify
      xwayland-satellite 
      beets
      streamcontroller
	  tmux
      vorta
      neovim
	  calibre
      libgcc
	  fzf
	  lua
	  bat
	  discord
	  fd
      killall
      ranger
      fastfetch
      inotify-tools
      curl
      wget
      eza
      cliphist
      zoxide
      borgbackup
      trash-cli
      obsidian
      audacity
      unzip
      htop
      btop
      gcc
      nextcloud-client
      zig
      kitty
      swww
	  fish
	  mullvad
	  oh-my-posh
	  transmission_4-gtk
	  mullvad-vpn
	  python312Packages.pip
	  wdisplays
	  jq
	  pipx
	  pywalfox-native
      pulsemixer
	  pywal16
	  stow
      mpv
      util-linux
      kdePackages.kdenlive
      ffmpeg-full
      hugo
	  wl-clipboard
	  wireguard-tools
      caligula
	  distrobox
	  libreoffice
	  kdePackages.yakuake
      thunderbird
      kdePackages.kleopatra
      tor-browser
      ncdu
      networkmanagerapplet
      networkmanager_dmenu
      pavucontrol
    ];
  };

  programs.git = {
    enable = true;
	config = {
      user.name = "FuckingToasters";
      user.email = "adiscord128+github@gmail.com";
	  init.defaultBranch = "main";
	};
  };

  programs.virt-manager.enable = true;

  programs.niri.enable = true;

  programs.firefox.enable = true;
  programs.nh.enable = true;

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
  #  wget
    nfs-utils
  ];

  #programs.steam = {
   #enable = true;
   #extraCompatPackages = [ pkgs.proton-ge-bin ];   
  #};

  services.flatpak.packages = [
    "com.obsproject.Studio"
    "com.ticktick.TickTick"
	"com.vivaldi.Vivaldi"
	"org.gimp.GIMP"
	"us.zoom.Zoom"
	"page.codeberg.libre_menu_editor.LibreMenuEditor"
	#"com.heroicgameslauncher.hgl"
	"io.github.dvlv.boxbuddyrs"
	"com.vscodium.codium"
  ];
}
