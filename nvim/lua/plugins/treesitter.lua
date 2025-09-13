return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {"nvim-treesitter/nvim-treesitter-textobjects"},
	lazy = false,
	config = function()
		require("nvim-treesitter.configs").setup({			-- A list of parser names, or "all" (the five listed parsers should always be installed)
			ensure_installed = { "c", "lua"},

			-- Install parsers synchronously (only applied to `ensure_installed`)
			sync_install = false,

			-- Automatically install missing parsers when entering buffer
			-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
			auto_install = true,

			highlight = {
				enable = true,
				-- disable = { "markdown_inline", "markdown", "md", "latex" }, -- list of language that will be disabled
				-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
				-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
				-- Using this option may slow down your editor, and you may see some duplicate highlights.
				-- Instead of true it can also be a list of languages
				additional_vim_regex_highlighting = false,
			},

					-- ... other ts config
					textobjects = {
									enable = true,
							move = {
									enable = true,
									set_jumps = false, -- you can change this if you want.
									goto_next_start = {
											--- ... other keymaps
											["]c"] = { query = "@code_cell.inner", desc = "next code block" },
									},
									goto_previous_start = {
											--- ... other keymaps
											["[c"] = { query = "@code_cell.inner", desc = "previous code block" },
									},
							},
							select = {
									enable = true,
									lookahead = true, -- you can change this if you want
									keymaps = {
											--- ... other keymaps
											["ic"] = { query = "@code_cell.inner", desc = "in block" },
											["ac"] = { query = "@code_cell.outer", desc = "around block" },
									},
							},
							swap = { -- Swap only works with code blocks that are under the same
											 -- markdown header
									enable = true,
									swap_next = {
											--- ... other keymap
											["<leader>scl"] = "@code_cell.outer",
									},
									swap_previous = {
											--- ... other keymap
											["<leader>sch"] = "@code_cell.outer",
									},
							},
					}
			})



		-- vim.api.nvim_create_autocmd("FileType", {
		-- 	pattern = "tex",
		-- 	callback = function(args)
		-- 		vim.treesitter.start(args.buf, "latex")
		-- 		vim.bo[args.buf].syntax = "on" -- only if additional legacy syntax is needed
		-- 	end,
		-- })
	end,
}
