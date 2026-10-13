-- Setup monitors
-- See https://wiki.hyprland.org/Configuring/Monitors/

-- env = XCURSOR_SIZE,24
-- these 3 are for screen sharing apparently: https://bbs.archlinux.org/viewtopic.php?id=299426
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- these are meant to solve issue where copying text from electron app doesn't immediately copy it to clipboard, but it does show up in the clipboard manager entry for some reason
-- env = ELECTRON_OZONE_PLATFORM_HINT,wayland # adding this breaks postman (can't launch)
-- env = QT_QPA_PLATFORM,wayland;xcb
-- env = GDK_BACKEND,wayland,x11
-- env = CLUTTER_BACKEND,wayland
-- env = SDL_VIDEODRIVER,wayland

-- Source a file (multi-file configs)
require("moccha")
require("keybindings")
require("windowrules")

-- monitor=name,resolution,position,scale
hl.monitor({
    output = "eDP-1",
    mode = "1920x1080@144",
    position = "0x1080",
    scale = "1",
})

hl.monitor({
    output = "DP-1",
    mode = "1920x1080@144",
    position = "0x0",
    scale = "1",
})

-- See https://wiki.hyprland.org/Configuring/Keywords/ for more

-- Execute your favorite apps at launch

hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })
hl.animation({
    leaf = "windows",
    enabled = true,
    speed = 1,
    bezier = "myBezier",
})
hl.animation({
    leaf = "windowsOut",
    enabled = true,
    speed = 1,
    bezier = "default",
    style = "popin 80%",
})
hl.animation({
    leaf = "border",
    enabled = true,
    speed = 3,
    bezier = "default",
})
hl.animation({
    leaf = "fade",
    enabled = true,
    speed = 1,
    bezier = "default",
})
hl.animation({
    leaf = "workspaces",
    enabled = true,
    speed = 1,
    bezier = "default",
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace",
})

-- Icons
local GLOBE_ICON = ""
local GITHUB_ICON = ""
local MONITOR_ICON = ""
local FILE_CODE_ICON = ""
local FILE_CODE_SOLID = "icon "
local FINGERPRINT_ICON = ""
local BRACKETS_CURLY_ICON = ""
local JAVA_ICON = ""
local CURLY_BRACKET_ICON = ""

-- Colorschemes
local DMENU_SB = "#6272A4"
local DMENU_SF = "#F8F8F2"
local DMENU_NB = "#282A36"
local DMENU_NF = "#F8F8F2"
local DMENU_SHB = "#6272A4"
local DMENU_SHF = "#FA485D"
local DMENU_NHB = "#282A36"
local DMENU_NHF = "#FA485D"

-- workspaces
hl.workspace_rule({ workspace = "1", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "2", monitor = "DP-1" })
hl.workspace_rule({ workspace = "3", monitor = "DP-1" })
hl.workspace_rule({ workspace = "4", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "5", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "6", monitor = "DP-1" })
hl.workspace_rule({ workspace = "7", monitor = "DP-1" })
hl.workspace_rule({ workspace = "8", monitor = "DP-1" })
hl.workspace_rule({ workspace = "9", monitor = "DP-1" })
hl.workspace_rule({ workspace = "10", monitor = "DP-1" })
hl.workspace_rule({ workspace = "11", monitor = "DP-1" })
hl.workspace_rule({ workspace = "12", monitor = "DP-1" })
hl.workspace_rule({ workspace = "13", monitor = "DP-1" })
hl.workspace_rule({ workspace = "14", monitor = "DP-1" })
hl.workspace_rule({ workspace = "15", monitor = "DP-1" })
hl.workspace_rule({ workspace = "16", monitor = "DP-1" })
hl.workspace_rule({ workspace = "17", monitor = "DP-1" })

-- For all categories, see https://wiki.hyprland.org/Configuring/Variables/
hl.config({
    input = {
        kb_layout = "us",
        kb_variant = "",
        kb_model = "",
        kb_options = "",
        kb_rules = "",
        follow_mouse = 1,
        touchpad = {
            natural_scroll = true,
            scroll_factor = 0.3,
        },
        sensitivity = 0.4, -- -1.0 - 1.0, 0 means no modification.
    },
    general = {
        -- See https://wiki.hyprland.org/Configuring/Variables/ for more
        gaps_in = 2,
        gaps_out = 1,
        border_size = 2,
        col = {
            active_border = "rgb(cdd6f4)",
            inactive_border = "rgba(595959aa)",
        },
        layout = "dwindle",
    },
    misc = {
        disable_hyprland_logo = true,
        focus_on_activate = 0,
    },
    render = {
        direct_scanout = false,
    },
    decoration = {
        -- See https://wiki.hyprland.org/Configuring/Variables/ for more
        rounding = 5,
    },
    animations = {
        enabled = false,
    },
    dwindle = {
        -- See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        force_split = 2,
        preserve_split = true, -- you probably want this
    },
    master = {},
})

-- Per-device input configs
-- See https://wiki.hyprland.org/Configuring/Keywords/#per-device-input-configs
hl.device({
    name = "josefadamcik-sofle",
    repeat_rate = 40,
    repeat_delay = 200,
})

hl.device({
    name = "zmk-project-sofle-keyboard",
    repeat_rate = 40,
    repeat_delay = 200,
})

hl.device({
    name = "sofle-keyboard",
    repeat_rate = 40,
    repeat_delay = 200,
})

hl.device({
    name = "at-translated-set-2-keyboard",
    repeat_rate = 40,
    repeat_delay = 200,
})

hl.on("hyprland.start", function()
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("killall mako; killall dunst; dunst")
    hl.exec_cmd("killall udiskie; udiskie -t")
    hl.exec_cmd("wl-paste --watch cliphist store")
    hl.exec_cmd("~/.scripts/handle_monitor_connect.sh")
    hl.exec_cmd("waybar")
end)

hl.on("config.reloaded", function()
    hl.exec_cmd("killall swaybg; swaybg -m fill -i ~/pictures/wallpaper/linuxterminal.png")
end)
