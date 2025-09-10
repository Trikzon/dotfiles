return {
	"lervag/vimtex",
	lazy = false,
	init = function()
		vim.g.vimtex_view_method = "zathura"
		vim.g.vimtex_compiler_latexmk = {
			aux_dir = '/tmp/vimtex',
			out_dir = '/tmp/vimtex',
		}
	end,
}

