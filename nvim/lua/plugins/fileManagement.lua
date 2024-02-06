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
		end,
	},
	{
		"is0n/fm-nvim",
		lazy = false,
		config = function()
			require("fm-nvim").setup({
				edit_cmd = "edit",
				cmds = {
					lf_cmd = "lf", -- eg: lf_cmd = "lf -command 'set hidden'"
					fm_cmd = "fm",
					nnn_cmd = "nnn",
					fff_cmd = "fff",
					twf_cmd = "twf",
					fzf_cmd = "fzf", -- eg: fzf_cmd = "fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
					fzy_cmd = "find . | fzy",
					xplr_cmd = "xplr -c ~/.config/xplr/init.lua",
					vifm_cmd = "vifm",
					skim_cmd = "sk",
					broot_cmd = "broot",
					gitui_cmd = "gitui",
					ranger_cmd = "ranger",
					joshuto_cmd = "joshuto",
					lazygit_cmd = "lazygit",
					neomutt_cmd = "neomutt",
					taskwarrior_cmd = "taskwarrior-tui",
				},
				mappings = {},
			})
		end,
	},
	--	{
	--		"sayanarijit/xplr.vim",
	--		config = function()
	--			vim.cmd([[
	--        let g:nnn#layout = { 'window': { 'width': 0.9, 'height': 0.9, 'highlight': 'Debug' } }
	--        let g:nnn#action = {
	--              \ '<c-t>': 'tab split',
	--              \ '<c-x>': 'split',
	--              \ '<c-v>': 'vsplit' }
	--        let g:nnn#replace_netrw = 1
	--      ]])
	--			vim.keymap.set("n", "<leader>xx", ":Xplr<CR>")
	--		end,
	--		lazy = false,
	--	},
	{
		"fhill2/xplr.nvim",
		build = function()
			require("xplr").install({ hide = true })
		end,
  dependencies = {{'nvim-lua/plenary.nvim'}, {'MunifTanjim/nui.nvim'}},
		config = function()
			--require("xplr").install({ hide = true })
			require("xplr").setup({
				ui = {
					border = {
						style = "single",
						highlight = "FloatBorder",
					},
					position = {
						row = "90%",
						col = "50%",
					},
					relative = "editor",
					size = {
						width = "80%",
						height = "30%",
					},
				},
				previewer = {
					split = true,
					split_percent = 0.5,
					ui = {
						border = {
							style = "single",
							highlight = "FloatBorder",
						},
						position = { row = "1%", col = "99%" },
						relative = "editor", -- editor only supported for now
						size = {
							width = "30%",
							height = "99%",
						},
					},
				},
				xplr = {
					open_selection = {
						enabled = true,
						mode = "action",
						key = "o",
					},
					preview = {
						enabled = true,
						mode = "action",
						key = "i",
						fifo_path = "/tmp/nvim-xplr.fifo",
					},
					set_nvim_cwd = {
						enabled = true,
						mode = "action",
						key = "j",
					},
					set_xplr_cwd = {
						enabled = true,
						mode = "action",
						key = "h",
					},
				},
			})

			local opts = { noremap = true, silent = true }
			local nvim_set_keymap = vim.api.nvim_set_keymap
			local mappings = require("xplr.mappings")
			local set_keymap = mappings.set_keymap
			local on_previewer_set_keymap = mappings.on_previewer_set_keymap

			nvim_set_keymap("n", "<space>xx", '<Cmd>lua require"xplr".open()<CR>', opts) -- open/focus cycle
			set_keymap("t", "<space>xx", '<Cmd>lua require"xplr".focus()<CR>', opts) -- open/focus cycle

			nvim_set_keymap("n", "<space>xc", '<Cmd>lua require"xplr".close()<CR>', opts)
			set_keymap("t", "<space>xc", '<Cmd>lua require"xplr".close()<CR>', opts)

			nvim_set_keymap("n", "<space>xv", '<Cmd>lua require"xplr".toggle()<CR>', opts)
			set_keymap("t", "<space>xv", '<Cmd>lua require"xplr".toggle()<CR>', opts)

			on_previewer_set_keymap("t", "<space>xb", '<Cmd>lua require"xplr.actions".scroll_previewer_up()<CR>', opts)
			on_previewer_set_keymap(
				"t",
				"<space>xn",
				'<Cmd>lua require"xplr.actions".scroll_previewer_down()<CR>',
				opts
			)
		end,
	},
}
