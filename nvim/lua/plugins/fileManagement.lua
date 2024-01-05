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
		end,
	},
	{
		"ThePrimeagen/harpoon",
		config = function()
			vim.keymap.set("n", "<leader>mh", function()
				require("harpoon.ui").toggle_quick_menu()
			end)
				vim.keymap.set("n", "<leader>af", function ()
					require("harpoon.mark").add_file()
				end)
		end,
	},
	{
		"sayanarijit/xplr.vim",
		config = function()
			vim.cmd([[
        let g:nnn#layout = { 'window': { 'width': 0.9, 'height': 0.9, 'highlight': 'Debug' } }
        let g:nnn#action = {
              \ '<c-t>': 'tab split',
              \ '<c-x>': 'split',
              \ '<c-v>': 'vsplit' }
        let g:nnn#replace_netrw = 1
      ]])
		end,
		lazy = false,
	},
}
