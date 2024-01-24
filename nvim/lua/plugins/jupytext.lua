return {
	"goerz/jupytext.vim",

	config = function()
local insert_jupyter_notebook = {
'{',
 '"cells": [',
  '{',
   '"cell_type": "code",',
   '"execution_count": null,',
   '"id": "768a4320-c306-499e-837b-19cce19958f9",',
   '"metadata": {},',
   '"outputs": [],',
   '"source": []',
  '}',
 '],',
 '"metadata": {',
  '"kernelspec": {',
   '"display_name": "Python 3 (ipykernel)",',
   '"language": "python",',
   '"name": "python3"',
  '},',
  '"language_info": {',
   '"codemirror_mode": {',
    '"name": "ipython",',
    '"version": 3',
   '},',
   '"file_extension": ".py",',
   '"mimetype": "text/x-python",',
   '"name": "python",',
   '"nbconvert_exporter": "python",',
   '"pygments_lexer": "ipython3",',
   '"version": "3.12.1"',
  '}',
 '},',
 '"nbformat": 4,',
 '"nbformat_minor": 5',
'}'}
vim.api.nvim_create_autocmd("BufNewFile", {
	callback = function()

		vim.fn.append(0, insert_jupyter_notebook)
	end,
	group = group,
	pattern = "*.ipynb",
})
		vim.cmd([[
let g:jupytext_enable = 1
let g:jupytext_command = 'jupytext'
let g:jupytext_fmt = 'py']])

	end,
	-- Depending on your nvim distro or config you may need to make the loading not lazy

	--lazy=false,
}
