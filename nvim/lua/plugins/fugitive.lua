return {
	"tpope/vim-fugitive",
	config = function()
		local api = vim.api
		local function git_commit_and_push()
			-- Prompt for commit message
			local commit_message = vim.fn.input("Enter commit message: ")

			-- Check if a commit message was provided
			if commit_message == "" then
				api.nvim_err_writeln("Commit message cannot be empty.")
				return
			end

			-- Stage all changes
			vim.fn.execute("Git add .")

			-- Commit changes with the provided message
			local commit_command = string.format('Git commit -m "%s"', commit_message)
			vim.fn.execute(commit_command)

			-- Push changes to the remote repository
			local push_command = "Git push"
			vim.fn.execute(push_command)

			api.nvim_out_write("Changes committed and pushed successfully.\n")
		end

		local function commit_input()
			-- Prompt for commit message
			local commit_message = vim.fn.input("Enter commit message: ")

			-- Check if a commit message was provided
			if commit_message == "" then
				api.nvim_err_writeln("Commit message cannot be empty.")
				return
			end

			-- Commit changes with the provided message
			local commit_command = string.format('Git commit -m "%s"', commit_message)
			vim.fn.execute(commit_command)
			api.nvim_out_write("commited changes")
		end

		vim.api.nvim_create_user_command("GitCommitAndPush", git_commit_and_push, { nargs = 0 })

		-- Mapping to call the function
		vim.api.nvim_set_keymap("n", "<Leader>gg", ":GitCommitAndPush<CR>", { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>ga", ":Git add .<CR>", { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>gc", function()
			commit_input()
		end, { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>gp", ":Git push<CR>", { noremap = true, silent = true })
	end,
}
