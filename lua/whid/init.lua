local function create_floating_window()
  local stats = vim.api.nvim_list_uis()[1]
	local width = stats.width
	local height = stats.height

	-- print("Hello, World!")
	-- print("Window size:", width, "x", height)
	-- print("Answer you seek:", vim.g["basic_value"])

	local buf_handler = vim.api.nvim_create_buf(false, true)
  local win_id = vim.api.nvim_open_win(buf_handler, true, {
    relative = "editor",
    width = math.floor(width * 0.5),
    height = math.floor(height * 0.5),
    col = math.floor(width * 0.25),
    row = math.floor(height * 0.20),
    border = "shadow",
    style = "minimal"
  })
end

local function update_view()
  -- we will use vim systemlist function which run shell
  -- command and return result as list
  local result = vim.fn.systemlist('git diff-tree --no-commit-id --name-only -r HEAD')

  -- with small indentation results will look better
  for k,v in pairs(result) do
    result[k] = '  '..result[k]
  end

  api.nvim_buf_set_lines(buf_handler, 0, -1, false, result)
end

return {
	create_floating_window = create_floating_window,
  update_view = update_view
}
