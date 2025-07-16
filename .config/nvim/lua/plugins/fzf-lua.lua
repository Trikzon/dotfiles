return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		files = {
			hidden = true,
			follow = true,
			no_ignore = true,
		},
		grep = {
			hidden = true,
			follow = true,
			no_ignore = true,
		},
	},
	keys = {
		{
			"<leader>ff",
			function() require("fzf-lua").files() end,
			desc = "[F]ind [F]iles",
		},
		{
			"<leader>fg",
			function() require("fzf-lua").live_grep() end,
			desc = "[F]ind [G]rep",
		},
		{
			"<leader>fd",
			function() require("fzf-lua").files({ cwd = "~/.dotfiles" }) end,
			desc = "[F]ind Files in [D]otfiles",
		},
		{
			"<leader>fh",
			function() require("fzf-lua").helptags() end,
			desc = "[F]ind [H]elp",
		},
		{
			"<leader>f.",
			function() require("fzf-lua").resume() end,
			desc = "[F]ind Again",
		},
		{
			"<leader>fr",
			function() require("fzf-lua").oldfiles() end,
			desc = "[F]ind [R]ecent",
		},
		{
			"<leader>f/",
			function() require("fzf-lua").lgrep_curbuf() end,
			desc = "[F]ind Grep Current Buffer",
		},
	},
}

