-- Auto-save cho Markdown files trong vault sau 0.5s khi rời Insert mode

-- Biến để lưu timer, tránh tạo nhiều timer cùng lúc
local autosave_timer = nil

-- Hàm kiểm tra xem buffer có hợp lệ để autosave không
local function is_valid_buffer()
	-- Kiểm tra buffer type (phải là file bình thường)
	if vim.bo.buftype ~= "" then
		return false -- Loại bỏ: help, terminal, quickfix, nofile...
	end

	-- Kiểm tra xem file có tên không
	local filepath = vim.fn.expand("%:p")
	if filepath == nil or filepath == "" then
		return false -- Loại bỏ: unnamed buffer
	end

	-- Kiểm tra xem file có phải .md không
	if not filepath:match("%.md$") then
		return false -- Chỉ áp dụng cho .md
	end

	-- Kiểm tra readonly
	if vim.bo.readonly then
		return false -- Không lưu file readonly
	end

	-- Kiểm tra modifiable
	if not vim.bo.modifiable then
		return false -- Không lưu file không thể chỉnh sửa
	end

	return true
end

-- Hàm autosave
local function autosave_markdown()
	-- Kiểm tra buffer hợp lệ
	if not is_valid_buffer() then
		return
	end

	-- Hủy timer cũ nếu có (tránh lưu nhiều lần)
	if autosave_timer ~= nil then
		autosave_timer:stop()
		autosave_timer:close()
		autosave_timer = nil
	end

	-- Tạo timer mới đợi 500ms (0.5 giây)
	autosave_timer = vim.loop.new_timer()
	if autosave_timer == nil then
		return
	end

	autosave_timer:start(
		500,
		0,
		vim.schedule_wrap(function()
			-- Kiểm tra lại một lần nữa khi timer chạy (phòng trường hợp đổi buffer)
			if not is_valid_buffer() then
				return
			end

			-- Kiểm tra xem buffer có thay đổi không
			if vim.bo.modified then
				-- Lưu file
				local ok, err = pcall(vim.cmd, "silent! write")
				if not ok then
					print("Unable to write: " .. vim.fn.expand("%:t"))
				end
			end
		end)
	)
end

-- Tạo autocommand group
local group = vim.api.nvim_create_augroup("MarkdownAutoSave", { clear = true })

-- Tạo autocmd khi rời Insert mode
vim.api.nvim_create_autocmd("InsertLeave", {
	group = group,
	pattern = "*.md", -- Chỉ áp dụng cho file .md
	callback = function()
		local filepath = vim.fn.expand("%:p")

		-- TÙY CHỈNH: Thay đổi đường dẫn vault của bạn ở đây
		-- Expand ~ thành đường dẫn home thực
		local vault_path = vim.fn.expand("~/Documents/note/")

		-- Kiểm tra xem file có nằm trong vault không
		-- Dùng string.find thay vì match để tránh vấn đề pattern
		if not string.find(filepath, vault_path, 1, true) then
			return
		end

		autosave_markdown()
	end,
})
