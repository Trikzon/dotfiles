return {
	"neanias/everforest-nvim",
	version = false,
	lazy = false,
	priority = 1000,
	config = function()
		require("everforest").setup({
			background = "hard",
			transparent_background_level = 2,
			italics = true,
			disable_italic_comments = false,
			sign_column_background = "none",
			ui_contrast = "high",
			dim_inactive_windows = false,
			diagnostic_text_highlight = false,
			diagnostic_virtual_text = "coloured",
			diagnostic_line_highlight = false,
			spell_foreground = false,
			show_eob = true,
			float_style = "bright",
			inlay_hints_background = "none",
			on_highlights = function(highlight_groups, palette) end,
			colours_override = function(palette) end,
		})

		vim.cmd.colorscheme "everforest"
	end,
}

