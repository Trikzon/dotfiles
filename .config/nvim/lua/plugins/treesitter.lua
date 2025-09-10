return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"css",
				"html",
				"javascript",
				"latex",
				"lua",
				"markdown",
				"svelte",
				"typescript",
			},
			sync_install = false,
			highlight = {
				enable = true,
				disable = {
					"latex",
				},
			},
			indent = { enable = true },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<Enter>",
					node_incremental = "<Enter>",
					scope_incremental = false,
					node_decremental = "<Backspace>",
				},
			},
		})
	end
}

