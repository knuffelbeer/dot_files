
--package.path = package.path .. "/home/knuffelbeer/.luarocks/lib/luarocks/rocks-5.1/?lua"
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
require("netrw")
require("lazy").setup("plugins")
require("mappings")
require("myAutocommands")
