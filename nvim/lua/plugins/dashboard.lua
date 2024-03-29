return {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	dependencies = { { "nvim-tree/nvim-web-devicons" } },
	config = function()
		local db = require("dashboard")
		db.setup({
			theme = "doom",
			preview = {
				command = "lolcat",
				file_path = "~/header.txt",
				file_height = 120,
				file_width = 140,
			}, --your footer
			config = {
				center = {
					{
						icon = "",
						icon_hl = "group",
						desc = "description",
						desc_hl = "group",
						key = "shortcut key in dashboard buffer not keymap !!",
						key_hl = "group",
						key_format = " [%s]", -- `%s` will be substituted with value of `key`
						action = "",
					},
				},
				footer = {},
			},
		})
	end,
}
