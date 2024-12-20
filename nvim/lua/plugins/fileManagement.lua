return {
	{
		"prichrd/netrw.nvim",
		config = function()
			require("netrw").setup({
				-- File icons to use when `use_devicons` is false or if
				-- no icon is found for the given file type.
				icons = {
					symlink = "",
					directory = "",
					file = "",
				},
				-- Uses mini.icon or nvim-web-devicons if true, otherwise use the file icon specified above
				use_devicons = true,
				mappings = {
					-- Function mappings receive an object describing the node under the cursor
					["<CR>"] = function()
						local filename = vim.fn.expand("%:p:h") .. "/" .. vim.fn.expand("<cfile>")
						local file_extension = vim.fn.fnamemodify(filename, ":e")
						if file_extension == "pdf" or file_extension == "jpg" or file_extension == "png" then
							vim.cmd("silent :!okular " .. filename .. " &")
						elseif file_extension == "odt" or file_extension == "docx" or file_extension == "xlsx" then
							vim.cmd("silent :!libreoffice " .. filename .. " &")
						elseif file_extension == "" then
							vim.cmd("Lexplore " .. filename)
						else
							vim.cmd("edit " .. filename)
						end
					end,
					-- String mappings are executed as vim commands
					["<Leader>p"] = " :echo 'hello world'<CR>",
				},
			})
		end,
		lazy = false,
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		style = "borderless",
		-- or                              , branch = '0.1.x',
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

			vim.keymap.set("n", "<leader>fr", builtin.lsp_references, {})
			vim.keymap.set("n", "<leader>ds", builtin.lsp_document_symbols, {})
			vim.keymap.set("n", "<leader>ws", builtin.lsp_dynamic_workspace_symbols, {})
			local hl = function(name, opts)
				vim.api.nvim_set_hl(0, name, opts)
			end

			hl("TelescopeNormal", { bg = "none", fg = "#870000" })
			hl("TelescopePreviewNormal", { bg = "none", fg = "#5f6b64" })
			hl("TelescopeResultsNormal", { bg = "none", fg = "#5f6b64" })
			hl("TelescopeBorder", { bg = "#181825" })
			hl("TelescopePreviewBorder", { fg = "#870000", bg = "none" })
			hl("TelescopePromptBorder", { fg = "#870000", bg = "none" })
			hl("TelescopeResultsBorder", { fg = "#870000", bg = "none" })
			hl("TelescopeTitle", { fg = "#181825", bg = "#870000" })
			hl("TelescopePreviewTitle", { fg = "#181825", bg = "#870000" })
			hl("TelescopePromptNormal", { bg = "none", fg = "#5f6b64" })
			hl("TelescopePromptTitle", { fg = "#181825", bg = "#870000" })
			hl("TelescopePromptCounter", { fg = "#870000", bg = "none" })
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			-- This is your opts table
			local sorters = require("telescope.sorters")

			local function selectFile()
				local selection = require("telescope.actions.state").get_selected_entry()
				if selection and selection.value then
					local file_path = selection.value
					local file_extension = vim.fn.fnamemodify(file_path, ":e"):lower()
					if file_extension == "pdf" or file_extension == "jpg" or file_extension == "png" then
						os.execute("okular " .. file_path .. " &")
					elseif file_extension == "xlsx" or file_extension == "docx" or file_extension == "odt" then
						os.execute("libreoffice " .. file_path .. " &")
					else
						vim.cmd("edit! " .. file_path)
					end
				else
					print("No file selected or invalid selection.")
				end
			end

			require("telescope").setup({

				defaults = {
					mappings = {
						n = {
							["<C-o>"] = function()
								selectFile()
							end,
						},
						i = {
							["<C-0>"] = function()
								selectFile()
							end,
						},
					},
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			-- To get ui-select loaded and working with telescope, you need to call
			-- load_extension, somewhere after setup function:
			require("telescope").load_extension("ui-select")
		end,
	},

	{
		"ThePrimeagen/harpoon",
		config = function()
			vim.keymap.set("n", "<leader>mh", function()
				require("harpoon.ui").toggle_quick_menu()
			end)
			vim.keymap.set("n", "<leader>af", function()
				require("harpoon.mark").add_file()
			end)

			for x = 1, 9 do
				vim.keymap.set("n", "<leader>h" .. x, function()
					require("harpoon.ui").nav_file(x)
				end, { noremap = true })

				vim.keymap.set("n", "<leader>h0", function()
					require("harpoon.ui").nav_file(10)
				end, { noremap = true })
			end
		end,
	},
}
