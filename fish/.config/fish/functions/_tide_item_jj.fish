function _tide_item_jj
    command -sq jj || return
    jj root --quiet &>/dev/null || return
    set -l info (jj log --ignore-working-copy --no-graph --color=never -r @ -T '
        separate(" ",
            bookmarks.join(", "),
            change_id.shortest(),
            if(conflict, "!"),
            if(empty, "∅"),
        )
    ' 2>/dev/null) || return
    set_color B48EAD
    echo -ns " ($info)"
    set_color normal
end
