{ pkgs, lib, ... }:
let wallpaper_path = "~/.config/niri/wallpaper.png";
in
{
  imports = [
    ../../dot/fuzzel/default.nix
    ../../dot/waybar/default.nix
    ../../dot/swaync/default.nix
  ];
  home.packages = with pkgs; [
    swaybg
    xwayland-satellite
  ];

  home.file.".scripts" = {
    source = ./scripts;
    recursive = true;
  };

  home.file."${wallpaper_path}" = {
    source = ../../resources/simple-bulb.png;
  };

  programs.niri = {
    config = ''
      spawn-at-startup "xwayland-satellite"
      spawn-at-startup "waybar"
      spawn-at-startup "fcitx5 -d"
      spawn-at-startup "systemctl" "--user" "start" "gamma"
      spawn-at-startup "${lib.getExe pkgs.swaybg}" "-m" "fill" "-i" "${wallpaper_path}"
      spawn-at-startup "~/.scripts/swayidle.sh"

      input {
          touchpad {
              tap
              natural-scroll
              middle-emulation
          }
      }

      cursor {
          xcursor-size 12
      }

      layout {
          gaps 6
          center-focused-column "never"

          preset-column-widths {
              proportion 0.33333
              proportion 0.5
              proportion 0.66667
          }

          default-column-width {
              proportion 1.0;
          }

          focus-ring {
              off
          }

          border {
              off
          }
      }

      environment {
        QT_QPA_PLATFORM "wayland"
        DISPLAY ":0"
      }

      hotkey-overlay {
        skip-at-startup
      }

      screenshot-path "~/screenshots/screenshot-%Y-%m-%d_%H-%M-%S.png"

      animations {
       slowdown 1.0;
      }

      workspace "browser"

      workspace "music"

      workspace "code"

      workspace "misc"

      workspace "mail"

      binds {
          // Mod-Shift-/, which is usually the same as Mod-?,
          // shows a list of important hotkeys.
          Mod+Shift+Slash { show-hotkey-overlay; }

          // Suggested binds for running programs: terminal, app launcher, screen locker.
          Mod+RETURN { spawn "kitty"; }
          Mod+X { spawn "fuzzel"; }

          XF86AudioLowerVolume { spawn "pactl" "set-sink-volume" "@DEFAULT_SINK@" "-5%"; }
          XF86AudioMute { spawn "pactl" "set-sink-mute" "@DEFAULT_SINK@" "toggle"; }
          XF86AudioRaiseVolume { spawn "pactl" "set-sink-volume" "@DEFAULT_SINK@" "+5%"; }

          XF86MonBrightnessDown { spawn "brightnessctl" "s" "5%-";  }
          XF86MonBrightnessUp { spawn "brightnessctl" "s" "+5%";  }

          // Close Active window
          Mod+Q { close-window; }

          // Move focus between columns
          Mod+Left  { focus-column-left; }
          // Mod+Down  { focus-window-down; }
          // Mod+Up    { focus-window-up; }
          Mod+Right { focus-column-right; }
    
          Mod+W { focus-workspace-up; }
          Mod+S { focus-workspace-down; }
          Mod+A { focus-column-left; }
          Mod+D { focus-column-right; }

          // Move entire column
          Mod+Shift+Left  { move-column-left; }
          Mod+Shift+Down  { move-column-to-workspace-down; }
          Mod+Shift+Up    { move-column-to-workspace-up; }
          Mod+Shift+Right { move-column-right; }
  
          // Alternative commands that move across workspaces when reaching
          // the first or last window in a column.
          // Mod+J     { focus-window-or-workspace-down; }
          // Mod+K     { focus-window-or-workspace-up; }
          // Mod+Ctrl+J     { move-window-down-or-to-workspace-down; }
          // Mod+Ctrl+K     { move-window-up-or-to-workspace-up; }

          Mod+Home { focus-column-first; }
          Mod+End  { focus-column-last; }
          Mod+Ctrl+Home { move-column-to-first; }
          Mod+Ctrl+End  { move-column-to-last; }

          // Alternatively, there are commands to move just a single window:
          // Mod+Shift+Ctrl+Left  { move-window-to-monitor-left; }
          // ...

          // And you can also move a whole workspace to another monitor:
          // Mod+Shift+Ctrl+Left  { move-workspace-to-monitor-left; }
          // ...

          Mod+Page_Down      { focus-workspace-down; }
          Mod+Page_Up        { focus-workspace-up; }
          Mod+Down           { focus-workspace-down; }
          Mod+Up             { focus-workspace-up; }
          Mod+Ctrl+Page_Down { move-column-to-workspace-down; }
          Mod+Ctrl+Page_Up   { move-column-to-workspace-up; }
          Mod+Ctrl+Down      { move-column-to-workspace-down; }
          Mod+Ctrl+Up        { move-column-to-workspace-up; }

          // Alternatively, there are commands to move just a single window:
          // Mod+Ctrl+Page_Down { move-window-to-workspace-down; }
          // ...

          Mod+Shift+Page_Down { move-workspace-down; }
          Mod+Shift+Page_Up   { move-workspace-up; }
          // Mod+Shift+Down      { move-workspace-down; }
          // Mod+Shift+Up        { move-workspace-up; }

          Mod+WheelScrollDown      cooldown-ms=150 { focus-workspace-down; }
          Mod+WheelScrollUp        cooldown-ms=150 { focus-workspace-up; }
          Mod+Ctrl+WheelScrollDown cooldown-ms=150 { move-column-to-workspace-down; }
          Mod+Ctrl+WheelScrollUp   cooldown-ms=150 { move-column-to-workspace-up; }

          Mod+WheelScrollRight      { focus-column-right; }
          Mod+WheelScrollLeft       { focus-column-left; }
          Mod+Ctrl+WheelScrollRight { move-column-right; }
          Mod+Ctrl+WheelScrollLeft  { move-column-left; }

          // Usually scrolling up and down with Shift in applications results in
          // horizontal scrolling; these binds replicate that.
          Mod+Shift+WheelScrollDown      { focus-column-right; }
          Mod+Shift+WheelScrollUp        { focus-column-left; }
          Mod+Ctrl+Shift+WheelScrollDown { move-column-right; }
          Mod+Ctrl+Shift+WheelScrollUp   { move-column-left; }

          // Focus workspace
          Mod+1 { spawn "~/.scripts/exec_and_signal.sh" "focus-workspace 1"; }
          Mod+2 { spawn "~/.scripts/exec_and_signal.sh" "focus-workspace 2"; }
          Mod+3 { spawn "~/.scripts/exec_and_signal.sh" "focus-workspace 3"; }
          Mod+4 { spawn "~/.scripts/exec_and_signal.sh" "focus-workspace 4"; }
          Mod+5 { spawn "~/.scripts/exec_and_signal.sh" "focus-workspace 5"; }
          Mod+6 { spawn "~/.scripts/exec_and_signal.sh" "focus-workspace 6"; }
          Mod+7 { spawn "~/.scripts/exec_and_signal.sh" "focus-workspace 7"; }
          Mod+8 {  spawn "~/.scripts/exec_and_signal.sh" "focus-workspace 8"; }
          Mod+9 {  spawn "~/.scripts/exec_and_signal.sh" "focus-workspace 9"; }

          // Move column to workspace
          Mod+Shift+1 { spawn "~/.scripts/exec_and_signal.sh" "move-column-to-workspace 1" "focus-workspace 1"; }
          Mod+Shift+2 { spawn "~/.scripts/exec_and_signal.sh" "move-column-to-workspace 2" "focus-workspace 2"; }
          Mod+Shift+3 { spawn "~/.scripts/exec_and_signal.sh" "move-column-to-workspace 3" "focus-workspace 3"; }
          Mod+Shift+4 { spawn "~/.scripts/exec_and_signal.sh" "move-column-to-workspace 4" "focus-workspace 4"; }
          Mod+Shift+5 { spawn "~/.scripts/exec_and_signal.sh" "move-column-to-workspace 5" "focus-workspace 5"; }
          Mod+Shift+6 { spawn "~/.scripts/exec_and_signal.sh" "move-column-to-workspace 6" "focus-workspace 6"; }
          Mod+Shift+7 { spawn "~/.scripts/exec_and_signal.sh" "move-column-to-workspace 7" "focus-workspace 7"; }
          Mod+Shift+8 { spawn "~/.scripts/exec_and_signal.sh" "move-column-to-workspace 8" "focus-workspace 8"; }
          Mod+Shift+9 { spawn "~/.scripts/exec_and_signal.sh" "move-column-to-workspace 9" "focus-workspace 9"; }

          // Alternatively, there are commands to move just a single window:
          // Mod+Ctrl+1 { move-window-to-workspace 1; }

          // Switches focus between the current and the previous workspace.
          // Mod+Tab { focus-workspace-previous; }

          Mod+Comma  { consume-window-into-column; }
          Mod+Period { expel-window-from-column; }

          // There are also commands that consume or expel a single window to the side.
          // Mod+BracketLeft  { consume-or-expel-window-left; }
          // Mod+BracketRight { consume-or-expel-window-right; }

          Mod+R { switch-preset-column-width; }
          Mod+Shift+R { reset-window-height; }
          Mod+F { maximize-column; }
          Mod+Shift+F { fullscreen-window; }
          Mod+C { center-column; }

          Mod+Minus { set-column-width "-10%"; }
          Mod+Equal { set-column-width "+10%"; }

          // Finer height adjustments when in column with other windows.
          Mod+Shift+Minus { set-window-height "-10%"; }
          Mod+Shift+Equal { set-window-height "+10%"; }

          // Actions to switch layouts.
          // Note: if you uncomment these, make sure you do NOT have
          // a matching layout switch hotkey configured in xkb options above.
          // Having both at once on the same hotkey will break the switching,
          // since it will switch twice upon pressing the hotkey (once by xkb, once by niri).
          Mod+Space       { switch-layout "next"; }
          Mod+Shift+Space { switch-layout "prev"; }

          Print { screenshot; }
          Ctrl+Print { screenshot-screen; }
          Alt+Print { screenshot-window; }

          // The quit action will show a confirmation dialog to avoid accidental exits.
          Mod+Shift+E { quit; }

          // Powers off the monitors. To turn them back on, do any input like
          // moving the mouse or pressing any other key.
          Mod+Shift+P { power-off-monitors; }
          Mod+L { spawn "~/.scripts/swayidle.sh"; }
          Mod+Shift+N { spawn "swaync-client" "-t"; }
      }
    '';
  };

}
