
return {'lervag/vimtex',
ft = {"tex"},
config = function   ()
	-- code
	vim.cmd([[
syntax enable
filetype plugin indent on
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_method = 'mupdf'
let g:vimtex_compiler_method = 'lualatex'
let g:tex_flavor = 'latex'
let g:vimtex_quickfix_mode=0
let g:vimtex_matchparen_enabled = 0
]])
-- let g:vimtex_compiler_method = 'latexmk'
vim.keymap.set("n", "<localleader>tt", ":w<CR>:VimtexCompileSS<CR>")
vim.keymap.set("n", "<localleader>tv", ":VimtexView<CR>")
end

}
--let g:vimtex_compiler_latexmk_engines = {'_': 'latexrun'}
