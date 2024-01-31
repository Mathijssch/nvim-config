vim.g.mapleader = " " -- Set the leader to space.
vim.keymap.set("n", "<leader>pd", vim.cmd.Ex, { desc = "Open the directory view" })

-- Motions to move the selected text up or down.
-- This includes automatic indentation.
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", "y", "ygv")

vim.keymap.set("n", "<F12>", "<cmd>Goyo<CR>")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Keep cursor in the middle during half-page jumping" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Keep cursor in the middle during half-page jumping" })
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("i", "<C-BS>", "<C-w>")
vim.keymap.set("i", "<C-c>", "<Esc>") -- This is almost the same as the default, but it fixes some minor differences.

-- leader-paste: replace the current word with whatever is pasted.
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Yank to the system clipboard.
vim.keymap.set({ "n", "v" }, "<leader>y", [["+ygv]], { desc = "Yank selected text to the system clipboard" })
vim.keymap.set({ "v" }, "<C-c>", [["+ygv]], { desc = "Yank selected text to the system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Ygv]], { desc = "Yank the current line to the system clipboard" })

-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without yanking." })

vim.keymap.set("n", "Q", "<nop>")                     -- Disable Q
vim.keymap.set("n", "<leader>ff", vim.lsp.buf.format) -- format

vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz", { desc = "Go to the next item in the quickfix list" })
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz", { desc = "Go to the previous item in the quickfix list" })
vim.keymap.set("n", "<leader>j", "<cmd>lnext<CR>zz", { desc = "Go to the next item in the location list" })
vim.keymap.set("n", "<leader>k", "<cmd>lprev<CR>zz", { desc = "Go to the previous item in the location list" })

--vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
--    { desc = "Replace the word currently underneath the cursor, over the whole file" })
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>a", { desc = "ctrl+S for save." })
vim.keymap.set("n", "<C-s>", ":w<CR>", { desc = "ctrl+S for save in normal mode." })

vim.keymap.set("i", "<C-z>", "<Esc>ua", { desc = "ctrl+z for undo" })
vim.keymap.set("n", "<C-a>", "ggVG", { desc = "Select everything" })

-- Create a new file
require('schuurvim.pathman')

vim.keymap.set("n", "<C-n>", function()
        vim.ui.input({ prompt = 'new file: ' }, function(input)
            print(input)
            local dir, file = SplitPath(input)
            print(dir, file)
            if dir ~= nil then
                print(string.format("!mkdir -p %s", dir))
                vim.cmd(string.format("silent !mkdir -p %s", dir))
            end
            vim.cmd.edit(input)
            --vim.Open(input)
        end)
    end,
    { desc = "Create new file" }
)


-- Resizing
--
-- - Horizontal resize
vim.keymap.set("n", "<C-Left>", [[10<C-w><]], { desc = "Decrease width of current window" })
vim.keymap.set("n", "<C-Right>", [[10<C-w>>]], { desc = "Increase width of current window" })
-- - Vertical resize
vim.keymap.set("n", "<C-Down>", [[<C-w>-]], { desc = "Decrease height of current window" })
vim.keymap.set("n", "<C-Up>", [[<C-w>+]], { desc = "Increase height of current window" })

-- Keymaps for the debugger.
vim.g.vimspector_enable_mappings = "VISUAL_STUDIO" -- Use VS-code mappings for vimspector

-- Removing trailing whitespace
vim.keymap.set("n", "<leader>wh", [[<cmd>%s/\s\+\(\n\)/\1/e<CR>]])

-- Go back to previously opened file
vim.keymap.set("n", "<C-`>", "<C-^>", { desc = "Go to previously opened file" })


-- Open a new terminal to the side.
vim.cmd.set("splitbelow")
vim.keymap.set("n", "<leader>t", [[<cmd>:split | resize 20 | terminal<CR>i]], { desc = "Open a new terminal below" })

-- Exit terminal mode
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "Get signature help" })


local function copyBuf()
    local path = vim.fn.expand('%:p')
    local cmd = string.format("let @+ = '%s'", path)
    vim.cmd(cmd)
    vim.notify(string.format(
        [[Copied current path
%s
to clipboard.]], path))
end

vim.api.nvim_create_user_command("CpBuf", copyBuf, {})

vim.keymap.set("n", "<Leader><Tab>", [[gt]])
vim.keymap.set("n", "<C-t>", [[<Cmd>tabnew<CR>]])
