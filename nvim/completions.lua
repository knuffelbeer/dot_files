return {
	{

		"L3MON4D3/LuaSnip",
		event = "VeryLazy",
		-- follow latest release.
		-- require("luasnip.loaders.from_vscode").lazy_load(),
		config = function()
			auto_snippets = true
		end,
		version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		--build = "make install_jsregexp",
		dependencies = { "saadparwaiz1/cmp_luasnip", "rafamadriz/friendly-snippets" },
	},

	{ "saadparwaiz1/cmp_luasnip" },
	{
		"hrsh7th/cmp-nvim-lsp",
		config = function()
			require("cmp").setup({
				sources = {
					{ name = "nvim_lsp" },
					{ name = "otter" },
				},
			})

			-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- An example for configuring `clangd` LSP to use nvim-cmp as a completion engine
			require("lspconfig").clangd.setup({
				capabilities = capabilities,
			})
			require("lspconfig").tsserver.setup({
				capabilities = capabilities,
			})
			require("lspconfig").pyright.setup({
				capabilities = capabilities,
			})
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			require("luasnip.loaders.from_snipmate").load()
			--require("luasnip.loaders.from_lua").load({paths="~/friendly-snippets"})
			cmp.setup({
				snippet = {
					-- REQUIRED - you must specify a snippet engine
					expand = function(args)
						require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
						-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
						-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					-- { name = 'vsnip' }, -- For vsnip users.
					{ name = "luasnip" }, -- For luasnip users.
					-- { name = 'ultisnips' }, -- For ultisnips users.
					-- { name = 'snippy' }, -- For snippy users.
				}),
			})
		end,
	},
}
