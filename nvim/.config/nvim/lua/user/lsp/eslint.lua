local eslint_status_ok, eslint = pcall(require, "eslint")
if not eslint_status_ok then
    return
end

eslint.setup({
    bin = 'eslint', -- or `eslint_d`
    code_actions = {
        enable = true,
        apply_on_save = {
            enable = true,
            types = { "problem", "layout", "suggestion", "directive" }, -- "directive", "problem", "suggestion", "layout"
        },
        disable_rule_comment = {
            enable = true,
            location = "separate_line", -- or `same_line`
        },
    },
    diagnostics = {
        enable = true,
        report_unused_disable_directives = false,
        run_on = "save", -- or `save` or `type`
    },
})
