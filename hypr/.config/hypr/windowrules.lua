-- Window rules

hl.window_rule({
    name = "windowrule-1",
    match = {
        class = "^(org.telegram.desktop)$",
    },
    workspace = "3",
    opacity = "0.8 0.8",
})

hl.window_rule({
    name = "windowrule-2",
    match = {
        class = "(?i)^(slack)$",
    },
    workspace = "9",
    -- immediate = true
})

hl.window_rule({
    name = "windowrule-3",
    match = {
        class = "^(Postman)$",
    },
    workspace = "7",
})

hl.window_rule({
    name = "windowrule-4",
    match = {
        class = "^(DBeaver)$",
    },
    workspace = "11",
})

hl.window_rule({
    name = "windowrule-5",
    match = {
        class = "^(robo3t)$",
    },
    workspace = "11",
})

hl.window_rule({
    name = "windowrule-6",
    match = {
        class = "^(mongodb-compass)$",
    },
    workspace = "11",
})

hl.window_rule({
    name = "windowrule-7",
    match = {
        class = "^(code-oss)$",
    },
    workspace = "14",
})

hl.window_rule({
    name = "windowrule-8",
    match = {
        class = "^(Authy Desktop)$",
    },
    workspace = "8",
})

hl.window_rule({
    name = "windowrule-9",
    match = {
        class = "^(kitty)$",
    },
    opacity = "0.8 0.8",
})

hl.window_rule({
    name = "windowrule-10",
    match = {
        class = "^(thunar)$",
    },
    opacity = "0.8 0.8",
})

-- windowrulev2 = opacity 0.9 0.9, class:^(com.mitchellh.ghostty)$
-- windowrulev2 = opacity 0.85 0.85, class:^(Slack)$
hl.window_rule({
    name = "windowrule-11",
    match = {
        class = "(Rofi)",
    },
    stay_focused = true,
})

-- windowrulev2 = forceinput, class:(Rofi)

hl.window_rule({
    name = "windowrule-12",
    match = {
        class = "^(xwaylandvideobridge)$",
    },
    opacity = "0.0 override 0.0 override",
    no_anim = true,
    no_initial_focus = true,
    max_size = "1 1",
    no_blur = true,
})

--- Gromit related rules
hl.workspace_rule({
    workspace = "special:gromit",
    gaps_in = 0,
    gaps_out = 0,
    on_created_empty = "gromit-mpx -a",
})

hl.window_rule({
    name = "windowrule-13",
    match = {
        class = "^(Gromit-mpx)$",
    },
    no_blur = true,
    opacity = "1 override",
    no_shadow = true,
    size = "(monitor_w*1) (monitor_h*1)",
})

-- windowrulev2 = fakefullscreen, class:^(Gromit-mpx)$

--- terminal related rules
-- workspace = special:term, on-created-empty:[float] alacritty

--- satty related rules
hl.window_rule({
    name = "windowrule-14",
    match = {
        class = "^(satty)$",
    },
    float = true,
})
