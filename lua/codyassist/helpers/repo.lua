local M = {}
local Path = require("plenary.path")
local repo = ""
local repoenabled = false
local codyrepostoredfile = "/codyassist_repo.txt"

function M._SaveRepoToFile()
	local repo_file = Path:new(vim.fn.stdpath("config") .. codyrepostoredfile)
	repo_file:write(repo, "w")
end

function M._LoadRepoFromFile()
	local repo_file = Path:new(vim.fn.stdpath("config") .. codyrepostoredfile)
	if repo_file:exists() then
		repo = repo_file:read()
	end
end

function M._Repo(opts)
	if opts.args ~= "" then
		repo = opts.args
		M._SaveRepoToFile()
	else
		print(repo)
	end
end

function M._GetRepo()
	if repoenabled then
		return repo
	else
		return ""
	end
end

function M._EnableRepo()
	repoenabled = true
end

function M._DisableRepo()
	repoenabled = false
end

return M
