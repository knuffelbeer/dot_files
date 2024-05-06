-- Telescope Keybindings
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

-- Delete
vim.keymap.set("v", "<leader>d", '"_d')
vim.keymap.set("n", "<leader>d", '"_d')
vim.keymap.set("v", "<leader>d", '"_d')
vim.keymap.set("n", "<leader>x", '"_x')
vim.keymap.set("n", "<leader>c", '"_c')
vim.keymap.set("v", "<leader>c", '"_c')

-- Copy to clipboard
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>p", '"+p')
vim.keymap.set("n", "<leader>p", '"+p')


for x = 1, 9 do
	vim.keymap.set("n", "M-" .. x, function()
		require("harpoon.ui").nav_file(x)
	end, { noremap = true })
end
