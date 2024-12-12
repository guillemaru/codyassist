local M = {}

M.CODY_CHAT_COMMAND_STDIN = "cody chat --stdin -m"
M.CODY_CHAT_COMMAND = "cody chat -m"
M.CONTEXT_FILE_ARG = " --context-file "
M.CONTEXT_REPO_ARG = " --context-repo "

-- Window constants
local ui = vim.api.nvim_list_uis()[1]
local screen_width = ui.width
local screen_height = ui.height
local width = math.floor(screen_width * 0.8)
local height = math.floor(screen_height * 0.8)
M.WINDOW_OPTS = {
	relative = "editor",
	width = width,
	height = height,
	col = (vim.o.columns - width) / 2,
	row = (vim.o.lines - height) / 2,
	style = "minimal",
	border = "single",
}

return M
