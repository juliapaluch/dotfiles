-- courtesy of https://shapeshed.com/vim-statuslines/
local function git_branch()
	local branch = vim.fn.system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
	if string.len(branch) > 0 then
		return branch
	else
		return ":"
	end
end

-- courtesy of https://vieitesss.github.io/posts/Neovim-custom-status-line/
Statusline = {}

function Statusline.active()
	local branch_color = "%#DiffAdd#"
	local branch = git_branch()
	local file_name_color = "%#CursorColumn#"
	local file_name = " %F"
	local modified = "%m"
	local separation_point = "%="
	local fileencoding_color = "%#DiffAdd#"
	local fileencoding = " %{&fileencoding?&fileencoding:&encoding}"
	local filetype_color = "%#DiffChange#"
	local filetype = " %y"
	local fileformat_color = "%#DiffDelete#"
	local fileformat = " [%{&fileformat}]"
	local place_color = "%#DiffText#"
	local percentage = " %p%%"
	local linecol = " %l:%c"
	return string.format(
		"%s %s %s%s %s %s %s%s %s%s %s%s %s%s %s ",
		branch_color,
		branch,
		file_name_color,
		file_name,
		modified,
		separation_point,
		fileencoding_color,
		fileencoding,
		filetype_color,
		filetype,
		fileformat_color,
		fileformat,
		place_color,
		percentage,
		linecol
	)
end

function Statusline.inactive()
	local file_name_color = "%#CursorColumn#"
	local file_name = " %F"

	return string.format(" %s %s ", file_name_color, file_name)
end

local group = vim.api.nvim_create_augroup("Statusline", { clear = true })

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
	group = group,
	desc = "Activate statusline on focus",
	callback = function()
		vim.opt_local.statusline = "%!v:lua.Statusline.active()"
	end,
})

vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
	group = group,
	desc = "Deactivate statusline when unfocused",
	callback = function()
		vim.opt_local.statusline = "%!v:lua.Statusline.inactive()"
	end,
})
