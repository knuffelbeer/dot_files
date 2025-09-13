return {
	{
		"3rd/image.nvim",
		config = function()
			-- Example for configuring Neovim to load user-installed installed Lua rocks:
			package.path = package.path ..
			    ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua"
			package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua"

			-- lazy snippet
			require("image").setup({

				backend = "kitty", -- Kitty will provide the best experience, but you need a compatible terminal
				integrations = {}, -- do whatever you want with image.nvim's integrations
				max_width = 100, -- tweak to preference
				max_height = 12, -- ^
				max_height_window_percentage = math.huge, -- this is necessary for a good experience
				max_width_window_percentage = math.huge,
				window_overlap_clear_enabled = true,
				window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
			})
		end,
	},
	{
		"bb010g/treesitter-playground.nvim",
		config = function()
			require("nvim-treesitter.configs").setup({
				playground = {
					enable = true,
					disable = {},
					updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
					persist_queries = false, -- Whether the query persists across vim sessions
					keybindings = {
						toggle_query_editor = "o",
						toggle_hl_groups = "i",
						toggle_injected_languages = "t",
						toggle_anonymous_nodes = "a",
						toggle_language_display = "I",
						focus_language = "f",
						unfocus_language = "F",
						update = "R",
						goto_node = "<cr>",
						show_help = "?",
					},
				},
			})
		end,
	},
	-- {
	-- 	"jmbuhr/otter.nvim",
	-- 	function()
	-- 		local otter = require("otter")
	-- 		otter.setup({
	-- 			lsp = {
	-- 				-- `:h events` that cause the diagnostics to update. Set to:
	-- 				-- { "BufWritePost", "InsertLeave", "TextChanged" } for less performant
	-- 				-- but more instant diagnostic updates
	-- 				diagnostic_update_events = { "BufWritePost" },
	-- 				-- function to find the root dir where the otter-ls is started
	-- 				root_dir = function(_, bufnr)
	-- 					return vim.fs.root(bufnr or 0, {
	-- 						".git",
	-- 						"_quarto.yml",
	-- 						"package.json",
	-- 					}) or vim.fn.getcwd(0)
	-- 				end,
	-- 			},
	-- 			-- options related to the otter buffers
	-- 			buffers = {
	-- 				-- if set to true, the filetype of the otterbuffers will be set.
	-- 				-- otherwise only the autocommand of lspconfig that attaches
	-- 				-- the language server will be executed without setting the filetype
	-- 				set_filetype = true,
	-- 				-- write <path>.otter.<embedded language extension> files
	-- 				-- to disk on save of main buffer.
	-- 				-- usefule for some linters that require actual files
	-- 				-- otter files are deleted on quit or main buffer close
	-- 				write_to_disk = false,
	-- 			},
	-- 			-- list of characters that should be stripped from the beginning and end of the code chunks
	-- 			strip_wrapping_quote_characters = { "'", '"', "`" },
	-- 			-- remove whitespace from the beginning of the code chunks when writing to the ottter buffers
	-- 			-- and calculate it back in when handling lsp requests
	-- 			handle_leading_whitespace = true,
	-- 			-- mapping of filetypes to extensions for those not already included in otter.tools.extensions
	-- 			-- e.g. ["bash"] = "sh"
	-- 			extensions = {},
	-- 			-- add event listeners for LSP events for debugging
	-- 			debug = false,
	-- 			verbose = { -- set to false to disable all verbose messages
	-- 				no_code_found = false, -- warn if otter.activate is called, but no injected code was found
	-- 			},
	-- 		})
	-- 	end,
	-- },
	-- {
	-- 	"quarto-dev/quarto-nvim",
	-- 	"hrsh7th/nvim-cmp",
	-- 	"neovim/nvim-lspconfig",
	-- 	"nvim-treesitter/nvim-treesitter",
	-- 	config = function()
	-- 		require("quarto").setup({
	-- 			debug = false,
	-- 			closePreviewOnExit = true,
	-- 			lspFeatures = {
	-- 				enabled = true,
	-- 				chunks = "curly",
	-- 				languages = { "r", "python", "julia", "bash", "html" },
	-- 				diagnostics = {
	-- 					enabled = true,
	-- 					triggers = { "BufWritePost" },
	-- 				},
	-- 				completion = {
	-- 					enabled = true,
	-- 				},
	-- 			},
	-- 			codeRunner = {
	-- 				enabled = true,
	-- 				default_method = "molten", -- "molten", "slime", "iron" or <function>
	-- 				ft_runners = {}, -- filetype to runner, ie. `{ python = "molten" }`.
	-- 				-- Takes precedence over `default_method`
	-- 				never_run = { "yaml" }, -- filetypes which are never sent to a code runner
	-- 			},
	-- 		})
	-- 	end,
	-- },
	{
		'jmbuhr/otter.nvim',
		dependencies = {
			'nvim-treesitter/nvim-treesitter',
		},
		opts = {
			buffers = {
				-- if set to true, the filetype of the otterbuffers will be set.
				-- otherwise only the autocommand of lspconfig that attaches
				-- the language server will be executed without setting the filetype
				set_filetype = true,
				-- write <path>.otter.<embedded language extension> files
				-- to disk on save of main buffer.
				-- usefule for some linters that require actual files
				-- otter files are deleted on quit or main buffer close
				write_to_disk = false,
			},
		},
	},
	{
		"benlubas/molten-nvim",
		dependencies = {
			"GCBallesteros/jupytext.nvim",
			-- config = 	true	-- Depending on your nvim distro or config you may need to make the loading not lazy
			-- lazy=false,
		},
		version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
		-- dependencies = { "3rd/image.nvim" },
		build = ":UpdateRemotePlugins",
		init = function()
			require("jupytext").setup({
				-- style = "python",
				-- output_extension = "py",
				-- force_ft = "py",
			})
			-- these are examples, not defaults. Please see the readme
			vim.g.molten_auto_open_html_in_browser = true
			vim.g.molten_open_cmd = "zen-browser --new-window "
			vim.g.molten_image_provider = "image.nvim"
			vim.g.molten_output_win_max_height = 20
			vim.keymap.set("n", "<leader>mi", ":MoltenInit python3<CR>", { noremap = true })
			vim.keymap.set("v", "<leader>mv", "<esc>:MoltenEvaluateVisual<CR>", { noremap = true })
			vim.keymap.set("n", "<leader>mc", ":MoltenReevaluateCell<CR>", { noremap = true })
			vim.keymap.set("n", "<leader>mm", ":MoltenEvaluateLine<CR>", { noremap = true })
			vim.keymap.set("n", "<leader>e", ":MoltenEvaluateOperator<CR>", { noremap = true })
			vim.keymap.set("n", "<leader>mn", ":MoltenNext<CR>", { noremap = true })
			vim.keymap.set("n", "<leader>mp", ":MoltenPrev<CR>", { noremap = true })
			vim.keymap.set("n", "<leader>mS", ":MoltenShowOutput<CR>", { noremap = true })
			vim.keymap.set("n", "<leader>mH", ":MoltenHideOutput<CR>", { noremap = true })
			vim.keymap.set("n", "<leader>me", ":noautocmd MoltenEnterOutput<CR>")
			vim.keymap.set("n", "<leader>mx", ":MoltenInterrupt<CR>")
			vim.keymap.set("n", "<leader>md", ":MoltenDeinit<CR>")
		end,
	},
	--{
	--    -- see the image.nvim readme for more information about configuring this plugin
	--    "3rd/image.nvim",
	--    opts = {
	--        backend = "kitty", -- whatever backend you would like to use
	--        max_width = 100,
	--        max_height = 12,
	--        max_height_window_percentage = math.huge,
	--        max_width_window_percentage = math.huge,
	--        window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
	--        window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
	--    },
	--}
}
