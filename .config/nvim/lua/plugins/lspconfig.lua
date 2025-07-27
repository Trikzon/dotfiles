return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- mason manages tool installation (e.g., lsps, linters, etc.)
			{ "williamboman/mason.nvim", opts = {}, },
			{ "williamboman/mason-lspconfig.nvim", },
			{ "WhoIsSethDaniel/mason-tool-installer.nvim", },
			-- show status updates for LSP in bottom right corner
			{ "j-hui/fidget.nvim", },
			--{  -- tell the lua lsp about neovim types
			--	"folke/lazydev.nvim",
			--	ft = "lua",  -- only load on lua files
			--	opts = {
			--		{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			--	}
			--},
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true}),
				callback = function(event)
					local map = function(desc, keys, func)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc })
					end

					map("[G]oto [D]efinition", "gd", require("fzf-lua").lsp_definitions)
					map("[G]oto [R]eferences", "gr", require("fzf-lua").lsp_references)
					map("[G]oto [I]mplementation", "gI", require("fzf-lua").lsp_implementations)
					map("[G]oto [D]eclaration", "gD", vim.lsp.buf.declaration)
					map("Type [D]efinition", "<leader>D", require("fzf-lua").lsp_typedefs)
					map("[C]ode [R]ename", "<leader>cr", vim.lsp.buf.rename)
					map("[C]ode [A]ction", "<leader>ca", vim.lsp.buf.code_action)
					map("[T]oggle Inlay [H]ints", "<leader>th",
						function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
						end
					)

					-- highlight references of the word under your cursor when it rests there
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
						local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf, group = highlight_augroup, callback = vim.lsp.buf.document_highlight,
						})
						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf, group = highlight_augroup, callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds { group = "kickstart-lsp-highlight", buffer = event2.buf }
							end,
						})
					end
				end,
			})

			vim.diagnostic.config {
				severity_sort = true,
				float = { border = "rounded", source = "if_many" },
				underline = { severity = vim.diagnostic.severity.ERROR },
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = '󰅚 ',
						[vim.diagnostic.severity.WARN] = '󰀪 ',
						[vim.diagnostic.severity.INFO] = '󰋽 ',
						[vim.diagnostic.severity.HINT] = '󰌶 ',
					},
				},
				virtual_text = {
					source = "if_many",
					spacing = 2,
					format = function(diagnostic)
						local diagnostic_message = {
							[vim.diagnostic.severity.ERROR] = diagnostic.message,
							[vim.diagnostic.severity.WARN] = diagnostic.message,
							[vim.diagnostic.severity.INFO] = diagnostic.message,
							[vim.diagnostic.severity.HINT] = diagnostic.message,
						}
						return diagnostic_message[diagnostic.severity]
					end,
				},
			}

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("blink-cmp").get_lsp_capabilities(capabilities)

			local servers = {
				lua_ls = {
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
							diagnostics = { disable = { "missing-fields" }, },
						},
					},
				},
				emmet_language_server = { },
				svelte = { },
			}

			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, { "stylua" })
			require("mason-tool-installer").setup { ensure_installed = ensure_installed }

			require("mason-lspconfig").setup {
				ensure_installed = {},
				automatic_installation = false,
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			}
		end,
	},
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {},
	}
}

