return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	lazy = false,
	keys = {
		{
			"<C-n>",
			"<cmd>Neotree filesystem toggle right<CR>",
			desc = "Toggle Neotree right",
		},

		{
			"<leader>e",
			"<cmd>Neotree<CR>",
			desc = "Open or focus Neotree",
		},
	},
	opts = {
		window = { width = 30, position = "right", statusline = false },
		filesystem = {
			filtered_items = {
				hide_dotfiles = false,
				hide_gitignored = false,
				hide_ignored = false,
				hide_by_name = {
					".DS_Store",
					"thumbs.db",
					--"node_modules",
				},
			},
		},
	},
}
