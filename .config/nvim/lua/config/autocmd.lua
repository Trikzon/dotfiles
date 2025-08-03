vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ timeout = 300 })
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.opt.expandtab = false
		-- display tab characters as four spaces long
		vim.opt.tabstop = 4
		-- only indent by one tab character when pressing tab
		vim.opt.softtabstop = 4
		-- shift indents by only one tab character
		vim.opt.shiftwidth = 4
	end
})

