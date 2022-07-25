local status_ok, zoxide = pcall(require, "zoxide")
if not status_ok then
	return
end

zoxide.setup()

local tele_status_ok, telescope = pcall(require, "telescope")
if not tele_status_ok then
	return
end

telescope.load_extension("projects")
