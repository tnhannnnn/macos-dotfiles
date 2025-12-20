return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		options = {
			theme = "rose-pine",
			globalstatus = true,
		},
	},
	sections = {
		lualine_x = {
			{ "encoding" },
			{ "fileformat", symbols = { unix = "" } },
			{ "filetype" },
		},
	},
}
