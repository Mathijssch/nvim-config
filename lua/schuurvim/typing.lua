function FillChars(char, width)
	local w = width or 80
	local col = vim.api.nvim_win_get_cursor(0)[2]
	local nbToAdd = math.max(0, w - col - 2)
	local result = string.rep(char, nbToAdd)
	return result
end

function AddStringAtCursor(str)
	-- Get the current buffer number
	local bufnr = vim.api.nvim_get_current_buf()

	-- Get the current cursor position (line and column)
	local cursor = vim.api.nvim_win_get_cursor(0)
	local line = cursor[1] - 1
	local col  = cursor[2] + 1

	-- Insert the string at the current cursor position
	vim.api.nvim_buf_set_text(bufnr, line, col, line, col, { str })
end
