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
vim.keymap.set("n", "<leader>P", '"+P')
vim.keymap.set("n", "<leader>Y", '"+Y') -- end of sentence

vim.keymap.set("n", "<leader>bp", ':bprev<CR>')
vim.keymap.set("n", "<leader>bn", ':bnext<CR>')
vim.keymap.set("v", "<leader>bp", ':bprev<CR>')
vim.keymap.set("v", "<leader>bn", ':bnext<CR>')
