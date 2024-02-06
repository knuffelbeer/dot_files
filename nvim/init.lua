
--none-package.path = package.path .. "/home/knuffelbeer/.luarocks/lib/luarocks/rocks-5.1/?lua"

--package.cpath = package.cpath .. ';/home/knuffelbeer/.luarocks/lib/luarocks/rocks-5.1/?.so'
--require("magick")
vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct
vim.keymap.set("n", "\\", ",", {noremap=true})
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

vim.cmd([[set clipboard+=unnamedplus
	  set number
]])
vim.g.python3_host_prog='/home/knuffelbeer/.conda/envs/pynvim/bin/python'
require("netrw")
require("lazy").setup("plugins")
require("mappings")
require("myAutocommands")
require("condaShizzle")
-- Make stuff transparent
 vim.api.nvim_set_hl(0, "Normal", {  bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", {fg ="#8f938d", bg = "none" })
vim.api.nvim_set_hl(0, "FloatBorder", {fg="#870000", bg = "none" })
vim.api.nvim_set_hl(0, "FloatTitle", {fg="#000000", bg = "#870000" })
