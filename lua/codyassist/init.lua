local setup = require("codyassist.setup")
local commands = require("codyassist.commands")
local helpers = require("codyassist.helpers.helpers")
local repohelpers = require("codyassist.helpers.repo")
local constants = require("codyassist.constants")
local windowid = nil
local bufid = 0

local M = {}

function M.setup()
	repohelpers._LoadRepoFromFile()
	vim.api.nvim_create_user_command("CodyAssist", function(opts)
		M.QuestionWithSelection(opts)
	end, { nargs = "*", range = true })
	vim.api.nvim_create_user_command("CodyQuestion", function(opts)
		M.Question(opts)
	end, { nargs = "*", range = false })
	vim.api.nvim_create_user_command("CodyRepo", function(opts)
		repohelpers._Repo(opts)
	end, { nargs = "?" })
	vim.api.nvim_create_user_command("CodyRepoEnable", function()
		repohelpers._EnableRepo()
	end, { nargs = 0 })
	vim.api.nvim_create_user_command("CodyRepoDisable", function()
		repohelpers._DisableRepo()
	end, { nargs = 0 })
	vim.api.nvim_create_user_command("CodyToggleWin", function()
		M.ToggleChatWindow()
	end, { nargs = 0 })
	setup.setup()
end

function M.QuestionWithSelection(opts, selection)
	if opts.args == "" then
		print("Invalid input. Need a question")
		return
	end

	selection = selection or helpers._GetVisualSelection()
	windowid, bufid = commands.ChatQuestion(opts.args, selection)
end

function M.Question(opts)
	if opts.args == "" then
		print("Invalid input. Need a question")
		return
	end

	local selection = {}
	windowid, bufid = commands.ChatQuestion(opts.args, selection)
end

function M.ToggleChatWindow()
	if windowid and vim.api.nvim_win_is_valid(windowid) then
		vim.api.nvim_win_hide(windowid)
		windowid = nil
	else
		windowid = vim.api.nvim_open_win(bufid, true, constants.WINDOW_OPTS)
	end
end

function M.EnableRepo()
	repohelpers._EnableRepo()
end

function M.DisableRepo()
	repohelpers._DisableRepo()
end

return M
