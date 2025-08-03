{ config, pkgs, ... }:

{
  users.users.henrikp = {
    isNormalUser = true;
    description = "Henrik Petersen";
    extraGroups = [ "networkmanager" "wheel" "input" ];
    packages = with pkgs; [
      # ========== Development Tools ==========
      kdePackages.kate
      rustup
      gcc
      zig
      lua
      hugo
      libgcc

      # ========== Media & Creative ==========
      beets
      streamcontroller
      calibre
      audacity
      kdePackages.kdenlive
      ffmpeg-full
      mpv
      tor-browser

      # ========== System & Network ==========
      libnotify
      xwayland-satellite 
      tmux
      vorta
      killall
      ranger
      curl
      zoxide
      borgbackup
      trash-cli
      util-linux
      ncdu
      kdePackages.kleopatra
      caligula
      distrobox
      wireguard-tools

      # ========== Desktop Apps ==========
      discord
      obsidian
      nextcloud-client
      libreoffice
      kdePackages.yakuake

      # ========== Terminal & Shell ==========
      kitty
      fish
      oh-my-posh
      bat
      fd
      btop
      pulsemixer
      stow

      # ========== VPN & Network ==========
      mullvad
      mullvad-vpn
      transmission_4-gtk

      # ========== Python & Package Management ==========
      python312Packages.pip
      pipx
      pywalfox-native
      pywal16

      # ========== Display & Wayland Tools ==========
      wdisplays
      wl-clipboard
    ];
  };

  # ========== System-wide Programs ==========
  programs.virt-manager.enable = true;
  programs.niri.enable = true;
  programs.hyprland.enable = true;
  programs.firefox.enable = true;
  programs.nh.enable = true;

  nixpkgs.config.allowUnfree = true;

  # ========== System-wide Packages ==========
  environment.systemPackages = with pkgs; [
    # ========== Wayland/Hyprland & Desktop Environment ==========
    hyprland
    hyprpaper
    hyprpanel
    hyprlock
    hypridle
    hyprpicker
    hyprshade
    hyprcursor
    swaylock
    swaynotificationcenter
    swayidle
    waybar
    wlogout
    grim
    slurp
    cliphist
    niri
    waypaper
    wofi
    fuzzel
    rofi-wayland
    nwg-look
    nwg-dock-hyprland
    uwsm
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    pyprland
    swww

    # ========== System Utilities ==========
    gum
    power-profiles-daemon
    brightnessctl
    playerctl

    # ========== Networking ==========
    networkmanagerapplet
    iwd
    blueman
    gvfs

    # ========== Fonts, Icons, Themes ==========
    noto-fonts
    noto-fonts-emoji
    noto-fonts-color-emoji
    noto-fonts-cjk-sans
    noto-fonts-extra
    font-awesome
    dejavu_fonts
    fira-sans
    fira-code
    nerd-fonts.fira-code
    papirus-icon-theme
    kdePackages.breeze
    bibata-cursors

    # ========== GTK/Qt/Graphical Toolkit ==========
    gtk4
    qt6ct
    libadwaita

    # ========== Media, Audio & Video ==========
    pipewire
    pavucontrol
    bluez

    # ========== System Infrastructure ==========
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
