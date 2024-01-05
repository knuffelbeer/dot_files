return {

		"benlubas/molten-nvim",
		dependencies = {

			"3rd/image.nvim",
		},
		build = ":UpdateRemotePlugins",
		version = "^1.0.0",
		lazy = false,
		init = function()
			-- this is an example, not a default. Please see the readme for more configuration options
			vim.g.molten_output_win_max_height = 12
			vim.g.molten_image_provider = "image.nvim"
			require("image").setup({
				backend = "kitty",
			})
			vim.keymap.set("n", "<leader>mi", ":MoltenInit python3<CR>", { silent = true, desc = "Initialize the plugin" })
			vim.keymap.set("n", "<leader>e", ":MoltenEvaluateOperator<CR>", { silent = true, desc = "run operator selection" })
			vim.keymap.set("n", "<leader>mm", ":MoltenEvaluateLine<CR>", { silent = true, desc = "evaluate line" })
			vim.keymap.set("n", "<leader>mc", ":MoltenReevaluateCell<CR>", { silent = true, desc = "re-evaluate cell" })
			vim.keymap.set("v", "<leader>mv", ":<C-u>MoltenEvaluateVisual<CR>gv", { silent = true, desc = "evaluate visual selection" })
		end,
}
