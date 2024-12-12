local M = {}
local constants = require("codyassist.constants")
local repohelpers = require("codyassist.helpers.repo")

--- Function to list changelists and allow selection
---@param question string the question asked from user
---@param textselection table the text selected by the user to use as context
---@return integer win the window id of the newly created window
---@return integer newbuf the buffer id of the newly created window
function M.ChatQuestion(question, textselection)
	local bufnr = vim.api.nvim_get_current_buf()
	local filePath = vim.api.nvim_buf_get_name(bufnr)
	-- Create a new buffer and window for displaying the prompt and the answer
	local newbuf = vim.api.nvim_create_buf(false, true)
	local stdin_input
	if textselection ~= {} then
		stdin_input = table.concat(textselection, "\n")
	else
		stdin_input = ""
	end
	if question ~= "" then
		table.insert(textselection, 1, "")
		table.insert(textselection, 1, question)
	end
	vim.api.nvim_buf_set_lines(newbuf, 0, -1, false, textselection)

	local win = vim.api.nvim_open_win(newbuf, true, constants.WINDOW_OPTS)
	vim.api.nvim_set_option_value("filetype", "markdown", { buf = newbuf })
	-- Run the command asynchronously
	local function on_stdout(_, data, _)
		if data then
			local line_count = vim.api.nvim_buf_line_count(newbuf)
			-- Filter out any nil or empty lines
			local filtered_data = vim.tbl_filter(function(line)
				return line ~= nil and line ~= ""
			end, data)
			vim.api.nvim_buf_set_lines(newbuf, line_count, line_count, false, filtered_data)
		end
	end

	local cmd
	if question == "" then
		cmd = constants.CODY_CHAT_COMMAND .. stdin_input
	elseif stdin_input == "" then
		cmd = constants.CODY_CHAT_COMMAND .. question
	else
		cmd = "echo "
			.. vim.fn.shellescape(stdin_input)
			.. " | "
			.. constants.CODY_CHAT_COMMAND_STDIN
			.. vim.fn.shellescape(question)
	end
	cmd = cmd .. constants.CONTEXT_FILE_ARG .. filePath
	local repo = repohelpers._GetRepo()
	if repo ~= "" then
		cmd = cmd .. constants.CONTEXT_REPO_ARG .. repo
	end
	vim.fn.jobstart(cmd, {
		stdout_buffered = true,
		on_stdout = on_stdout,
		on_stderr = on_stdout,
	})
	return win, newbuf
end

return M
