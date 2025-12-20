return {
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			-- list of servers for mason to install
			ensure_installed = {
				"clangd",
				"ts_ls",
				"html",
				"cssls",
				"lua_ls",
				"pyright",
				"tailwindcss",
			},
		},
		dependencies = {
			{
				"williamboman/mason.nvim",
				opts = {
					ui = {
						icons = {
							package_installed = "✓",
							package_pending = "➜",
							package_uninstalled = "✗",
						},
					},
				},
			},
			{
				"neovim/nvim-lspconfig",
			},
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = {
			ensure_installed = {
				"clang-format", --cpp formatter
				"prettier", -- prettier formatter
				"stylua", -- lua formatter
				"black", --python formatter
			},
		},
		dependencies = {
			"williamboman/mason.nvim",
		},
	},
	{
		"brenoprata10/nvim-highlight-colors",
		opts = {
			enable_tailwind = true,
		},
	},
}
