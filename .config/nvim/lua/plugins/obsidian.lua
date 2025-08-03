return {
	{
		"obsidian-nvim/obsidian.nvim",
		lazy = true,
		ft = "markdown",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		---@module "obsidian"
		---@type obsidian.config
		opts = {
			legacy_commands = false,
			workspaces = {
				{
					name = "Notes",
					path = "~/Notes",
				},
			},
			attachments = {
				img_folder = "/Attachments",
			},
			daily_notes = {
				folder = "/Journal/Daily",
				default_tags = { },
				template = nil,
				workdays_only = false,
			},
			completion = {
				nvim_cmp = false,
				blink = true,
				min_chars = 1,
			},
			picker = {
				name = "fzf-lua"
			},
			ui = {
				enable = false,
			},
			templates = {
				folder = "/Templates"
			},
			note_id_func = function(title)
				return string.format("%x", os.time())
			end,
			disable_frontmatter = true,
			callbacks = {
				enter_note = function(_, note)
					vim.keymap.set("n", "<leader>ol", "<cmd>Obsidian follow_link<cr>", {
						buffer = note.bufnr,
						desc = "[O]bsidian: Open [L]ink",
					})
					vim.keymap.set("n", "<leader>ot", "<cmd>Obsidian template<cr>", {
						buffer = note.bufnr,
						desc = "[O]bsidian: Insert [T]emplate",
					})
					vim.keymap.set("n", "<leader>od", "<cmd>Obsidian today<cr>", {
						buffer = note.bufnr,
						desc = "[O]bsidian: Open [Daily] Note"
					})
				end,
			},
		},
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		---@module "render-markdown"
		---@type render.md.UserConfig
		opts = {
			checkbox = {
				enabled = true,
				custom = {
					half = {
						raw = "[~]",
						rendered = "󰜥 ",
						highlight = "RenderMarkdownTodo",
						scope_highlight = nil
					},
				},
			},
			latex = {
				enabled = false,
			},
		},
	},
	{
		"folke/snacks.nvim",
		priority=10000,
		---@type snacks.Config
		opts = {
			image = {
				resolve = function(path, src)
					if require("obsidian.api").path_is_note(path) then
						-- Try to find the image in the images directory.
						local image_path = require("obsidian.api").resolve_image_path(src)
						if vim.fn.filereadable(image_path) == 1 then
							return image_path
						end
						
						-- Try to find the image in the entire vault.
						local vault_dir = tostring(Obsidian.dir)
						for p, _ in vim.fs.dir(vault_dir, { depth = 10, follow = true, }) do
							if p:sub(-#src) == src then
								print(p)
								return vim.fs.joinpath(vault_dir, p)
							end
						end
					end
				end,
				convert = {
					notify = false,
				},
				doc = {
					max_height = 10,
				},
			},
		},
	},
}

