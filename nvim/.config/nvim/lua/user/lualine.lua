local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

-- local function hello_world()
-- 	print("Hello world!")
-- 	return "hello_world"
-- end

-- local function is_venn_enabled()
-- 	local venn_enabled = vim.inspect(vim.b.venn_enabled)
-- 	if venn_enabled == "nil" then
-- 		return "x"
-- 	end

-- 	return "v"
-- end

local filename = {
	"filename",
	file_status = true, -- Displays file status (readonly status, modified status)
	newfile_status = true, -- Display new file status (new file means no write after created)
	path = 1, -- 0: Just the filename
	-- 1: Relative path
	-- 2: Absolute path
	-- 3: Absolute path, with tilde as the home directory

	shorting_target = 100, -- Shortens path to leave 40 spaces in the window
	-- for other components. (terrible name, any suggestions?)
	symbols = {
		modified = "[+]", -- Text to show when the file is modified.
		readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
		unnamed = "[No Name]", -- Text to show for unnamed buffers.
		newfile = "[New]", -- Text to show for new created file before first writting
	},
}

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn" },
	symbols = { error = " ", warn = "! " },
	colored = true,
	update_in_insert = false,
	always_visible = true,
}

local diff = {
	"diff",
	colored = false,
	diff_color = {
		added = "green",
		modified = "yellow",
		removed = "red",
	},
	symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
	cond = hide_in_width,
}

local mode = {
	"mode",
	fmt = function(str)
		-- return "- " .. str .. " -"
		return str
	end,
}

local filetype = {
	"filetype",
	icons_enabled = false,
	icon = nil,
}

local branch = {
	"branch",
	icons_enabled = true,
	icon = "",
}

local location = {
	"location",
	padding = 0,
}

-- cool function for progress
local progress = function()
	local current_line = vim.fn.line(".")
	local total_lines = vim.fn.line("$")
	local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
	local line_ratio = current_line / total_lines
	local index = math.ceil(line_ratio * #chars)
	return chars[index]
end

local spaces = function()
	return vim.api.nvim_buf_get_option(0, "shiftwidth")
end

lualine.setup({
	options = {
		icons_enabled = true,
		theme = "auto",

		-- for powerline look
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },

		-- -- for bubble look
		-- component_separators = "|",
		-- section_separators = { left = "", right = "" },
		-- disabled_filetypes = { "dashboard", "NvimTree", "Outline" },
		-- always_divide_middle = true,
	},
	sections = {
		-- powerline look
		lualine_a = { branch },

		-- bubbly look
		-- lualine_a = {
		-- 	{ "branch", separator = { left = "", right = "" }, right_padding = 0 },
		-- },
		lualine_b = { mode },
		lualine_c = { "lsp_progress", filename },
		-- lualine_x = { "encoding", "fileformat", "filetype" },
		-- lualine_x = { diff, spaces, "encoding", filetype },
		lualine_x = { diagnostics, spaces, "encoding", filetype },
		lualine_y = { location },
		-- powerline look
		lualine_z = { progress },

		-- bubbly look
		-- lualine_z = {
		-- 	{ "progress", fmt = progress, separator = { left = "", right = "" }, left_padding = 0 },
		-- },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
})
