return {
	{
		"jay-babu/mason-nvim-dap.nvim",
		event = "VeryLazy",
		ensure_installed = {"debugpy"},
		dependencies = {
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap",
		},
		opts = {
			handlers = {},
		},
	},
	{
		"mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")
			dap.adapters.gdb = {
				type = "executable",
				command = "gdb",
				args = { "-i", "dap" },
			}
			dap.configurations.c = {
				{
					name = "Launch",
					type = "gdb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopAtBeginningOfMainSubprogram = false,
				},
			}
			dap.configurations.cpp = dap.configurations.c
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		event = "VeryLazy",
		dependencies = { "nvim-neotest/nvim-nio", "mfussenegger/nvim-dap" },
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup()
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
			vim.keymap.set("n", "<leader>nn", function()
				require("dap").continue()
			end)
			vim.keymap.set("n", "<leader>tb", function()
				require("dap").toggle_breakpoint()
			end)
			vim.keymap.set("n", "<leader>si", function()
				require("dap").step_into()
			end)
			vim.keymap.set("n", "<leader>so", function()
				require("dap").step_over()
			end)
			vim.keymap.set("n", "<leader>dc", function()
				require("dapui").close()
				require("dap").close()
			end)
		end,
	},
}
