vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.cursorline = true
vim.o.mouse = "a"
vim.o.confirm = true
vim.o.termguicolors = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.opt.clipboard = "unnamedplus"
vim.opt.fillchars:append({ eob = " " })
vim.opt.shortmess:append("I")
vim.g.mapleader = " "
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.o.cmdheight = 0
vim.o.showcmd = true
vim.opt.laststatus = 0
vim.opt.winbar = "%t"
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "md" },
	callback = function()
		vim.opt_local.wrap = false
	end,
})
-- keymap
local map = vim.keymap.set
map("n", "<leader>tn", "<cmd>tabnew<CR>", { silent = true })
map("n", "<leader>tx", "<cmd>tabclose<CR>", { silent = true })
map("n", "<C-h>", "<C-w>h", {})
map("n", "<C-j>", "<C-w>j", {})
map("n", "<C-k>", "<C-w>k", {})
map("n", "<C-l>", "<C-w>l", {})
map("n", "<Esc>", "<cmd>noh<CR><Esc>", { silent = true })
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
	{ "rebelot/kanagawa.nvim" },
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").install({ "markdown" })
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			indent = {
				char = "│",
			},
			scope = {
				enabled = false,
			},
			whitespace = {
				remove_blankline_trail = true,
			},
		},
		config = function(_, opts)
			require("ibl").setup(opts)
		end,
	},
	{
		"karb94/neoscroll.nvim",
		opts = {},
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	{
		"saghen/blink.cmp",
		dependencies = { "rafamadriz/friendly-snippets" },
		version = "1.*",
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = { preset = "super-tab" },

			appearance = {
				nerd_font_variant = "mono",
			},
			completion = { documentation = { auto_show = false } },
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
			fuzzy = { implementation = "prefer_rust" },
		},
		opts_extend = { "sources.default" },
	},
	{
		"nvim-telescope/telescope.nvim",
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- optional but recommended
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			{ "nvim-telescope/telescope-ui-select.nvim" },
		},
		config = function()
			require("telescope").setup({
				defaults = {
					layout_strategy = "horizontal",
					layout_config = {
						horizontal = {
							preview_width = 0.5, -- rất quan trọng
							results_width = 0.5,
						},
						width = 0.95,
						height = 0.9,
						prompt_position = "top",
					},
					sorting_strategy = "ascending",
					preview = {
						treesitter = true,
					},
				},
			})
			require("telescope").load_extension("ui-select")
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
		end,
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
		lazy = false,
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {
			heading = {
				enabled = true,
				icons = { "", "", "", "", "", "" }, -- không số, không icon
				position = "inline",
			},
		},
	},
	{
		"obsidian-nvim/obsidian.nvim",
		version = "*", -- use latest release, remove to use latest commit
		lazy = false,
		keys = {
			{ "<leader>gf", "<cmd>Obsidian follow_link<CR>", {} },
			{ "<leader>ch", "<cmd>Obsidian toggle_checkbox<CR>" },
			{ "<leader>ot", "<cmd>Obsidian today<CR>" },
			{ "<leader>od", "<cmd>Obsidian dailies<CR>" },
			{ "<leader>on", "<cmd>Obsidian new_from_template<CR>" },
		},
		opts = {
			legacy_commands = false, -- this will be removed in the next major release
			workspaces = {
				{
					name = "personal",
					path = "/Users/tnhannn/Library/Mobile Documents/iCloud~md~obsidian/Documents/Note",
				},
			},
			ui = {
				enable = false,
				ignore_conceal_warn = true,
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
				return title:gsub(" ", "-"):gsub("\\[\\^A-Za-z0-9-\\]", ""):lower()
			end,
			daily_notes = {
				folder = "daily",
				date_format = "%Y-%m-%d",
				template = "daily.md",
				workdays_only = false,
			},
			checkbox = {
				enabled = true,
				create_new = true,
				order = { " ", "-", "x" },
			},
		},
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons", -- optional, but recommended
		},
		lazy = false, -- neo-tree will lazily load itself
		keys = {
			{ "<leader>e", "<cmd>Neotree toggle right<CR>" },
		},
		opts = {
			window = { width = 30, position = "right", statusline = false, winbar = false },
			filesystem = {
				filtered_items = {
					hide_by_name = {
						".DS_Store",
						"thumbs.db",
						--"node_modules",
					},
				},
			},
		},
	},
}, {
	checker = {
		enabled = true,
		notify = false,
	},
	change_detection = {
		notify = false,
	},
})
vim.cmd("colorscheme kanagawa-wave")
require("task_organizer")
require("autowrite")
