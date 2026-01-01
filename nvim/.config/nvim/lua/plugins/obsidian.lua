return {
	"obsidian-nvim/obsidian.nvim",
	version = "*", -- use latest release, remove to use latest commit
	ft = "markdown",
	---@module 'obsidian'
	---@type obsidian.config
	opts = {
		legacy_commands = false, -- this will be removed in the next major release
		workspaces = {
			{
				name = "personal",
				path = "~/Documents/note",
			},
		},
		templates = {
			folder = "templates",
			date_format = "%Y-%m-%d",
			time_format = "%H:%M",
		},
		note_id_func = function(title)
			if title and title ~= "" then
				return title:gsub("%s+", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
			else
				return tostring(os.time())
			end
		end,
		note_path_func = function(spec)
			-- Tạo tên file từ tiêu đề (slug hóa)
			local name = spec.title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
			return (spec.dir / name):with_suffix(".md")
		end,
	},
}
