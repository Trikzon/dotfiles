return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{
			-- tell the lua lsp about neovim types
			"folke/lazydev.nvim",
			-- only load on lua files
			ft = "lua",
			opts = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			}
		}
	},
	config = function()
		require("lspconfig").lua_ls.setup {}
	end,
}

