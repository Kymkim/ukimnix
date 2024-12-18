{ pkgs, lib, config, ... }:

    # ░  ░░░░  ░░  ░░░░  ░░       ░░░       ░░░  ░░░░░░░░░      ░░░   ░░░  ░░       ░░
    # ▒  ▒▒▒▒  ▒▒▒  ▒▒  ▒▒▒  ▒▒▒▒  ▒▒  ▒▒▒▒  ▒▒  ▒▒▒▒▒▒▒▒  ▒▒▒▒  ▒▒    ▒▒  ▒▒  ▒▒▒▒  ▒
    # ▓        ▓▓▓▓    ▓▓▓▓       ▓▓▓       ▓▓▓  ▓▓▓▓▓▓▓▓  ▓▓▓▓  ▓▓  ▓  ▓  ▓▓  ▓▓▓▓  ▓
    # █  ████  █████  █████  ████████  ███  ███  ████████        ██  ██    ██  ████  █
    # █  ████  █████  █████  ████████  ████  ██        ██  ████  ██  ███   ██       ██

    ##################################################################################
    # Window tiling manager. The main reason how I got into this deep Linux rabbit   #
    # hole (haha DECO*27 song reference)                                             #
    #                                                                                #
    # GitHub: https://github.com/hyprwm/Hyprland                                     #
    ##################################################################################

{

  options.hyprland = {
    enable = lib.mkEnableOption "Enables Hyprland";
    FW16config = lib.mkEnableOption "Use the Framework 16 laptop configuration";
    Fcitx5.enable = lib.mkEnableOption "Start Fcitx5 on boot";
  };

  config = lib.mkIf config.hyprland.enable { 
    

    home.packages = with pkgs; [
      hyprshot
      hyprcursor
      hyprpolkitagent
    ];
   
    wayland.windowManager.hyprland.enable = true;
    wayland.windowManager.hyprland.xwayland.enable = true;
    wayland.windowManager.hyprland.settings = {

      monitor = lib.mkIf config.hyprland.FW16config "eDP-1, 2560x1600@165, 0x0, 1";

      input = {
        kb_layout = "us, us";
        kb_variant = " , colemak";
        kb_options = "grp:alt_shift_toggle";
        touchpad = lib.mkIf config.hyprland.FW16config {
          natural_scroll = true;
          drag_lock = true;
        };
      };

      gestures = lib.mkIf config.hyprland.FW16config{
        workspace_swipe = true;
      };  

      cursor = {
        enable_hyprcursor = true; #TODO: add hypercursor
      };

      exec-once = [
        "ags"
        "lxqt-policykit-agent"
        "ags run"
        (lib.mkIf config.hyprland.Fcitx5.enable "fcitx5 -d -r")
        (lib.mkIf config.hyprland.Fcitx5.enable "fcitx5-remote-r")
      ];

      # __     __         _       _     _           
      # \ \   / /_ _ _ __(_) __ _| |__ | | ___  ___ 
      #  \ \ / / _` | '__| |/ _` | '_ \| |/ _ \/ __|
      #   \ V / (_| | |  | | (_| | |_) | |  __/\__ \
      #    \_/ \__,_|_|  |_|\__,_|_.__/|_|\___||___/

      ##############################################
      # Variables n stuff. Such as default mod key #
      # and default applications. mostly for       #
      # binds                                      #
      ##############################################
                                              
      "$mod"      = "SUPER";
      "$mikuwiki" = "firefox --new-window https://en.wikipedia.org/wiki/Hatsune_Miku";
      "$bluesky"  = "firefox --new-window https://bsky.app/?kawaii=true";                #I am terminally online
      "$email"    = "firefox --new-window https://outlook.office365.com/mail/";          #Will something better laterz
      "$home-manager-manual" = "firefox --new-window https://nix-community.github.io/home-manager/options.xhtml";
      "$nix-packages-search" = "firefox --new-window https://search.nixos.org/packages";

      #  _  __          _     _           _     
      # | |/ /___ _   _| |__ (_)_ __   __| |___ 
      # | ' // _ \ | | | '_ \| | '_ \ / _` / __|
      # | . \  __/ |_| | |_) | | | | | (_| \__ \
      # |_|\_\___|\__, |_.__/|_|_| |_|\__,_|___/
      #           |___/                         

      #Mappings can be found on bindings file

      bind = [
        "$mod, ESCAPE, killactive"
        "$mod, SPACE, exec, rofi -show drun"  #App launcher

        # Mod + Key
        "$mod, Q, exec, ags -t bar"
        #"$mod, W, exec, $mikuwiki"
        "$mod, E, exec, $email"
        #"$mod, R, exec, $mikuwiki"
        "$mod, T, exec, kitty"
        #"$mod, A, exec, $mikuwiki"
        "$mod, S, exec, steam"
        "$mod, D, exec, discord"
        "$mod, F, exec, firefox"
        #"$mod, G, exec, $mikuwiki"
        "$mod, Z, togglefloating"
        "$mod, X, fullscreen"
        #"$mod, C, exec, $mikuwiki"
        "$mod, V, exec, codium"
        "$mod, B, exec, $bluesky"

        # Mod + Shift + Key
        #"$mod SHIFT, Q, exec, hyprshot --mode output --clipboard-only"
        "$mod SHIFT, W, exec, hyprshot --mode window --clipboard-only"
        "$mod SHIFT, E, exec, hyprshot --mode output --clipboard-only"
        "$mod SHIFT, R, exec, hyprshot --mode region -z --clipboard-only"
        #"$mod SHIFT, T, exec, kitty"     
        #"$mod SHIFT, A, exec, $mikuwiki"
        #"$mod SHIFT, S, exec, steam"
        #"$mod SHIFT, D, exec, discord"
        #"$mod SHIFT, F, exec, firefox"
        #"$mod SHIFT, G, exec, $mikuwiki"
        #"$mod SHIFT, Z, togglefloating"
        #"$mod SHIFT, X, fullscreen"
        #"$mod SHIFT, C, exec, $mikuwiki"
        #"$mod SHIFT, V, exec, codium"
        #"$mod SHIFT, B, exec, $bluesky"

        #Mod + Shift + Ctrl + Key
        #"$mod SHIFT CTRL, Q, exec, hyprshot --mode output"
        "$mod SHIFT CTRL, W, exec, hyprshot --mode window"
        "$mod SHIFT CTRL, E, exec, hyprshot --mode output"
        "$mod SHIFT CTRL, R, exec, hyprshot --mode region -z"
        #"$mod SHIFT CTRL, T, exec, kitty"     
        #"$mod SHIFT CTRL, A, exec, $mikuwiki"
        #"$mod SHIFT CTRL, S, exec, steam"
        #"$mod SHIFT CTRL, D, exec, discord"
        #"$mod SHIFT CTRL, F, exec, firefox"
        #"$mod SHIFT CTRL, G, exec, $mikuwiki"
        #"$mod SHIFT CTRL, Z, togglefloating"
        #"$mod SHIFT CTRL, X, fullscreen"
        #"$mod SHIFT CTRL, C, exec, $mikuwiki"
        #"$mod SHIFT CTRL, V, exec, codium"
        #"$mod SHIFT CTRL, B, exec, $bluesky"

        ##################################################################
        # Right Hand                                                     #
        # Y             U=unityhub    I     O         P                  #
        # H             J             K     L         '                  #
        # N=nixpackages M=homemanager ,     .         /                  #
        ##################################################################

        #Mod + Key
        #"$mod, Y, exec, $mikuwiki"
        "$mod, U, exec, unityhub"
        #"$mod, I, exec, $mikuwiki"
        "$mod, O, exec, obsidian"
        #"$mod, P, exec, $mikuwiki"
        #"$mod, H, exec, $mikuwiki"
        #"$mod, J, exec, $mikuwiki"
        #"$mod, K, exec, $mikuwiki"
        #"$mod, L, exec, $mikuwiki"
        #"$mod, code:47, exec, $mikuwiki"      # ; Key
        "$mod, N, exec, $nix-packages-search"
        "$mod, M, exec, $home-manager-manual"
        #"$mod, code:59, exec, $mikuwiki"      # , Key
        #"$mod, code:60, exec, $mikuwiki"      # . Key
        #"$mod, code:61, exec, $mikuwiki"      # / Key
        
        # Mod + Shift + Key
        #"$mod SHIFT, Y, exec, hyprshot --mode output --clipboard-only"
        #"$mod SHIFT, U, exec, hyprshot --mode window --clipboard-only"
        #"$mod SHIFT, I, exec, hyprshot --mode active --clipboard-only"
        #"$mod SHIFT, O, exec, hyprshot --mode region -z --clipboard-only"
        #"$mod SHIFT, P, exec, kitty"     
        #"$mod SHIFT, H, exec, $mikuwiki"
        #"$mod SHIFT, J, exec, steam"
        #"$mod SHIFT, K, exec, discord"
        #"$mod SHIFT, L, exec, firefox"
        #"$mod SHIFT, code:47, exec, $mikuwiki"
        #"$mod SHIFT, N, togglefloating"
        #"$mod SHIFT, M, fullscreen"
        #"$mod SHIFT, code:59, exec, $mikuwiki"
        #"$mod SHIFT, code:60, exec, codium"
        #"$mod SHIFT, code:61, exec, $bluesky"

        #Mod + Shift + Ctrl + Key
        #"$mod SHIFT CTRL, Y, exec, hyprshot --mode output --clipboard-only"
        #"$mod SHIFT CTRL, U, exec, hyprshot --mode window --clipboard-only"
        #"$mod SHIFT CTRL, I, exec, hyprshot --mode active --clipboard-only"
        #"$mod SHIFT CTRL, O, exec, hyprshot --mode region -z --clipboard-only"
        #"$mod SHIFT CTRL, P, exec, kitty"     
        #"$mod SHIFT CTRL, H, exec, $mikuwiki"
        #"$mod SHIFT CTRL, J, exec, steam"
        #"$mod SHIFT CTRL, K, exec, discord"
        #"$mod SHIFT CTRL, L, exec, firefox"
        #"$mod SHIFT CTRL, code:47, exec, $mikuwiki"
        #"$mod SHIFT CTRL, N, togglefloating"
        #"$mod SHIFT CTRL, M, fullscreen"
        #"$mod SHIFT CTRL, code:59, exec, $mikuwiki"
        #"$mod SHIFT CTRL, code:60, exec, codium"
        #"$mod SHIFT CTRL, code:61, exec, $bluesky"
        

        ##################################################################
        # Workspace Keybinds                                             #
        # Yes, I know I can use a loop for this, but I want this to be   #
        # readable and easy to re-configure                              #
        ##################################################################

        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"
        ", code:191, workspace, r-1"

      ];

      #Mousebinds
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
        #"$mod, mouse:276, workspace, next"
        #"$mod, mouse:275, workspace, previous"
      ];

      #  ____  _         _      
      # / ___|| |_ _   _| | ___ 
      # \___ \| __| | | | |/ _ \
      #  ___) | |_| |_| | |  __/
      # |____/ \__|\__, |_|\___|
      #            |___/        

      ######################################################
      # Design stuff, such as border styles and animations #
      ######################################################

      general = {
        border_size = 4;
        gaps_in = 5;
        gaps_out = 20;
        "col.active_border" = "rgba(2cf5f5ff) rgba(e12885ee) 45deg";
        "col.inactive_border" = "rgba(86cecb77)";
      };

      decoration = {
        rounding = 3;
        "col.shadow" = "rgba(e1288555)";
        "col.shadow_inactive" = "rgba(FFFFFF00)";
        drop_shadow = true;
        shadow_range = 10;
        shadow_render_power = 3;
      };

      # ░  ░░░░  ░░        ░░   ░░░  ░░░░░░░░       ░░░  ░░░░  ░░  ░░░░░░░░        ░░░      ░░
      # ▒  ▒  ▒  ▒▒▒▒▒  ▒▒▒▒▒    ▒▒  ▒▒▒▒▒▒▒▒  ▒▒▒▒  ▒▒  ▒▒▒▒  ▒▒  ▒▒▒▒▒▒▒▒  ▒▒▒▒▒▒▒▒  ▒▒▒▒▒▒▒
      # ▓        ▓▓▓▓▓  ▓▓▓▓▓  ▓  ▓  ▓▓▓▓▓▓▓▓       ▓▓▓  ▓▓▓▓  ▓▓  ▓▓▓▓▓▓▓▓      ▓▓▓▓▓      ▓▓
      # █   ██   █████  █████  ██    ████████  ███  ███  ████  ██  ████████  ██████████████  █
      # █  ████  ██        ██  ███   ████████  ████  ███      ███        ██        ███      ██

      ########################################################################################
      # Window rules, such as how would certain application would launch                     #
      #                                                                                      #
      # Guide: https://wiki.hyprland.org/Configuring/Window-Rules/                           #
      ########################################################################################

      windowrule = [
        "float, ^(kitty)$"
        (lib.mkIf config.hyprland.Fcitx5.enable "pseudo, fcitx")
      ];
                                                                                      
    };
  };
}