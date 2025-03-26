function FillChars(char, width)
    local w = width or 80
    local col = vim.api.nvim_win_get_cursor(0)[2]
    local nbToAdd = math.max(0, w - col - 2)
    local result = string.rep(char, nbToAdd)
    return result
end

function AddStringAtCursor(str)
    -- Get the current buffer number
    local bufnr  = vim.api.nvim_get_current_buf()

    -- Get the current cursor position (line and column)
    local cursor = vim.api.nvim_win_get_cursor(0)
    local line   = cursor[1] - 1
    local col    = cursor[2] + 1

    -- Insert the string at the current cursor position
    vim.api.nvim_buf_set_text(bufnr, line, col, line, col, { str })
end

function GetPositionOfVisualSelection()
    local s_start = vim.fn.getpos("'<")
    local s_end = vim.fn.getpos("'>")
    return s_start, s_end
end

function GetVisualSelection()
    local s_start, s_end = GetPositionOfVisualSelection()
    local n_lines = math.abs(s_end[2] - s_start[2]) + 1
    local lines = vim.api.nvim_buf_get_lines(0, s_start[2] - 1, s_end[2], false)
    lines[1] = string.sub(lines[1], s_start[3], -1)
    if n_lines == 1 then
        lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3] - s_start[3] + 1)
    else
        lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3])
    end
    return lines
end

function ReplaceVisualSelection(modifier)
    return
        function()
            local buf = vim.api.nvim_get_current_buf()

            local lines = GetVisualSelection()
            -- Modify the text
            for i, v in pairs(lines) do
                vim.notify(v)
            end
            local new_text = modifier(lines)
            local s_start, s_end = GetPositionOfVisualSelection()
            local start_line, start_col = s_start[2] - 1, s_start[3] - 1
            local end_line, end_col = s_end[2] - 1, s_end[3]
            -- Replace the selection with the new content
            vim.api.nvim_buf_set_text(buf, start_line, start_col, end_line, end_col, new_text)
        end
end

---Surround the given text with the prefix in front and the suffix in the back.
---@param text table
---@param prefix string
---@param suffix string
function SurroundWith(text, prefix, suffix)
    if #text == 0 then
        return text
    end
    text[1] = prefix .. text[1]
    text[#text] = text[#text] .. suffix
    return text
end
