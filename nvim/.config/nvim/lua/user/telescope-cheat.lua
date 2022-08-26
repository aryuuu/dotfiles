local tele_status_ok, telescope = pcall(require, "telescope")
if not tele_status_ok then
    return
end

telescope.load_extension("cheat")
