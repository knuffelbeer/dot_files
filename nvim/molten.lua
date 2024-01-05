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

			require("image").setup({
				backend = "ueberzug",
			})
		end,
}
