return {
	-- {
	-- 	"zbirenbaum/copilot.lua",
	-- 	cmd = "Copilot",
	-- 	event = "InsertEnter",
	-- 	config = function()
	-- 		require("copilot").setup({
	-- 			panel = {
	-- 				enabled = true,
	-- 				auto_refresh = false,
	-- 				keymap = {
	-- 					jump_prev = "[[",
	-- 					jump_next = "]]",
	-- 					accept = "<TAB>",
	-- 					refresh = "gr",
	-- 					open = "<M-p>",
	-- 				},
	-- 			},
	-- 			suggestion = {
	-- 				enabled = true,
	-- 				auto_trigger = true,
	-- 				hide_during_completion = false,
	-- 				debounce = 75,
	-- 				keymap = {
	-- 					accept = "<M-CR>",
	-- 					accept_word = false,
	-- 					accept_line = false,
	-- 					next = "<M-]>",
	-- 					prev = "<M-[>",
	-- 					dismiss = "<C-]>",
	-- 				},
	-- 			},
	-- 		})
	-- 		--require("copilot.api")
	-- 	end,
	-- },
	-- {
	-- 	"yetone/avante.nvim",
	-- 	event = "VeryLazy",
	-- 	lazy = false,
	-- 	version = false, -- set this if you want to always pull the latest change
	-- 	opts = {
	-- 		-- add any opts here
	-- 		provider = "copilot",
	-- 		windows = {
	-- 			---@type "right" | "left" | "top" | "bottom"
	-- 			position = "right", -- the position of the sidebar
	-- 			wrap = true, -- similar to vim.o.wrap
	-- 			width = 50, -- default % based on available width
	-- 			sidebar_header = {
	-- 				enabled = true, -- true, false to enable/disable the header
	-- 				align = "center", -- left, center, right for title
	-- 				rounded = true,
	-- 			},
	-- 			input = {
	-- 				prefix = "> ",
	-- 				height = 8, -- Height of the input window in vertical layout
	-- 			},
	-- 			edit = {
	-- 				border = "rounded",
	-- 				start_insert = true, -- Start insert mode when opening the edit window
	-- 			},
	-- 			ask = {
	-- 				floating = false, -- Open the 'AvanteAsk' prompt in a floating window
	-- 				start_insert = true, -- Start insert mode when opening the ask window
	-- 				border = "rounded",
	-- 				---@type "ours" | "theirs"
	-- 				focus_on_apply = "theirs", -- which diff to focus after applying
	-- 			},
	-- 		},
	-- 	},
	-- 	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	-- 	build = "make",
	-- 	-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
	-- 	dependencies = {
	-- 		"nvim-treesitter/nvim-treesitter",
	-- 		"stevearc/dressing.nvim",
	-- 		"nvim-lua/plenary.nvim",
	-- 		"MunifTanjim/nui.nvim",
	-- 		--- The below dependencies are optional,
	-- 		"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
	-- 		"zbirenbaum/copilot.lua", -- for providers='copilot'
	-- 		{
	-- 			-- support for image pasting
	-- 			"HakonHarnes/img-clip.nvim",
	-- 			event = "VeryLazy",
	-- 			opts = {
	-- 				mappings = {
	-- 					ask = "<leader>aa", -- ask
	-- 					edit = "<leader>av", -- edit
	-- 					refresh = "<leader>ar", -- refresh
	-- 				},
	-- 				-- recommended settings
	-- 				default = {
	-- 					embed_image_as_base64 = false,
	-- 					prompt_for_file_name = false,
	-- 					drag_and_drop = {
	-- 						insert_mode = true,
	-- 					},
	-- 					-- required for Windows users
	-- 					use_absolute_path = true,
	-- 				},
	-- 			},
	-- 		},
	-- 		{
	-- 			-- Make sure to set this up properly if you have lazy=true
	-- 			"MeanderingProgrammer/render-markdown.nvim",
	-- 			opts = {
	-- 				file_types = { "markdown", "Avante" },
	-- 			},
	-- 			ft = { "markdown", "Avante" },
	-- 		},
	-- 	},
	-- },
	{
		"hrsh7th/cmp-nvim-lsp", },
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
		config = function()
			require("luasnip").config.set_config({
				history = true,
				enable_autosnippets = true,
			})
		end,
		keys = function()
			return {}
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		lazy = false,
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
		},
		config = function()
			-- Just to make avante fuck of on <leader>af
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			require("luasnip.loaders.from_vscode").lazy_load()
			--opts = function(_, opts)
			local has_words_before = function()
				unpack = unpack or table.unpack
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end
			cmp.setup({
				preselect = cmp.PreselectMode.Item,
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				window = {
					-- completion = cmp.config.window.bordered(),
					-- documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping(function(fallback) --<Tab>
						if cmp.visible() then
							cmp.select_next_item()
							-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
							-- they way you will only jump inside the snippet region
						elseif luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<C-p>"] = cmp.mapping(function(fallback) --<S-Tab>
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),

					["<C-y>"] = cmp.mapping(
						cmp.mapping.confirm({ behaviour = cmp.ConfirmBehavior.insert, select = true }),
						{ "i", "c" }
					),
					["<CR>"] = cmp.mapping.confirm({
						select = false --[[no autocomplete]],
					}),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "path" },
					{ name = "luasnip" }, -- For luasnip users.
					{ name = "buffer" },
				}),
			})
			local ls = require("luasnip")

			-- TODO: Think about `locally_jumpable`, etc.
			-- Might be nice to send PR to luasnip to use filters instead for these functions ;)

			vim.snippet.expand = ls.lsp_expand

			---@diagnostic disable-next-line: duplicate-set-field
			vim.snippet.active = function(filter)
				filter = filter or {}
				filter.direction = filter.direction or 1

				if filter.direction == 1 then
					return ls.expand_or_jumpable()
				else
					return ls.jumpable(filter.direction)
				end
			end

			---@diagnostic disable-next-line: duplicate-set-field
			vim.snippet.jump = function(direction)
				if direction == 1 then
					if ls.expandable() then
						return ls.expand_or_jump()
					else
						return ls.jumpable(1) and ls.jump(1)
					end
				else
					return ls.jumpable(-1) and ls.jump(-1)
				end
			end
			vim.snippet.stop = ls.unlink_current
			for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/snippets/*.lua", true)) do
				loadfile(ft_path)()
			end
			vim.keymap.set({ "i", "s" }, "<c-k>", function()
				return vim.snippet.active({ direction = 1 }) and vim.snippet.jump(1)
			end, { silent = true })

			vim.keymap.set({ "i", "s" }, "<c-j>", function()
				return vim.snippet.active({ direction = -1 }) and vim.snippet.jump(-1)
			end, { silent = true })
			vim.keymap.set({ "i", "s" }, "<c-h>", function()
				if ls.choice_active() then
					ls.change_choice(1)
				end
			end, { silent = true })
			vim.keymap.set({ "i", "s" }, "<c-l>", function()
				if ls.choice_active() then
					ls.change_choice(1)
				end
			end, { silent = true })
		end,
	},
	--{

	--	"windwp/nvim-ts-autotag",
	--	config = function()
	--		require("nvim-ts-autotag").setup()
	--	end,
	--},
}
--{
----					["<C-b>"] = cmp.mapping.scroll_docs(-4),
----					["<C-f>"] = cmp.mapping.scroll_docs(4),
----					["<C-Space>"] = cmp.mapping.complete(),
----					["<C-e>"] = cmp.mapping.abort(),
----					["<CR>"] = cmp.mapping.confirm({ select = true }),
--
--				    ["<Tab>"] = cmp.mapping(function(fallback)
--				      if cmp.visible() then
--					cmp.select_next_item()
--				      -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
--				      -- that way you will only jump inside the snippet region
--				      elseif luasnip.expand_or_jumpable() then
--					luasnip.expand_or_jump()
--				      elseif has_words_before() then
--					cmp.complete()
--				      else
--					fallback()
--				      end
--				    end, { "i", "s" }),
--
--				    ["<S-Tab>"] = cmp.mapping(function(fallback)
--				      if cmp.visible() then
--					cmp.select_prev_item()
--				      elseif luasnip.jumpable(-1) then
--					luasnip.jump(-1)
--				      else
--					fallback()
--				      end
--				    end, { "i", "s" }),
--
--				}
