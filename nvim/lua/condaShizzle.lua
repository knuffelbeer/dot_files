local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values

local function extractFilePaths(text)
	local paths = {}
	for line in text:gmatch("[^\r\n]+") do
		local path = line:match("%s+(.*)$") -- Extract the path part
		if path then
			table.insert(paths, path)
		end
	end
	return paths
end

local function getCondaEnv()
	local handle = io.popen("conda env list")
	if handle == nil then
		print("Error opening conda env list")
	end
	local result = handle:read("*a")
	handle:close()
	local result = extractFilePaths(result)
	table.remove(result, 1)
	return result
end
local selectConda = function(opts)
	opts = opts or {}
	pickers
		.new(opts, {
			prompt_title = "colors",
			finder = finders.new_table({
				results = getCondaEnv(),
			}),
			sorter = conf.generic_sorter(opts),
			attach_mappings = function(prompt_bufnr, map)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)
					local selection = action_state.get_selected_entry()
					print(selection[1])
					require("toggleterm").exec("conda activate " .. selection[1])
					vim.g.python3_host_prog = selection[1] .. "/bin/python"
					--vim.api.nvim_put({ selection[1] }, "", false, true)
				end)
				return true
			end,
		})
		:find()
end

vim.keymap.set("n", "<leader>cc", function()
	selectConda()
end)
