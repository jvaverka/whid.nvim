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
  vim.api.nvim_buf_set_option(buf_handler, 'modifiable', true)
  -- we will use vim systemlist function which run shell
  -- command and return result as list
  local result = vim.fn.systemlist('git whatchanged')
  print(vim.inspect(result))

  -- with small indentation results will look better
  for k,v in pairs(result) do
    result[k] = '  '..result[k]
  end

  vim.api.nvim_buf_set_lines(buf_handler, 0, -1, false, result)
  vim.api.nvim_buf_set_option(buf_handler, 'modifiable', false)
end

local function close_window()
  vim.api.nvim_win_close(win, true)
end

local function set_mappings()
  local mappings = {
    q = 'close_window()',
  }

  for k,v in pairs(mappings) do
    api.nvim_buf_set_keymap(buf, 'n', k, ':lua require"whid".'..v..'<cr>', {
        nowait = true, noremap = true, silent = true
      })
  end
  local other_chars = {
    'a', 'b', 'c', 'd', 'e', 'f', 'g', 'i', 'n', 'o', 'p', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
  }
  for k,v in ipairs(other_chars) do
    api.nvim_buf_set_keymap(buf, 'n', v, '', { nowait = true, noremap = true, silent = true })
    api.nvim_buf_set_keymap(buf, 'n', v:upper(), '', { nowait = true, noremap = true, silent = true })
    api.nvim_buf_set_keymap(buf, 'n',  '<c-'..v..'>', '', { nowait = true, noremap = true, silent = true })
  end
end

local function whid()
  create_floating_window()
  update_view(0)
end

return {
  whid = whid,
  close_window = close_window
}
