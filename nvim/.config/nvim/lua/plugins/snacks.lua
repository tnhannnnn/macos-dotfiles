return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			input = { enabled = true }, -- required for picker
			picker = {
				enabled = true,
				sources = {
					files = {
						hidden = true, -- Show hidden/dotfiles
						ignored = false, -- Respect .gitignore
					},
					grep = {
						hidden = true, -- Also search in hidden files
						ignored = false,
					},
				},
			}, -- file picker / grep
			dashboard = { enabled = true },
			indent = { enabled = true },
		},
		keys = {
			-- Open Lazygit #require lazygit installed
			{
				"<leader>lg",
				function()
					require("snacks").lazygit()
				end,
				desc = "Lazygit",
			},

			-- File picker
			{
				"<leader>ff",
				function()
					require("snacks").picker.files()
				end,
				desc = "Find Files",
			},
			{
				"<leader>fg",
				function()
					require("snacks").picker.grep()
				end,
				desc = "Grep word",
			},
		},
	},
}
