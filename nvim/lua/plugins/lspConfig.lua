--return {
--
--
--	{
--		"williamboman/mason.nvim",
--		config = function()
--			require("mason").setup({
--				ui = {
--					icons = {
--						package_installed = "✓",
--						package_pending = "➜",
--						package_uninstalled = "✗",
--					},
--				},
--			})
--		end,
--    opts = {
--      ensure_installed = {
--        "black",
--        "mypy",
--        "ruff",
--        "pyright",
--      },
--    },
--	},
--
--	{
--		"williamboman/mason-lspconfig.nvim",
--		config = function()
--			require("mason-lspconfig").setup({ ensure_installed = { "lua_ls", "tsserver", "clangd"} })
--		end,
--	
--	},
--	{
--		"neovim/nvim-lspconfig",
--		config = function()
--
--			local capabilities = require("cmp_nvim_lsp").default_capabilities()
--			require("lspconfig").lua_ls.setup({capabilities=capabilities})
--			require("lspconfig").pyright.setup({capabilities=capabilities})
--			require("lspconfig").tsserver.setup({capabilities=capabilities})
--			require("lspconfig").ast_grep.setup({capabilities=capabilities})
--			vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
--			vim.keymap.set("n", "gd", vim.lsp.buf.definition)
--			vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action)
--		end,
--	},
--
--	{
--		"nvim-telescope/telescope-ui-select.nvim",
--		config = function()
--			local lspconfig = require("lspconfig")
----			lspconfig.pyright.setup({})
----			lspconfig.lua_ls.setup({})
----			lspconfig.tsserver.setup({})
----			lspconfig.ast_grep.setup({})
--			--lspconfig.eslint_d.setup({})
--			-- This is your opts table
--			require("telescope").setup({
--				extensions = {
--					["ui-select"] = {
--						require("telescope.themes").get_dropdown({
--							-- even more opts
--						}),
--
--						-- pseudo code / specification for writing custom displays, like the one
--						-- for "codeactions"
--						-- specific_opts = {
--						--   [kind] = {
--						--     make_indexed = function(items) -> indexed_items, width,
--						--     make_displayer = function(widths) -> displayer
--						--     make_display = function(displayer) -> function(e)
--						--     make_ordinal = function(e) -> string
--						--   },
--						--   -- for example to disable the custom builtin "codeactions" display
--						--      do the following
--						--   codeactions = false,
--						-- }
--					},
--				},
--			})
--			-- To get ui-select loaded and working with telescope, you need to call
--			-- load_extension, somewhere after setup function:
--			require("telescope").load_extension("ui-select")
--		end,
--	},
--}
return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup({ensure_installed = { "eslint_d", "erb_lint"}})
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    config = function ()
	require("mason-lspconfig").setup({ ensure_installed = { "lua_ls", "tsserver", "clangd", "html"} })
    end,
    opts = {
      auto_install = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      local lspconfig = require("lspconfig")
      lspconfig.tsserver.setup({
        capabilities = capabilities
      })
      lspconfig.html.setup({
        capabilities = capabilities
      })
      lspconfig.lua_ls.setup({
        capabilities = capabilities
      })

      lspconfig.clangd.setup({
        capabilities = capabilities
      })

      lspconfig.bashls.setup({
        capabilities = capabilities
      })


      lspconfig.pyright.setup({
        capabilities = capabilities
      })
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
    end,
  },
}
