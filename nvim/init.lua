-- beer 
package.path = "/home/knuffelbeer/.luarocks/share/lua/5.1/?.lua;" .. package.path
vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct
vim.keymap.set("n", "\\", ",", { noremap = true })
vim.g.maplocalleader = ","
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
vim.wo.relativenumber = true
vim.wo.number = true

-- vim.cmd([[set autochdir]])
-- vim.cmd([[set clipboard+=unnamedplus

-- Voor AlgorithmOfEverything venv, verander voor andere environment
vim.g.python3_host_prog = "/home/knuffelbeer/.python_venvs/B/bin/python3"
require("netrw")
require("lazy").setup("plugins")
require("mappings")
require("myAutocommands")
vim.opt.colorcolumn = "80"
-- Make stuff transparent
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { fg = "#8f938d", bg = "none" })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#870000", bg = "none" })
vim.api.nvim_set_hl(0, "FloatTitle", { fg = "#000000", bg = "#870000" })
vim.api.nvim_set_hl(0, "Visual", { bg = "#870000" })
vim.api.nvim_set_hl(0, "StatusLine", { fg = "#870000", bg = "none" })
vim.api.nvim_set_hl(0, "colorcolumn", { bg = "#870000" })
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.wrap = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.scrolloff = 8
vim.bo.shiftwidth = 2
vim.cmd("set tabstop=2")

