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
vim.keymap.set("v", "<leader>P", '"+P')
vim.keymap.set("n", "<leader>Y", '"+Y') -- end of sentence

vim.keymap.set("n", "<leader>bp", ":bprev<CR>")
vim.keymap.set("n", "<leader>bn", ":bnext<CR>")
vim.keymap.set("v", "<leader>bp", ":bprev<CR>")
vim.keymap.set("v", "<leader>bn", ":bnext<CR>")
-- vim.keymap.set("v", "<leader>pv", ':Oil<CR>')
-- vim.keymap.set("n", "<leader>pv", ':Oil<CR>')
vim.keymap.set("n", "<leader>hh", function()
	print("hoi")
end)

-- vim.keymap.set('n', '<leader>hf', function()
--   local filename = vim.fn.expand('%:t')
--   vim.notify("File: " .. (filename ~= "" and filename or "[No file]"))
-- end, { desc = 'Show filename' })

local function show_filename_centered()
	local buf = vim.api.nvim_create_buf(false, true) -- scratch buffer

	local full_path = vim.fn.expand("%:p:h")        -- Get full path
	local filename = vim.fn.expand("%:t")           -- Get filename
	if filename == "" then
		filename = "[No file]"
	end
	if full_path == "" then
		full_path = "[No path]"
	end

	-- Ensure that both lines are correctly set
	-- 				--               
	--
	-- 				component_separators = { left = " ", right = " " },
	local lines = { " " .. filename .. " ", " ", " " .. full_path .. " " }

	-- Set the lines in the buffer
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

	-- Get editor size
	local width = vim.o.columns
	local height = vim.o.lines

	-- Set window size based on content
	local win_width = math.max(20, #lines[3] + 4)
	local win_height = #lines -- Number of lines

	-- Set window options
	local opts = {
		style = "minimal",
		relative = "editor",
		width = win_width,
		height = win_height,
		row = math.floor((height - win_height) / 2),
		col = math.floor((width - win_width) / 2),
		border = "rounded",
	}

	-- Open the window
	local win = vim.api.nvim_open_win(buf, true, opts)

	-- Close the window with <Esc>
	vim.keymap.set("n", "<Esc>", function()
		if vim.api.nvim_win_is_valid(win) then
			vim.api.nvim_win_close(win, true)
		end
	end, { buffer = buf, nowait = true, silent = true })
end
vim.keymap.set("n", "<leader>hf", show_filename_centered, { desc = "Show filename in center" })
vim.keymap.set("n", "<M-j>", ":cnext<CR>")
vim.keymap.set("n", "<M-k>", ":cprev<CR>")
vim.keymap.set("n", "/", "ms/")
vim.keymap.set("n", "gp", "`[v`]")
vim.keymap.set("n", "H", function()
	local old_scrollof = vim.o.scrolloff
	vim.o.scrolloff = 0
	vim.cmd('norm! H')
	vim.o.scrolloff = old_scrollof
end)
vim.keymap.set("n", "L", function()
	local old_scrollof = vim.o.scrolloff
	vim.o.scrolloff = 0
	vim.cmd('norm! L')
	vim.o.scrolloff = old_scrollof
end)
