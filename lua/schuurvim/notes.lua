function MoveFile()
    -- Get the current buffer number
    local current_bufnr = vim.fn.bufnr('%')
    -- Get the filename for the current buffer
    local current_file = vim.api.nvim_buf_get_name(current_bufnr)
    -- Strip the extension
    local stripped = vim.fn.fnamemodify(current_file, ':r')
    local svg = stripped .. ".svg"
    vim.cmd(string.format([[! pdf2svg %s.pdf %s]], stripped, svg))
    os.rename( stripped .. ".svg", "Notebook/Attachments/" .. svg)
end

vim.cmd([[command! Tikz2Note lua MoveFile()]])

