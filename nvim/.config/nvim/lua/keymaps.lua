-- Keymaps
local map = vim.keymap.set
map({ "n", "t" }, "<C-h>", [[<C-\><C-n><C-w>h]], { noremap = true, silent = true })
map({ "n", "t" }, "<C-j>", [[<C-\><C-n><C-w>j]], { noremap = true, silent = true })
map({ "n", "t" }, "<C-k>", [[<C-\><C-n><C-w>k]], { noremap = true, silent = true })
map({ "n", "t" }, "<C-l>", [[<C-\><C-n><C-w>l]], { noremap = true, silent = true })
--Several minor things
map("n", "<C-c>t", "<cmd>tabnew<CR>", { desc = "New tab" })
map("n", "<C-c>x", "<cmd>tabclose<CR>", { desc = "Close tab" })
vim.g.mapleader = " "
-- Compile & run C++ file
vim.keymap.set("n", "<leader>bc", function()
	local file = vim.fn.expand("%:p")
	local output = vim.fn.expand("%:r")
	vim.cmd('botright 15split | terminal g++ "' .. file .. '" -o "' .. output .. '" && "' .. output .. '"')
end, { desc = "Build & run C++ file" })
-- Run python file
vim.keymap.set("n", "<leader>bp", function()
	local file = vim.fn.expand("%:p")
	vim.cmd('botright 15split | terminal python3 "' .. file .. '"')
end, { desc = "Run Python file" })
-- Run live server, require live-server installed with npm install -g live-server
map("n", "<leader>ls", function()
	vim.fn.jobstart("live-server . --port=5500", { detach = true })
	print("Live server started on http://127.0.0.1:5500")
end, { desc = "Start live server" })
map("n", "<leader>lx", function()
	vim.fn.jobstart("pkill -f live-server")
	print("Live server stopped")
end, { desc = "Stop live server" })
--Intergrated terminal
map("n", "<leader>t", ":botright split | terminal<CR>", { desc = "Open terminal at the bottom" })
vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "*",
	command = "startinsert",
})
-- Exit terminal mode by pressing <Esc>
map("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, silent = true })
map("n", "<Esc>", "<cmd>noh<CR><Esc>", { silent = true })
