vim.keymap.set("n", "-", "<cmd>Oil<CR>", {
	desc = "Open Parent Directory in Oil",
})

vim.keymap.set("n", "<leader>od", function() vim.diagnostic.open_float() end, {
	desc = "[O]pen [D]iagnostics in Float"
})

