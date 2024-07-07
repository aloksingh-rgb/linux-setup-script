return {

	-- tokyonight
	{
		"folke/tokyonight.nvim",
		config = function()
			require("tokyonight").setup({
				lazy = true,
				opts = { style = "night" },
			})
		end
	},
	-- catppuccin
	{
		"catppuccin/nvim",
		config = function()
			require("catppuccin").setup({
				color_overrides = {
					all = {
						base = "#0a0a0a",
						mantle = "#0a0a0a",
						crust = "#0a0a0a",			
					},
				},
				lazy = true,
				name = "catppuccin",
				opts = {
					integrations = {
						aerial = true,
						alpha = true,
						cmp = true,
						dashboard = true,
						flash = true,
						gitsigns = true,
						headlines = true,
						illuminate = true,
						indent_blankline = { enabled = true },
						leap = true,
						lsp_trouble = true,
						mason = true,
						markdown = {true,
							mini = true,
							native_lsp = {
								enabled = true,
								underlines = {
									errors = { "undercurl" },
									hints = { "undercurl" },
									warnings = { "undercurl" },
									information = { "undercurl" },
								},
							},
							navic = { enabled = true, custom_bg = "lualine" },
							neotest = true,
							neotree = true,
							noice = true,
							notify = true,
							semantic_tokens = true,
							telescope = true,
							treesitter = true,
							treesitter_context = true,
							which_key = true,
						},
					},
				},
			})
			vim.cmd[[colorscheme catppuccin-mocha]]
		end,
	},
}
