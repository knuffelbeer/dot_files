return {

		"benlubas/molten-nvim",
		dependencies = {

			"3rd/image.nvim",
		},
		build = ":UpdateRemotePlugins",
		version = "^1.0.0",
	ft = "python" ,
		init = function()
			-- this is an example, not a default. Please see the readme for more configuration options
			vim.g.molten_output_win_max_height = 12
			vim.g.molten_image_provider = "image.nvim"
			require("image").setup({
				backend = "kitty",
			})
			vim.keymap.set("n", "<localleader>mi", ":MoltenInit python3<CR>", { silent = true, desc = "Initialize the plugin" })
			vim.keymap.set("n", "<localleader>e", ":MoltenEvaluateOperator<CR>", { silent = true, desc = "run operator selection" })
			vim.keymap.set("n", "<localleader>mm", ":MoltenEvaluateLine<CR>", { silent = true, desc = "evaluate line" })
			vim.keymap.set("n", "<localleader>mc", ":MoltenReevaluateCell<CR>", { silent = true, desc = "re-evaluate cell" })
			vim.keymap.set("v", "<localleader>mv", ":<C-u>MoltenEvaluateVisual<CR>gv", { silent = true, desc = "evaluate visual selection" })
		end,
}
