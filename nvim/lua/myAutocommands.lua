local function slice(array, start_idx, end_idx)
	local new_array = {}
	for i = start_idx, end_idx, 1 do
		new_array[#new_array + 1] = array[i]
	end
	return new_array
end
local group = vim.api.nvim_create_augroup("Autowrite", { clear = true })
local text_to_insert = {
	"\\documentclass{article}",
	"\\usepackage{graphicx} % Required for inserting images",
	"\\title{}",
	"",
	"\\author{Beer Meester}",
	"\\begin{document}",
	"\\maketitle",
	"\\section{Introduction}",
	"",
	"\\end{document}",
}

vim.api.nvim_create_autocmd("BufNewFile", {
	callback = function(table)
		-- code
		local date = os.date("%Y%m%d")
		date = string.sub(date, 1, 4) .. "-" .. string.sub(date,5, 6) .. "-" .. string.sub(date, 7, #date)
		local title = table.file
		local tex_idx = #title - 3
		title = string.sub(table.file, 1, tex_idx - 1)
		title = string.gsub(title, "_", " ")

		text_to_insert[3] = "\\date{" .. date .. "}"
		text_to_insert[4] = "\\title{" .. title .. "}"
		vim.fn.append(0, text_to_insert)
		vim.api.nvim_win_set_cursor(0, {9, 0})

		vim.cmd([[startinsert]])
		vim.cmd([[set spell]])
	end,
	group = group,
	pattern = "*.tex",
})
local text_to_insert_2 = {"import numpy as np",
"import torch", "import pandas as pd", "import matplotlib.pyplot as plt", "", 'if __name__ == "__main__":', "	"}
vim.api.nvim_create_autocmd("BufNewFile", {
	callback = function()

		vim.fn.append(0, text_to_insert_2)
		vim.api.nvim_win_set_cursor(0, {7, 1})
		vim.cmd([[startinsert]])
	end,
	group = group,
	pattern = "*.py",
})
