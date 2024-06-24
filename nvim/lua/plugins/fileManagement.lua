return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		style = "borderless",
		-- or                              , branch = '0.1.x',
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

			vim.keymap.set("n", "<leader>fr", builtin.lsp_references, {})
			vim.keymap.set("n", "<leader>ds", builtin.lsp_document_symbols, {})
			vim.keymap.set("n", "<leader>ws", builtin.lsp_dynamic_workspace_symbols, {})
			local hl = function(name, opts)
				vim.api.nvim_set_hl(0, name, opts)
			end

			--			hl("TelescopeNormal", { bg = "#181825" })
			--			hl("TelescopePreviewNormal", { bg = "#181825" })
			--			hl("TelescopeResultsNormal", { bg = "#181825" })
			--			hl("TelescopeBorder", { bg = "#181825" })
			--			hl("TelescopePreviewBorder", { fg = "#181825", bg = "#181825" })
			--			hl("TelescopePromptBorder", { fg = "#313244", bg = "#313244" })
			--			hl("TelescopeResultsBorder", { fg = "#181825", bg = "#181825" })
			--			hl("TelescopeTitle", { fg = "#181825", bg = "#89b4fa" })
			--			hl("TelescopePreviewTitle", { fg = "#181825", bg = "#89b4fa" })
			--			hl("TelescopePromptNormal", { bg = "#313244" })
			--			hl("TelescopePromptTitle", { fg = "#181825", bg = "#89b4fa" })
			--			hl("TelescopePromptCounter", { fg = "#89b4fa", bg = "#313244" })
			--			hl("TelescopePromptPrefix", { fg = "#89b4fa", bg = "#313244" })

			hl("TelescopeNormal", { bg = "none", fg = "#870000" })
			hl("TelescopePreviewNormal", { bg = "none", fg = "#5f6b64" })
			hl("TelescopeResultsNormal", { bg = "none", fg = "#5f6b64" })
			hl("TelescopeBorder", { bg = "#181825" })
			hl("TelescopePreviewBorder", { fg = "#870000", bg = "none" })
			hl("TelescopePromptBorder", { fg = "#870000", bg = "none" })
			hl("TelescopeResultsBorder", { fg = "#870000", bg = "none" })
			hl("TelescopeTitle", { fg = "#181825", bg = "#870000" })
			hl("TelescopePreviewTitle", { fg = "#181825", bg = "#870000" })
			hl("TelescopePromptNormal", { bg = "none", fg = "#5f6b64" })
			hl("TelescopePromptTitle", { fg = "#181825", bg = "#870000" })
			hl("TelescopePromptCounter", { fg = "#870000", bg = "none" })
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			-- This is your opts table
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			-- To get ui-select loaded and working with telescope, you need to call
			-- load_extension, somewhere after setup function:
			require("telescope").load_extension("ui-select")
		end,
	},
	{
		"ThePrimeagen/harpoon",
		config = function()
			vim.keymap.set("n", "<leader>mh", function()
				require("harpoon.ui").toggle_quick_menu()
			end)
			vim.keymap.set("n", "<leader>af", function()
				require("harpoon.mark").add_file()
			end)

			for x = 1, 9 do
				vim.keymap.set("n", "<leader>h" .. x, function()
					require("harpoon.ui").nav_file(x)
				end, { noremap = true })

				vim.keymap.set("n", "<leader>h0", function()
					require("harpoon.ui").nav_file(10)
				end, { noremap = true })
			end
		end,
	},
}
