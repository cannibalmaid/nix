{ config, ... }:
let
  # inherit (default) colors;
  pointer = config.gtk.cursorTheme;
  homeDir = config.home.homeDirectory;
in
{

  wayland.windowManager.hyprland.extraConfig = ''
      $MOD = SUPER

      monitor=DP-1, 2560x1440@144, 1920x0,1
      monitor=DP-1,addreserved,0,0,65,0
      monitor=HDMI-A-1, 1920x1080@75,0x0,1
      monitor=DP-2, 1920x1080@60, 0x1080,1,transform,2
      monitor=,preferred,auto,auto

      workspace=1,monitor:DP-1,default:true
      workspace=2,monitor:DP-1
      workspace=3,monitor:DP-1
      workspace=4,monitor:DP-1
      workspace=5,monitor:DP-1
      workspace=6,monitor:HDMI-A-1,default:true
      workspace=7,monitor:DP-2,default:true
  
      exec-once=hyprctl setcursor "${pointer.name}" 24
      exec-once=dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
      exec-once=systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
      exec-once=dunst
      exec-once=eww daemon && eww open bar
      exec-once=~/.config/eww/scripts/logger.py
      exec-once=swayosd --max-volume 125
      exec-once=xrandr --output DP-1 --primary
      #exec-once=swww init && swww img ~/.config/eww/images/wallpaper/wallpaper --transition-step 230 --transition-fps 60 --transition-type grow --transition-angle 30 --transition-duration 1 --transition-pos "$cursorposx, $cursorposy_inverted" &
      # xwayland {
      #   force_zero_scaling=true
      # }

      input {
        force_no_accel = false
        kb_layout = us
        follow_mouse = 1
        accel_profile = flat
        touchpad {
          natural_scroll = true
          disable_while_typing = true
          clickfinger_behavior = true
          scroll_factor = 0.5
        }

        scroll_method = 2fg
      }

      gestures {
        workspace_swipe = true
        workspace_swipe_distance = 1200px
        workspace_swipe_fingers = 4
        workspace_swipe_cancel_ratio = 0.2
        workspace_swipe_min_speed_to_force = 5

        workspace_swipe_create_new = true
      }

      general {

        gaps_in = 6
        gaps_out = 6
        border_size = 3
        col.active_border = rgba(1e1e2eff) rgba(313244ff) 10deg
        col.inactive_border = rgba(1e1e2eff)
        layout = dwindle
        resize_on_border = true
      }

      misc {
        vrr = true
        vfr = false
        focus_on_activate = true
        animate_manual_resizes = false
        animate_mouse_windowdragging = false
        enable_swallow = true
        force_hypr_chan = true
        mouse_move_enables_dpms = true
        key_press_enables_dpms = true
        no_direct_scanout = true #Buggy
      }

      decoration {
        rounding = 8

        active_opacity = 1.0
        inactive_opacity = 1.0

        blur {
          enabled = true
          size = 6
          passes = 3
          #new_optimizations = true
          #xray = true
          #ignore_opacity = true
        }

        drop_shadow = false
        shadow_ignore_window = true
        shadow_offset = 1 2
        shadow_range = 10
        shadow_render_power = 5
        col.shadow = 0x66404040

        blurls = waybar
        blurls = lockscreen
      }
  
      animations {
        enabled = true

        bezier = wind, 0.05, 0.9, 0.1, 1.05
        bezier = winIn, 0.1, 1.1, 0.1, 1.1
        bezier = winOut, 0.3, -0.3, 0, 1
        bezier = liner, 1, 1, 1, 1

        animation = windows, 1, 6, wind, slide
        animation = windowsIn, 1, 6, winIn, slide
        animation = windowsOut, 1, 5, winOut, slide
        animation = windowsMove, 1, 5, wind, slide
        animation = border, 1, 1, liner
        animation = borderangle, 1, 30, liner, loop
        animation = fade, 1, 10, default
        animation = workspaces, 1, 5, wind
      }

      # Workspace
    #  bind = $MOD, 1, workspace, 1
    #  bind = $MOD, 2, workspace, 2
    #  bind = $MOD, 3, workspace, 3
    # bind = $MOD, 4, workspace, 4
    #  bind = $MOD, 5, workspace, 5

      # Apps: just normal apps
      bind = $MOD, Return, exec, wezterm
      bind = $MOD, E, exec, nautilus --new-window
      #bind = $MOD, X, exec, gnome-text-editor --new-window

      # Audio thingies
      bind = ,XF86AudioRaiseVolume, exec, swayosd --output-volume raise
      bind = ,XF86AudioLowerVolume, exec, swayosd --output-volume lower
      bind = ,XF86AudioMute, exec, swayosd --output-volume mute-toggle
      bind = $MOD, X, exec, ~/.config/eww/scripts/switcher

      bindr = Caps_Lock, Caps_Lock, exec, swayosd --caps-lock

      bind = ,XF86AudioPlay, exec, playerctl play-pause
      bind = ,XF86AudioNext, exec, playerctl next
      bind = ,XF86AudioPrev, exec, playerctl previous


      # Screenshooting
      bind = , Print, exec, ~/.config/eww/scripts/screenshot crop
      bind = Alt, Print, exec, ~/.config/eww/scripts/screenshot full

      # Actions
      bindr = $MOD, SUPER_L, exec, pkill wofi || wofi --show drun --allow-markup --no-actions --allow-images --insensitive --cache-file=/dev/null --parse-search --height=40% --prompt="Say something"
      bind = $MOD, Period, exec, pkill fuzzel || ~/.local/bin/fuzzel-emoji
      bind = $MOD, Q, killactive,
      #bind = SuperShift, Q, exec, hyprctl kill
      #bind = ControlShiftAlt, Delete, exec, pkill wlogout || wlogout -p layer-shell
      #        bind = ControlShiftAltSuper, Delete, exec, systemctl poweroff

      bind = $MOD, Escape, exec, wlogout -p layer-shell
      bind = $MOD, V, exec, wf-recorder -f $VIDEODIR/$(date +%Y-%m-%d_%H-%M-%S).mp4
      bind = $MOD, V, exec, $NOTIFY 'Recording started'
      bind = $MODSHIFT, V, exec, killall -s SIGINT wf-recorder
      bind = $MODSHIFT, V, exec, $NOTIFY 'Recording stopped'

      , Print, exec, $SCREENSHOT full
      bind = $MODSHIFT, S, exec, $SCREENSHOT area
      bind = $MODSHIFT, X, exec, $COLORPICKER

      bind = $MOD, D, exec, pkill wofi || run-as-service wofi
      bind = $MOD, Return, exec, run-as-service wezterm
      bind = $MODSHIFT, L, exec, loginctl lock-session

      bind = $MOD, Q, killactive
      bind = $MODSHIFT, Q, exit
      bind = $MOD, F, fullscreen
      bind = $MOD, Space, togglefloating
      bind = $MOD, P, pseudo
      bind = $MOD, S, togglesplit

      #bind = $MODSHIFT, Space, workspaceopt, allfloat
      #bind = $MODSHIFT, Space, exec, $NOTIFY 'Toggled All floating'
      bind = $MODSHIFT, P, workspaceopt, allpseudotile
      bind = $MODSHIFT, P, exec, $NOTIFY ' Toggled All pseudotile'

      bind = $MOD, Tab, cyclenext
      bind = $MOD, Tab, bringactivetotop

      bind = $MOD, A, togglespecialworkspace
      bind = $MOD, A, exec, $NOTIFY 'Toggled special workspace'
      bind = $MODSHIFT, A, movetoworkspace, special
      bind = $MOD, C, exec, hyprctl dispatch centerwindow

      ${builtins.concatStringsSep "\n" (builtins.genList (x: let
        ws = let c = (x + 1) / 10; in builtins.toString (x + 1 - (c * 10));
        in ''
          bind = $MOD, ${ws}, workspace, ${toString (x + 1)}
          bind = $MODSHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}
        '')
      10)}

      bind = $MOD, mouse_down, workspace, e-1
      bind = $MOD, mouse_up, workspace, e+1

      bindm = $MOD, mouse:272, movewindow 
      bindm = $MOD, mouse:273, resizewindow
  '';
}