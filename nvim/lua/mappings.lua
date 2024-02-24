-- Telescope Keybindings
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

--XPLR keybndings
--vim.keymap.set("n", "<leader>pv", ":Xplr<CR>")

-- Delete
vim.keymap.set("v", "<leader>d", '"_d')
vim.keymap.set("n", "<leader>d", '"_d')
vim.keymap.set("v", "<leader>d", '"_d')
vim.keymap.set("n", "<leader>x", '"_x')
vim.keymap.set("n", "<leader>c", '"_c')
vim.keymap.set("v", "<leader>c", '"_c')

--vim.keymap.set("n", "<C-s>", ":wq<CR>")

for x = 1, 9 do
	vim.keymap.set("n", "M-" .. x, function()
		require("harpoon.ui").nav_file(x)
	end, { noremap = true })
end

--vim.keymap.set("n", "<leader>nc", ' 0 o```{python} \n \n``` <esc>')
--vim.keymap.set("n", "<M-k>" ,"<C-w>k")
--vim.keymap.set("n", "<M-j>" ,"<C-w>j")
--vim.keymap.set("n", "<M-h>" ,"<C-w>h")
--vim.keymap.set("n", "<M-l>" ,"<C-w>l")
vim.keymap.set("n", "<leader>tc", function()
	require("dap").continue()
end)
vim.keymap.set("n", "<leader>so", function()
	require("dap").step_over()
end)
vim.keymap.set("n", "<leader>si", function()
	require("dap").step_into()
end)
vim.keymap.set("n", "<leader>su", function()
	require("dap").step_out()
end)
vim.keymap.set("n", "<Leader>tb", function()
	require("dap").toggle_breakpoint()
end)
vim.keymap.set("n", "<Leader>tB", function()
	require("dap").set_breakpoint()
end)
