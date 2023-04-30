vim.g.vimspector_enable_mappings = "VISUAL_STUDIO" -- Use VS-code mappings for vimspector

vim.keymap.set("n", "<leader>dbg", "<Plug>VimspectorToggleBreakpoint")
vim.api.nvim_create_user_command("DebugStop", function() vim.cmd('VimspectorReset') end, {})
