
return {'lervag/vimtex',
ft = {"tex"},
config = function   ()
	-- code
	vim.cmd([[
syntax enable
filetype plugin indent on
let g:vimtex_view_method = 'mupdf'
let g:vimtex_compiler_method = 'latexmk'
let g:tex_flavor = 'latex'
let g:vimtex_quickfix_mode=0
let g:vimtex_matchparen_enabled = 0
]])
vim.keymap.set("n", "<localleader>tt", ":w<CR>:VimtexCompileSS<CR>")
vim.keymap.set("n", "<localleader>tv", ":VimtexView<CR>")
end

}
--let g:vimtex_compiler_latexmk_engines = {'_': 'latexrun'}
