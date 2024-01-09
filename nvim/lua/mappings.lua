-- Telescope Keybindings
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

--XPLR keybndings
--vim.keymap.set("n", "<leader>pv", ":Xplr<CR>")
vim.keymap.set("n", "<leader>pv", ":Ex<CR>")

-- Delete
vim.keymap.set("v", "<leader>d", '"_d')
vim.keymap.set("n", "<leader>d", '"_d')
vim.keymap.set("v", "<leader>d", '"_d')
vim.keymap.set("n", "<leader>x", '"_x')
vim.keymap.set("n", "<leader>c", '"_c')
vim.keymap.set("v", "<leader>c", '"_c')

vim.keymap.set("n", "<C-s>", ":wq<CR>")

for x = 1, 9 do
	vim.keymap.set("n", "<leader>f" .. x, function()
		require("harpoon.ui").nav_file(x)
	end, { noremap = true })
end


vim.keymap.set("n", "<leader>nc", ' 0 o```{python} \n \n``` <esc>')
