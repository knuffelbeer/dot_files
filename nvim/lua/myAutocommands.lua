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
		date = string.sub(date, 1, 4) .. "-" .. string.sub(date, 5, 6) .. "-" .. string.sub(date, 7, #date)
		local title = table.file
		local tex_idx = #title - 3
		title = string.sub(table.file, 1, tex_idx - 1)
		title = string.gsub(title, "_", " ")

		text_to_insert[3] = "\\date{" .. date .. "}"
		text_to_insert[4] = "\\title{" .. title .. "}"
		vim.fn.append(0, text_to_insert)
		vim.api.nvim_win_set_cursor(0, { 9, 0 })

		vim.cmd([[startinsert]])
		vim.cmd([[set spell]])
	end,
	group = group,
	pattern = "*.tex",
})

local text_to_insert_2 = {
	"import numpy as np",
	"import torch",
	"import pandas as pd",
	"import matplotlib.pyplot as plt",
	"",
	'if __name__ == "__main__":',
	"  ",
}

vim.api.nvim_create_autocmd("BufNewFile", {
	callback = function(table)
		vim.fn.append(0, text_to_insert_2)
		vim.fn.append(0, "# " .. table.file .. " created by Beer Meester 13171429")
		vim.api.nvim_win_set_cursor(0, { 8, 1 })
		vim.cmd([[startinsert]])
	end,
	group = group,
	pattern = "*.py",
})

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	desc = "Briefly highlight yanked text",
})

--vim.api.nvim_create_autocmd("TermEnter", {
--
--	callback = function()
--		io.open("mamba activate pynvim")
--	end,
--	pattern = "*.py",
--})

vim.api.nvim_create_autocmd({ "BufRead" }, {
	group = vim.api.nvim_create_augroup("cpp", { clear = true }),
	pattern = { "*.cpp", "*.C" },
	callback = function(table)
		local extenstion = string.sub(table.file, #table.file - 3, #table.file)
		local bin_file = nil
		if extenstion == ".cpp" then
			bin_file = string.sub(table.file, 1, #table.file - 4)
		else
			bin_file = string.sub(table.file, 1, #table.file - 2)
		end
		vim.keymap.set("n", "<leader>cp", function()
			vim.cmd(":w")
			require("toggleterm").exec("g++ -pedantic -Wall -Werror -g -O0 " .. table.file .. " && ./a.out")
		end, { noremap = true, silent = true })
	end,
})

vim.api.nvim_create_autocmd("TermClose", {
	group = vim.api.nvim_create_augroup("DeleteLastLineTermClose", { clear = true }),
	pattern = { "*" },
	callback = function(ev)
		local delete_line_timer = vim.fn.timer_start(
			100,
			function(t) ---@diagnostic disable-line: redundant-parameter
				local process_exited_line = vim.fn.search("\\[process exited \\d\\]", "bn")
				if process_exited_line > 0 then
					vim.api.nvim_set_option_value("modifiable", true, { buf = ev.buf })
					vim.api.nvim_buf_set_lines(ev.buf, process_exited_line - 1, process_exited_line, true, { "" })
					vim.api.nvim_set_option_value("modifiable", false, { buf = ev.buf })
					vim.fn.timer_stop(t)
				end
			end,
			{ ["repeat"] = -1 } -- repeat indefinitely but will be cancelled after 3 seconds
		)

		-- give at most 3 seconds of an attempt to delete the line
		vim.defer_fn(function()
			vim.fn.timer_stop(delete_line_timer)
		end, 3000)
	end,
})
