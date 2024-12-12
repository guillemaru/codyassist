local M = {}

---Captures what user has selected in Visual mode
---@return table result with the selected text lines
function M._GetVisualSelection()
	vim.cmd('normal! "vy')
	local start_pos = vim.fn.getpos("'<")
	local end_pos = vim.fn.getpos("'>")
	local lines = vim.fn.getline(start_pos[2], end_pos[2])

	-- If the selection is within a single line, trim it to the selected range
	if #lines == 1 then
		lines[1] = string.sub(lines[1], start_pos[3], end_pos[3])
	else
		-- Trim the first and last lines to the selected columns
		lines[1] = string.sub(lines[1], start_pos[3])
		lines[#lines] = string.sub(lines[#lines], 1, end_pos[3])
	end

	-- Join the lines into a single string
	-- Ensure that lines is a table of strings before concatenation
	if type(lines) == "table" then
		return lines
	else
		local result = {}
		result.insert(lines)
		return result
	end
end

return M
