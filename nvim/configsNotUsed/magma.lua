return {
	"dccsillag/magma-nvim",
	lazy = false,
	build = ":UpdateRemotePlugins",
	config = function()
		vim.cmd([[

		let g:magma_automatically_open_output = v:true
		let g:magma_image_provider = "ueberzug"
		]])
		vim.keymap.set("n", "<leader>mi", ":MagmaInit python3<CR>", { noremap = true, silent = true })
	--vim.keymap.set( "n", 	"<Leader>m",":MagmaEvaluateOperator<CR>")
	vim.keymap.set( "n", 	"<Leader>mm",":MagmaEvaluateLine<CR>")
	vim.keymap.set( "v",      "<Leader>mv",  ":<C-u>MagmaEvaluateVisual<CR>")
	vim.keymap.set( "n", 	"<Leader>mr",":MagmaReevaluateCell<CR>")
	vim.keymap.set( "n", 	"<Leader>md",":MagmaDelete<CR>")
	vim.keymap.set( "n", 	"<Leader>mo",":MagmaShowOutput<CR>")
	end,
}
