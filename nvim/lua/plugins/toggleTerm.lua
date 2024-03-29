return {
	-- amongst your other plugins
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		lazy = false,
		config = function()
			require("toggleterm").setup({
				open_mapping = [[<c-t>]],
	start_in_insert = true,
	direction = 'horizontal',
--				highlights = {
--								-- highlights which map to a highlight group name and a table of it's values
--						-- NOTE: this is only a subset of values, any group placed here will be set for the terminal window split
--						--	    FloatBorder = {
--					--	      guifg = "#870000",
--					--	      guibg = "#870000",
--					--	    },
--				},
			})
function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
--vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
--		end,
end
	}
	-- or

}

