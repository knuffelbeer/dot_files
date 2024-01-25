local envs = require("conda.envs")
local lsps_utils = require("conda.lsps.utils")
local utils = require("conda.utils")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
--local condaUtils = require("conda.utils")
--local function extractFilePaths(text)
--	local paths = {}
--	for line in text:gmatch("[^\r\n]+") do
--		local path = line:match("%s+(.*)$") -- Extract the path part
--		if path then
--			table.insert(paths, path)
--		end
--	end
--	return paths
--end
--local function getCondaEnvs2()
--	local shell_output = {}
--	local conda_envs = {}
--	Job:new({
--		command = "conda",
--		args = { "env", "list" },
--		on_stdout = function(_, stdout)
--			table.insert(shell_output, stdout)
--		end,
--		on_exit = function()
--			local _conda_envs = find.table_regex_match({}, shell_output, "[\\/]envs[\\/](.*)")
--			table.insert(conda_envs, "base")
--			for _, env in ipairs(_conda_envs) do
--				table.insert(conda_envs, env)
--			end
--		end,
--	}):start()
--	return conda_envs
--end

--print(table.concat(getCondaEnvs2(), "\n"))
local function getCondaEnv()
	local handle = io.popen("conda env list")
	if handle == nil then
		print("Error opening conda env list")
	end
	local result = handle:read("*a")
	handle:close()
	local result = extractFilePaths(result)
	table.remove(result, 1)
	print(result)
	return result
end

local selectConda = function(opts, resultsinos)
	opts = opts or {}
	pickers
		.new(opts, {
			prompt_title = "Conda Environments",
			finder = finders.new_table({
				--results = getCondaEnv(),
				results = resultsinos or { "MLSD", "pynvim", "base" },
				--results = condaUtils.get_conda_environments(),
			}),
			sorter = conf.generic_sorter(opts),
			attach_mappings = function(prompt_bufnr, map)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)
					local selection = action_state.get_selected_entry()
					require("toggleterm").exec("conda activate " .. selection[1])
					vim.g.python3_host_prog = selection[1] .. "/bin/python"
					--local capabilities = require("cmp_nvim_lsp").default_capabilities()

					local lspconfig = require("lspconfig")
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
		local is_set = false
		if not is_set then
			local resultsinos = utils.get_conda_environments()
			vim.keymap.set("n", "<leader>cc", function()
				selectConda({}, resultsinos)
			end)
			is_set = true
		end
	end,
})
