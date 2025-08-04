{ config, pkgs, ... }:

{
  home.username = "henrikp";
  home.homeDirectory = "/home/henrikp";
  home.stateVersion = "25.05";
  nixpkgs.config.allowUnfree = true; 
  home.packages = with pkgs; [
    # ========== Personal Utilities ==========
    wget
    rsync
    unzip
    jq
    fastfetch
    fzf
    figlet
    inotify-tools
    flatpak
    qalculate-qt
    thunderbird

    # ========== Terminals/CLI ==========
    neovim
    htop
    zsh
    zsh-completions
    eza
    fwupd
    yazi
    cava

    # ========== File Management ==========
    kdePackages.dolphin

    # ========== Python & Dev ==========
    git
    rustc
    cargo

    # ========== Media & Personal Apps ==========
    vlc
    imagemagick
    tor-browser
    #mullvad-browser
    audacity
    calibre
    streamcontroller
    kdePackages.kdenlive
    #spotify

    # ========== Personal Applications ==========
    discord
    obsidian
    nextcloud-client
    libreoffice
    kdePackages.yakuake
    transmission_4-gtk
    distrobox

    # ========== VPN & Network (User-specific) ==========
    mullvad-vpn

    # ========== Personal System Utils ==========
    fuse2
    xdg-user-dirs
    acpid
    kdePackages.kleopatra
  ];

  systemd.user.services.autogitpush = {
    Unit = {
      Description = "Periodically auto git commit/push your repo";
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash -c 'cd ${config.home.homeDirectory}/dotfiles && ${pkgs.git}/bin/git add . && ${pkgs.git}/bin/git commit -m \"Auto-commit: $(date)\" && ${pkgs.git}/bin/git push'";
    };
  };

  systemd.user.timers.autogitpush = {
    Unit = {
      Description = "Timer for autogitpush";
    };
    Timer = {
      OnUnitActiveSec = "5min"; # adjust as you want
      Persistent = true;
    };
    Install = {
      WantedBy = [ "timers.target" ];
    };
  };

  fonts.fontconfig = {
     enable=true;
     defaultFonts = {
        monospace = [ "Noto Sans Mono" "FontAwesome" ];
        sansSerif = [ "Noto Sans" "FontAwesome" ];
        emoji = ["Noto Color Emoji"];
     };
  };

  programs.home-manager.enable = true;
  #programs.kitty.enable = true;
  programs.firefox.enable = true;
  programs.wofi.enable = true;
  programs.waybar.enable = true;
  programs.swaylock.enable = true;

  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      gst = "git status";
      gcm = "git commit";
      gad = "git add";
      nixupch = "sudo nix-channel --update";
      nixconfig = "nano ~/dotfiles/workpc/configuration.nix";
      nixman = "nano ~/dotfiles/workpc/home.nix";
      nixapps = "nano ~/dotfiles/workpc/modules/apps.nix";
      nixservices = "nano ~/dotfiles/workpc/modules/services.nix";
      nixfilesystem = "nano ~/dotfiles/workpc/modules/filesystem.nix";      
      cavaconfig = "nano ~/.config/cava/config";
      hyprconfig = "nano ~/.config/hypr/hyprland.conf";
      hyprbinds = "nano ~/.config/hypr/conf/keybindings/default_modified.conf";
      rebuild = "sudo nixos-rebuild switch --flake ~/dotfiles/workpc";
      cleanup = "sudo nix-collect-garbage";
      xclip = "xclip -selection clipboard";
      printnix = "cat ~/dotfiles/workpc/configuration.nix | xclip";
      df = "df -h";
      c = "clear";
    };

    initExtra = ''
      hyprscripts() {
        if [ $# -eq 0 ]; then
          echo "==== hypr/scripts ===="
          echo "Usage: hyprscripts <filename>"
          ls /home/henrikp/.config/hypr/scripts/
          echo "==== ml4w/settings ===="
          ls /home/henrikp/.config/ml4w/settings/
          echo "==== ml4w/scripts ==== "
          ls /home/henrikp/.config/ml4w/scripts/

          return 1
        fi
        nano /home/henrikp/.config/hypr/scripts/"$1"
        nano /home/henrikp/.config/ml4w/settings/"$1"
        nano /home/henrikp/.config/ml4w/scripts/"$1"
      }
    '';
  };

  programs.git = {
    enable = true;
    userName = "FuckingToasters";
    userEmail = "adiscord128+github@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };


  programs.hyprpanel = {
    # Configure and theme almost all options from the GUI.
    # See 'https://hyprpanel.com/configuration/settings.html'.
    # Default: <same as gui>
    settings = {

      # Configure bar layouts for monitors.
      # See 'https://hyprpanel.com/configuration/panel.html'.
      # Default: null
      layout = {
        bar.layouts = {
          "0" = {
            left = [ "dashboard" "workspaces" ];
            middle = [ "media" ];
            right = [ "volume" "systray" "notifications" ];
          };
        };
      };

      bar.launcher.autoDetectIcon = true;
      bar.workspaces.show_icons = true;

      menus.clock = {
        time = {
          military = true;
          hideSeconds = true;
        };
        weather.unit = "metric";
      };

      menus.dashboard.directories.enabled = false;
      menus.dashboard.stats.enable_gpu = true;

      theme.bar.transparent = true;

      theme.font = {
        name = "CaskaydiaCove NF";
        size = "16px";
      };
    };
  };


  # Compact Hyprland config using extraConfig
  #wayland.windowManager.hyprland = {
    #enable = true;
    #xwayland.enable = true;
    #systemd.enable = true;

    #extraConfig = ''
     # monitor=,preferred,auto,auto

      #$terminal = kitty
      #$fileManager = dolphin
      #$menu = wofi --show drun
      #$browser = firefox

      #exec-once = nm-applet &
      #exec-once = waybar & hyprpaper

      #env = XCURSOR_SIZE,24
      #env = HYPRCURSOR_SIZE,24

      #general {
          #gaps_in = 5
          #gaps_out = 20
          #border_size = 2
          #col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
          #col.inactive_border = rgba(595959aa)
          #resize_on_border = false
          #allow_tearing = false
          #layout = dwindle
      #}

      #decoration {
          #rounding = 10
          #rounding_power = 2
          #active_opacity = 1.0
          #inactive_opacity = 1.0
          #shadow {
              #enabled = true
              #range = 4
              #render_power = 3
              #color = rgba(1a1a1aee)
          #}
          #blur {
              #enabled = true
              #size = 3
              #passes = 1
              #vibrancy = 0.1696
          #}
      #}

      #animations {
          #enabled = yes, please :)
          #bezier = easeOutQuint,0.23,1,0.32,1
          #bezier = easeInOutCubic,0.65,0.05,0.36,1
          #bezier = linear,0,0,1,1
          #bezier = almostLinear,0.5,0.5,0.75,1.0
          #bezier = quick,0.15,0,0.1,1

          #animation = global, 1, 10, default
          #animation = border, 1, 5.39, easeOutQuint
          #animation = windows, 1, 4.79, easeOutQuint
          #animation = windowsIn, 1, 4.1, easeOutQuint, popin 87%
          #animation = windowsOut, 1, 1.49, linear, popin 87%
          #animation = fadeIn, 1, 1.73, almostLinear
          #animation = fadeOut, 1, 1.46, almostLinear
          #animation = fade, 1, 3.03, quick
          #animation = layers, 1, 3.81, easeOutQuint
          #animation = layersIn, 1, 4, easeOutQuint, fade
          #animation = layersOut, 1, 1.5, linear, fade
          #animation = fadeLayersIn, 1, 1.79, almostLinear
          #animation = fadeLayersOut, 1, 1.39, almostLinear
          #animation = workspaces, 1, 1.94, almostLinear, fade
          #animation = workspacesIn, 1, 1.21, almostLinear, fade
          #animation = workspacesOut, 1, 1.94, almostLinear, fade
      #}

      #dwindle {
          #pseudotile = true
          #preserve_split = true
      #}

      #master {
          #new_status = master
      #}

      #misc {
          #force_default_wallpaper = -1
          #disable_hyprland_logo = false
      #}

      #input {
          #kb_layout = de
          #kb_variant =
          #kb_model =
          #kb_options =
          #kb_rules =

          #follow_mouse = 1
          #sensitivity = 0

          #touchpad {
              #natural_scroll = false
          #}
      #}

      #gestures {
          #workspace_swipe = false
      #}

      #device {
          #name = epic-mouse-v1
          #sensitivity = -0.5
      #}

      #$mainMod = SUPER

      #bind = $mainMod, T, exec, $terminal
      #bind = $mainMod, Q, killactive,
      #bind = $mainMod, M, exit,
      #bind = $mainMod, E, exec, $fileManager
      #bind = $mainMod, V, togglefloating,
      #bind = $mainMod, R, exec, $menu
      #bind = $mainMod, P, pseudo,
      #bind = $mainMod, J, togglesplit,
      #bind = $mainMod, L, exec, hyprlock
      #bind = $mainMod, F, exec, $browser

      #bind = $mainMod, left, movefocus, l
      #bind = $mainMod, right, movefocus, r
      #bind = $mainMod, up, movefocus, u
      #bind = $mainMod, down, movefocus, d

      #bind = $mainMod, 1, workspace, 1
      #bind = $mainMod, 2, workspace, 2
      #bind = $mainMod, 3, workspace, 3
      #bind = $mainMod, 4, workspace, 4
      #bind = $mainMod, 5, workspace, 5
      #bind = $mainMod, 6, workspace, 6
      #bind = $mainMod, 7, workspace, 7
      #bind = $mainMod, 8, workspace, 8
      #bind = $mainMod, 9, workspace, 9
      #bind = $mainMod, 0, workspace, 10

      #bind = $mainMod SHIFT, 1, movetoworkspace, 1
      #bind = $mainMod SHIFT, 2, movetoworkspace, 2
      #bind = $mainMod SHIFT, 3, movetoworkspace, 3
      #bind = $mainMod SHIFT, 4, movetoworkspace, 4
      #bind = $mainMod SHIFT, 5, movetoworkspace, 5
      #bind = $mainMod SHIFT, 6, movetoworkspace, 6
      #bind = $mainMod SHIFT, 7, movetoworkspace, 7
      #bind = $mainMod SHIFT, 8, movetoworkspace, 8
      #bind = $mainMod SHIFT, 9, movetoworkspace, 9
      #bind = $mainMod SHIFT, 0, movetoworkspace, 10

      #bind = $mainMod, S, togglespecialworkspace, magic
      #bind = $mainMod SHIFT, S, movetoworkspace, special:magic
      #bind = $mainMod, mouse_down, workspace, e+1
      #bind = $mainMod, mouse_up, workspace, e-1
      #bindm = $mainMod, mouse:272, movewindow
      #bindm = $mainMod, mouse:273, resizewindow

      #bindel = ,XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+
      #bindel = ,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
      #bindel = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
      #bindel = ,XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
      #bindel = ,XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+
      #bindel = ,XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-
      #bindl = , XF86AudioNext, exec, playerctl next
      #bindl = , XF86AudioPause, exec, playerctl play-pause
      #bindl = , XF86AudioPlay, exec, playerctl play-pause
      #bindl = , XF86AudioPrev, exec, playerctl previous

      #windowrule = suppressevent maximize, class:.*
      #windowrule = nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0
    #'';
  #};

}
