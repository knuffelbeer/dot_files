return {
	{

		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			--vim.cmd("colorscheme rose-pine")
			require("tokyonight").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
				light_style = "night", -- The theme is used when the background is set to light
				transparent = true, -- Enable this to disable setting the background color
				terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
				styles = {
					-- Style to be applied to different syntax groups
					-- Value is any valid attr-list value for `:help nvim_set_hl`
					comments = { italic = true },
					keywords = { italic = true },
					functions = {},
					variables = {},
					-- Background styles. Can be "dark", "transparent" or "normal"
					sidebars = "dark", -- style for sidebars, see below
					floats = "dark", -- style for floating windows
				},
				sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
				day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
				hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
				dim_inactive = false, -- dims inactive windows
				lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

				--- You can override specific color groups to use other groups or a hex color
				--- function will be called with a ColorScheme table
				---@param colors ColorScheme
				on_colors = function(colors) end,

				--- You can override specific highlights to use other groups or a hex color
				--- function will be called with a Highlights and ColorScheme table
				---@param highlights Highlights
				---@param colors ColorScheme
				on_highlights = function(highlights, colors) end,
			})
			vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
			vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
			vim.cmd.colorscheme("tokyonight")
		end,
	},

	-- {"rose-pine/neovim", name = "rose-pine"},
	-- {
	-- 	"catppuccin/nvim",
	-- 	name = "catppuccin",
	-- 	priority = 1000,
	-- 	opts = {
	-- 		transparent_background = true,
	-- 		integrations = {
	-- 			telescope = true,
	-- 			harpoon = true,
	-- 			mason = true,
	-- 			neotest = true,
	-- 		},
	-- 	},
	-- 	config = function(_, opts)
	-- 		require("catppuccin").setup(opts)
	-- 		vim.cmd.colorscheme("catppuccin-frappe")
	-- 	end,
	-- },
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local custom_theme = require("lualine.themes.horizon")
			local yellow = "#ffff00"
			local orange = "#ff6600"
			local red = "#870000"

			custom_theme.normal.a.bg = red
			custom_theme.visual.a.bg = "#be19e8"
			custom_theme.insert.a.bg = orange
			custom_theme.inactive.a.bg = "#ece74c"
			custom_theme.insert.a.fg = red
			custom_theme.visual.a.fg = red
			custom_theme.replace.a.fg = red
			custom_theme.normal.a.fg = orange

			custom_theme.inactive.b.bg = yellow
			custom_theme.visual.b.bg = yellow
			custom_theme.normal.b.bg = yellow
			custom_theme.insert.b.bg = yellow
			custom_theme.command.b.bg = yellow
			custom_theme.replace.b.bg = yellow

			custom_theme.inactive.b.fg = orange
			custom_theme.normal.b.fg = orange
			custom_theme.insert.b.fg = red
			custom_theme.visual.b.fg = red
			custom_theme.command.b.fg = red
			custom_theme.replace.b.fg = red

			custom_theme.visual.c.bg = "#0000000"
			custom_theme.normal.c.bg = "#0000000"
			custom_theme.insert.c.bg = "#0000000"
			custom_theme.command.c.bg = "#0000000"
			custom_theme.replace.c.bg = "#0000000"
			custom_theme.inactive.c.bg = red
			custom_theme.normal.c.fg = orange
			custom_theme.normal.c.fg = orange
			custom_theme.insert.c.fg = orange
			custom_theme.replace.c.fg = orange
			custom_theme.visual.c.fg = orange
			custom_theme.command.c.fg = orange
			custom_theme.inactive.c.fg = orange

			--custom_theme.command.a.bg = "#a56f12"
			--custom_theme.replace.a.bg = "#a56f12"
			-- yellow: "#ece74c"
			require("lualine").setup(require("lualine").setup({
				options = {
					icons_enabled = true,
					theme = custom_theme,
					component_separators = { left = " ", right = " " },
					-- Symbols
					--               
					section_separators = { left = " ", right = " " },
					disabled_filetypes = {
						statusline = {},
						winbar = {},
					},
					ignore_focus = {},
					always_divide_middle = true,
					globalstatus = false,
					refresh = {
						statusline = 1000,
						tabline = 1000,
						winbar = 1000,
					},
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch" },
					lualine_c = { "filename" },
					lualine_x = {},
					lualine_y = {},
					--lualine_z = { "fileformat" },
					lualine_z = { "filetype" },
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = {},
					lualine_x = {},
					lualine_y = {},
					lualine_z = {},
				},
				tabline = {},
				winbar = {},
				inactive_winbar = {},
				extensions = {},
			}))
			-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
			-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
		end,
	},
}
