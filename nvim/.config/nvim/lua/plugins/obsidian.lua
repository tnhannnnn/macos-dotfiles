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
			if title == nil then
				return tostring(os.time())
			end
			return title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", " "):lower()
		end,
	},
}
