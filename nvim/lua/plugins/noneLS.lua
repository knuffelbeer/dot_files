return {
	"nvimtools/none-ls.nvim",
	--  dependencies = {
	--    "nvimtools/none-ls-extras.nvim",
	--"gbprod/none-ls-shellcheck.nvim",
	--},
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				-- require("none-ls.diagnostics.eslint_d"),
				--require("none-ls.diagnostics.cpplint"),
				--    require("none-ls-shellcheck.diagnostics"),
				--    require("none-ls-shellcheck.code_actions"),
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettier,
				--null_ls.builtins.diagnostics.erb_lint,
				--null_ls.builtins.diagnostics.eslint_d,
				--null_ls.builtins.diagnostics.shellcheck,
				null_ls.builtins.formatting.black,
				null_ls.builtins.formatting.cmakelang,

				--null_ls.builtins.diagnostics.cmakelint,
				null_ls.builtins.formatting.isort,
				null_ls.builtins.formatting.shellharden,
				--null_ls.builtins.formatting.ast_grep,
				--null_ls.builtins.diagnostics.cpplint,
				--null_ls.builtins.diagnostics.vale,
			},
		})

		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
