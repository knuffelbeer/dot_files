return {
	{
		"3rd/image.nvim",

		config = function()
			-- Example for configuring Neovim to load user-installed installed Lua rocks:
			package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua"
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
		"benlubas/molten-nvim",
		version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
		-- dependencies = { "3rd/image.nvim" },
		build = ":UpdateRemotePlugins",
		init = function()
			-- these are examples, not defaults. Please see the readme
			vim.g.molten_image_provider = "image.nvim"
			vim.g.molten_output_win_max_height = 20
			vim.keymap.set("n", "<leader>mi", ":MoltenInit python3<CR>", { noremap = true })
			vim.keymap.set("v", "<leader>mv", "<esc>:MoltenEvaluateVisual<CR>", { noremap = true })
			vim.keymap.set("n", "<leader>mc", ":MoltenEvaluateCell<CR>", { noremap = true })
			vim.keymap.set("n", "<leader>mm", ":MoltenEvaluateLine<CR>", { noremap = true })
			vim.keymap.set("n", "<leader>e", ":MoltenEvaluateOperator<CR>", { noremap = true })
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
