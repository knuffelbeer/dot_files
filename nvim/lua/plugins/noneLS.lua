--return
--{
--	"nvimtools/none-ls.nvim",
--	lazy = false,
--	config = function()
--		local null_ls = require("null-ls")
--
--		null_ls.setup({
--		    sources = {
--			null_ls.builtins.formatting.stylua,
--			null_ls.builtins.formatting.black,
--			null_ls.builtins.formatting.isort,
--			null_ls.builtins.diagnostics.eslint_d,
--			null_ls.builtins.diagnostics.mypy,
--			null_ls.builtins.formatting.ast_grep,
--			null_ls.builtins.diagnostics.cpplint,
--			--null_ls.builtins.diagnostics.tsserver,
--			null_ls.builtins.formatting.prettier,
--
--			--null_ls.builtins.completion.spell,
--		    },
--		})
--		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format)
--		  on_attach = function(client, bufnr)
--		    if client.supports_method("textDocument/formatting") then
--		      vim.api.nvim_clear_autocmds({
--			group = augroup,
--			buffer = bufnr,
--		      })
--		      vim.api.nvim_create_autocmd("BufWritePre", {
--			group = augroup,
--			buffer = bufnr,
--			callback = function()
--			  vim.lsp.buf.format({ bufnr = bufnr })
--			end,
--		      })
--		    end
--		  end
--	end
--}
return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettier,
				--null_ls.builtins.diagnostics.erb_lint,
				null_ls.builtins.diagnostics.eslint_d,
				null_ls.builtins.diagnostics.shellcheck,
				null_ls.builtins.formatting.black,
				null_ls.builtins.formatting.isort,
				null_ls.builtins.formatting.shellharden,
				--null_ls.builtins.formatting.ast_grep,
				null_ls.builtins.diagnostics.cpplint,
			},
		})

		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
