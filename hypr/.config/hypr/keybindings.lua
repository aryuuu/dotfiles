-- See https://wiki.hyprland.org/Configuring/Keywords/ for more

local mainMod = "SUPER"
local altMod = "ALT"

hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd("~/.scripts/lockscreen.sh"))

hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd("grim -l 2 -g \"$(slurp)\" - | swappy -f -")) -- take a screenshot
hl.bind(mainMod .. " + mouse:273", hl.dsp.exec_cmd("grim -l 2 -g \"$(slurp)\" - | swappy -f -")) -- take a screenshot
-- bind = $mainMod, mouse:273, exec, grim -g "$(slurp)" - | satty -f - # take a screenshot

hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("~/.scripts/wl-ocr.sh"))

-- brings more harm than good since i am using mac for work, sometimes i did this when trying to paste stuff
-- bind = $mainMod SHIFT, V, exec, pgrep wf-recorder && pkill wf-recorder || wf-recorder -g "$(slurp -o)" -f /home/fatt/Videos/recording-$(date +%F-%H-%M-%S).mp4
-- bind = $mainMod, V, exec, pgrep wf-recorder && pkill wf-recorder || wf-recorder -g "$(slurp -o)" -F format=rgb24 -x rgb24 -p qp=0 -p crf=0 -p preset=veryslow -p tune=animation -c libx264rgb -f /home/fatt/Videos/recording-$(date +%F-%H-%M-%S).mp4

-- bind = $mainMod SHIFT, V, exec, pgrep wf-recorder && pkill wf-recorder || wf-recorder -f /home/fatt/Videos/recording-$(date +%F-%H-%M-%S).mp4

hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd("alacritty")) -- open terminal
-- bind = $mainMod, RETURN, exec, ghostty # open terminal
hl.bind(mainMod .. " + SHIFT + SPACE", hl.dsp.window.float({ action = "toggle" })) -- Allow a window to float
hl.bind(mainMod .. " + E", hl.dsp.layout("togglesplit")) -- dwindle

-- menus
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("rofi -show run"))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd("rofi -show run"))
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("rofi -show ssh"))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("networkmanager_dmenu -c -i -fn \"FontAwesome\" -p  -l 5 -sb $DMENU_SB -sf $DMENU_SF -nb $DMENU_NB -nf $DMENU_NF -shb $DMENU_SHB -shf $DMENU_SHF -nhb $DMENU_NHB -nhf $DMENU_NHF"))
-- bind = $mainMod, N, exec, ~/.scripts/rofi-networkmanager.sh
-- bind = $mainMod, N, exec, rofi -show wifi -modi "wifi:iwdrofimenu"
hl.bind(mainMod .. " + SHIFT + N", hl.dsp.exec_cmd("~/.scripts/rofi-bluetooth.sh"))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("~/.scripts/rofi-passmenu.sh -i -fn \"FontAwesome\" -p ' '"))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("~/.scripts/rofi-otpmenu.sh -i -fn \"FontAwesome\" -p ' '"))
-- bind = $mainMod, C, exec, CM_LAUNCHER=rofi clipmenu -c -i -f -fn "FontAwesome" -p ' ' -l 10 -sb $DMENU_SB -sf $DMENU_SF -nb $DMENU_NB -nf $DMENU_NF -shb $DMENU_SHB -shf $DMENU_SHF -nhb $DMENU_NHB -nhf $DMENU_NHF & sleep 0.1; hyprctl dispatch focuswindow "^(Rofi)"
-- bind = $mainMod, C, exec, rofi -modi clipboard:~/.scripts/cliphist-rofi-img -show clipboard -show-icons -c -i -f -fn "FontAwesome" -p ' ' -l 10 -sb $DMENU_SB -sf $DMENU_SF -nb $DMENU_NB -nf $DMENU_NF -shb $DMENU_SHB -shf $DMENU_SHF -nhb $DMENU_NHB -nhf $DMENU_NHF
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("rofi -modi clipboard:~/.scripts/cliphist-rofi -show clipboard -show-icons -c -i -f -fn \"FontAwesome\" -p ' ' -l 10 -sb $DMENU_SB -sf $DMENU_SF -nb $DMENU_NB -nf $DMENU_NF -shb $DMENU_SHB -shf $DMENU_SHF -nhb $DMENU_NHB -nhf $DMENU_NHF"))
hl.bind(mainMod .. " + I", hl.dsp.exec_cmd("~/.scripts/sink.sh"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("~/.scripts/books.sh"))
hl.bind(mainMod .. " + U", hl.dsp.exec_cmd("~/project/dmenu-emoji/dmenu-emoji.sh"))
hl.bind(mainMod .. " + SHIFT + U", hl.dsp.exec_cmd("~/.scripts/dmemes.sh"))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("~/.scripts/dsnippet.sh 1"))
hl.bind(mainMod .. " + G", hl.dsp.exec_cmd("~/.scripts/dmenu-github.sh"))
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd("~/.scripts/rofi-checklist.sh"))
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("~/.scripts/pomodoro menu"))

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +5%"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -5%"))
hl.bind(mainMod .. " + XF86AudioRaiseVolume", hl.dsp.exec_cmd("pactl set-source-volume @DEFAULT_SOURCE@ +5%"))
hl.bind(mainMod .. " + XF86AudioLowerVolume", hl.dsp.exec_cmd("pactl set-source-volume @DEFAULT_SOURCE@ -5%"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle"))
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("pactl set-source-mute @DEFAULT_SOURCE@ toggle"))

-- bind = , XF86MonBrightnessDown, exec, ~/.scripts/backlight/dec
-- bind = , XF86MonBrightnessUp, exec, ~/.scripts/backlight/inc
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"))
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 5%+"))

hl.bind(mainMod .. " + Prior", hl.dsp.exec_cmd("~/.scripts/hypr_brightness.sh -"))
hl.bind(mainMod .. " + Next", hl.dsp.exec_cmd("~/.scripts/hypr_brightness.sh +"))

hl.bind(mainMod .. " + grave", hl.dsp.exec_cmd("dunstctl history-pop"))
hl.bind(mainMod .. " + SHIFT + grave", hl.dsp.exec_cmd("dunstctl close-all"))

--- Gromit related bindings
hl.bind(mainMod .. " + SHIFT + D", hl.dsp.workspace.toggle_special("gromit"))
hl.bind("F8", hl.dsp.exec_cmd("gromit-mpx --undo"))
hl.bind("SHIFT + F8", hl.dsp.exec_cmd("gromit-mpx --redo"))
hl.bind(mainMod .. " + mouse:274", hl.dsp.workspace.toggle_special("gromit"))
hl.bind(mainMod .. " + mouse:275", hl.dsp.exec_cmd("gromit-mpx --undo"))
hl.bind(mainMod .. " + mouse:276", hl.dsp.exec_cmd("gromit-mpx --redo"))

--- terminal scratchpad bindings
-- bind = $mainMod, T, togglespecialworkspace, term

--- widgets
-- bind = $mainMod, W, exec, eww list-windows | grep "calendar" && eww close calendar || eww open calendar
-- bind = $mainMod, W, exec, ~/.scripts/work-logger.sh

-- bind = $mainMod, grave, exec, makoctl restore
-- bind = $mainMod SHIFT, grave, exec, makoctl dismiss
-- bind = $mainMod, X, exec, makoctl dismiss -a
-- bind = $mainMod SHIFT, O, exec, makoctl invoke

-- Kill window
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.close()) -- close the active window

-- misc control
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))

-- Move window
hl.bind(mainMod .. " + SHIFT + h", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + l", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + k", hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + j", hl.dsp.window.move({ direction = "d" }))

-- Switch workspaces with mainMod + [0-9]
hl.bind(mainMod .. " + 1", hl.dsp.focus({ workspace = 1 }))
hl.bind(mainMod .. " + 2", hl.dsp.focus({ workspace = 2 }))
hl.bind(mainMod .. " + 3", hl.dsp.focus({ workspace = 3 }))
hl.bind(mainMod .. " + 4", hl.dsp.focus({ workspace = 4 }))
hl.bind(mainMod .. " + 5", hl.dsp.focus({ workspace = 5 }))
hl.bind(mainMod .. " + 6", hl.dsp.focus({ workspace = 6 }))
hl.bind(mainMod .. " + 7", hl.dsp.focus({ workspace = 7 }))
hl.bind(mainMod .. " + 8", hl.dsp.focus({ workspace = 8 }))
hl.bind(mainMod .. " + 9", hl.dsp.focus({ workspace = 9 }))
hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = 10 }))
hl.bind(mainMod .. " + comma", hl.dsp.focus({ workspace = 11 }))
hl.bind(mainMod .. " + period", hl.dsp.focus({ workspace = 12 }))
hl.bind(mainMod .. " + slash", hl.dsp.focus({ workspace = 13 }))
hl.bind(mainMod .. " + semicolon", hl.dsp.focus({ workspace = 14 }))
hl.bind(mainMod .. " + bracketleft", hl.dsp.focus({ workspace = 15 }))
hl.bind(mainMod .. " + bracketright", hl.dsp.focus({ workspace = 16 }))

hl.bind(mainMod .. " + Tab", hl.dsp.focus({ last = true }))
hl.bind(altMod .. " + Tab", hl.dsp.focus({ workspace = "e+1" }))
-- bind = $mainMod, Tab, focusurgentorlast

-- Move active window to a workspace with mainMod + SHIFT + [0-9]
-- can use movetoworkspacesilent instead: https://www.reddit.com/r/hyprland/comments/11wjpa7/how_to_move_a_window_to_another_workspace_with/
hl.bind(mainMod .. " + SHIFT + 1", hl.dsp.window.move({ workspace = 1, follow = false }))
hl.bind(mainMod .. " + SHIFT + 2", hl.dsp.window.move({ workspace = 2, follow = false }))
hl.bind(mainMod .. " + SHIFT + 3", hl.dsp.window.move({ workspace = 3, follow = false }))
hl.bind(mainMod .. " + SHIFT + 4", hl.dsp.window.move({ workspace = 4, follow = false }))
hl.bind(mainMod .. " + SHIFT + 5", hl.dsp.window.move({ workspace = 5, follow = false }))
hl.bind(mainMod .. " + SHIFT + 6", hl.dsp.window.move({ workspace = 6, follow = false }))
hl.bind(mainMod .. " + SHIFT + 7", hl.dsp.window.move({ workspace = 7, follow = false }))
hl.bind(mainMod .. " + SHIFT + 8", hl.dsp.window.move({ workspace = 8, follow = false }))
hl.bind(mainMod .. " + SHIFT + 9", hl.dsp.window.move({ workspace = 9, follow = false }))
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10, follow = false }))
hl.bind(mainMod .. " + SHIFT + comma", hl.dsp.window.move({ workspace = 11, follow = false }))
hl.bind(mainMod .. " + SHIFT + period", hl.dsp.window.move({ workspace = 12, follow = false }))
hl.bind(mainMod .. " + SHIFT + slash", hl.dsp.window.move({ workspace = 13, follow = false }))
hl.bind(mainMod .. " + SHIFT + semicolon", hl.dsp.window.move({ workspace = 14, follow = false }))
hl.bind(mainMod .. " + SHIFT + bracketleft", hl.dsp.window.move({ workspace = 15, follow = false }))
hl.bind(mainMod .. " + SHIFT + bracketright", hl.dsp.window.move({ workspace = 16, follow = false }))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ monitor = "+1" }))

-- Scroll through existing workspaces with mainMod + scroll
-- bind = $mainMod, mouse_down, workspace, e+1
-- bind = $mainMod, mouse_up, workspace, e-1

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag())
-- bindm = $mainMod, mouse:273, resizewindow

-- resize mode
-- will switch to a submap called resize
hl.bind(mainMod .. " + R", hl.dsp.submap("resize"))

-- will start a submap called "resize"
hl.define_submap("resize", function()
    -- sets repeatable binds for resizing the active window
    hl.bind("l", hl.dsp.window.resize({ x = 30, y = 0, relative = true }), { repeating = true })
    hl.bind("h", hl.dsp.window.resize({ x = -30, y = 0, relative = true }), { repeating = true })
    hl.bind("k", hl.dsp.window.resize({ x = 0, y = -30, relative = true }), { repeating = true })
    hl.bind("j", hl.dsp.window.resize({ x = 0, y = 30, relative = true }), { repeating = true })

    -- use reset to go back to the global submap
    hl.bind("escape", hl.dsp.submap("reset"))
    hl.bind("return", hl.dsp.submap("reset"))
    hl.bind(mainMod .. " + R", hl.dsp.submap("reset"))
end)

-- Cursor submap (similar to the Mouse mode in Sway)
hl.define_submap("cursor", function()
    -- Jump cursor to a position
    hl.bind("a", hl.dsp.exec_cmd("hyprctl dispatch submap reset && wl-kbptr && hyprctl dispatch submap cursor"))

    -- Cursor movement
    hl.bind("j", hl.dsp.exec_cmd("wlrctl pointer move 0 10"), { repeating = true })
    hl.bind("k", hl.dsp.exec_cmd("wlrctl pointer move 0 -10"), { repeating = true })
    hl.bind("l", hl.dsp.exec_cmd("wlrctl pointer move 10 0"), { repeating = true })
    hl.bind("h", hl.dsp.exec_cmd("wlrctl pointer move -10 0"), { repeating = true })

    -- Left button
    hl.bind("s", hl.dsp.exec_cmd("wlrctl pointer click left"))
    -- Middle button
    hl.bind("d", hl.dsp.exec_cmd("wlrctl pointer click middle"))
    -- Right button
    hl.bind("f", hl.dsp.exec_cmd("wlrctl pointer click right"))

    -- Scroll up and down
    hl.bind("e", hl.dsp.exec_cmd("wlrctl pointer scroll 10 0"), { repeating = true })
    hl.bind("r", hl.dsp.exec_cmd("wlrctl pointer scroll -10 0"), { repeating = true })

    -- Scroll left and right
    hl.bind("t", hl.dsp.exec_cmd("wlrctl pointer scroll 0 -10"), { repeating = true })
    hl.bind("g", hl.dsp.exec_cmd("wlrctl pointer scroll 0 10"), { repeating = true })

    -- Exit cursor submap
    -- If you do not use cursor timeout or cursor:hide_on_key_press, you can delete its respective calls.
    hl.bind("escape", hl.dsp.exec_cmd("hyprctl keyword cursor:inactive_timeout 3; hyprctl keyword cursor:hide_on_key_press true; hyprctl dispatch submap reset"))
end)

-- Entrypoint
-- If you do not use cursor timeout or cursor:hide_on_key_press, you can delete its respective calls.
hl.bind(mainMod .. " + u", hl.dsp.exec_cmd("hyprctl keyword cursor:inactive_timeout 0; hyprctl keyword cursor:hide_on_key_press false; hyprctl dispatch submap cursor"))
