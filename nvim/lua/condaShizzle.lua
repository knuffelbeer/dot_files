local envs = require("conda.envs")
local lsps_utils = require("conda.lsps.utils")
local utils = require("conda.utils")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values

-- My own way, little slower, but always works
--local function getCondaEnv()
--	local handle = io.popen("conda env list")
--	if handle == nil then
--		print("Error opening conda env list")
--	end
--	local result = handle:read("*a")
--	handle:close()
--	local result = extractFilePaths(result)
--	table.remove(result, 1)
--	print(result)
--	return result
--end

local selectConda = function(opts, resultsinos)
	opts = opts or {}
	pickers
		.new(opts, {
			prompt_title = "Conda Environments",
			finder = finders.new_table({
				results = resultsinos or { "MLSD", "pynvim", "base" },
			}),
			sorter = conf.generic_sorter(opts),
			attach_mappings = function(prompt_bufnr, map)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)
					local selection = action_state.get_selected_entry()
					require("toggleterm").exec("conda activate " .. selection[1])
					vim.g.python3_host_prog = selection[1] .. "/bin/python"
					envs.activate(selection[1])
					lsps_utils.restart_lsps()
				end)
				return true
			end,
		})
		:find()
end

vim.api.nvim_create_autocmd({ "FileType" }, {
	group = vim.api.nvim_create_augroup("Conda", { clear = true }),
	pattern = { "python" },
	callback = function()
		local resultsinos = utils.get_conda_environments()
		vim.keymap.set("n", "<leader>cc", function()
			selectConda({}, resultsinos)
		end)
	end,
})
