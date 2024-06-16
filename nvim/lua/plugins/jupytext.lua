return {
	"goerz/jupytext.vim",

	config = function()
		vim.cmd([[
let g:jupytext_enable = 1
let g:jupytext_command = 'jupytext'
let g:jupytext_fmt = 'py']])

	end,
}
