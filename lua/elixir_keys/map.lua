local treesitter = vim.treesitter

local M = {}

local atom_pattern = "([%w|_]*):"
local string_pattern = '"([%w|%p]*)" =>'

local function atom_to_string(line)
  local replacement = '"%1" =>'

  return string.gsub(line, atom_pattern, replacement)
end

local function string_to_atom(line)
  local replacement = "%1:"

  return string.gsub(line, string_pattern, replacement)
end

M.toggle = function()
  local node = treesitter.get_node()
  local parent = node:parent()

  while node:type() ~= "map" do
    node = parent
    parent = node:parent()
  end

  local start_row, start_col, end_row, end_col = node:range()
  local bufnr = vim.api.nvim_get_current_buf()

  local lines = vim.split(treesitter.get_node_text(node, bufnr), "\n")
  for i, line in ipairs(lines) do
    if line:match(atom_pattern) then
      lines[i] = atom_to_string(line)
    else
      lines[i] = string_to_atom(line)
    end
  end

  vim.api.nvim_buf_set_text(bufnr, start_row, start_col, end_row, end_col, lines)
end

return M
