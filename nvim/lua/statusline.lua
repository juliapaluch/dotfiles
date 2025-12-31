-- courtesy of https://shapeshed.com/vim-statuslines/
local function git_branch()
    local branch = vim.fn.system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
    if string.len(branch) > 0 then
        return branch
    else
        return ":"
    end
end

local function statusline()
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
        "%s %s %s %s %s %s  %s %s  %s %s  %s %s  %s %s %s  ",
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

vim.opt.statusline = statusline()
