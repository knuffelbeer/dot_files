return {
	"goerz/jupytext.vim",

	config = function()
		vim.cmd([[
let g:jupytext_enable = 1
let g:jupytext_command = 'jupytext'
let g:jupytext_fmt = 'py']])

	end,
	-- Depending on your nvim distro or config you may need to make the loading not lazy

	--lazy=false,
}
