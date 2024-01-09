return {

"jalvesaq/Nvim-R",
--lazy = false,
ft = { "r", "rmd" },
config = function()
	vim.cmd([[let R_notmuxconf = 1]])
end
}
