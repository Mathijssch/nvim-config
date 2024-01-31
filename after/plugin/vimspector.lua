vim.g.vimspector_enable_mappings = "VISUAL_STUDIO" -- Use VS-code mappings for vimspector

vim.keymap.set("n", "<leader>dbg", "<Plug>VimspectorToggleBreakpoint")
vim.keymap.set("n", "<leader><F9>", "<Plug>VimspectorToggleConditionalBreakpoint")
vim.api.nvim_create_user_command("DebugStop", function() vim.cmd('VimspectorReset') end, {})
