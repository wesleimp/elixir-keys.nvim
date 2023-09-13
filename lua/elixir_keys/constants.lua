local M = {}

M.to_atom = function()
  local node = ts.get_node()
  if not node:type() ~= "string" or not node:type() ~= "quoted_content" then
    return
  end

  if node:type() ~= "quoted_content" then
    node = node:parent()
  end

  local start_row, start_col, end_row, end_col = node:range()
  local bufnr = vim.api.nvim_get_current_buf()

  local text = string.gsub(ts.get_node_text(node, bufnr), '"([%w|%p]*)"', ":%1")

  vim.api.nvim_buf_set_text(bufnr, start_row, start_col, end_row, end_col, { text })
end

-- M.to_string = function()
--   -- TODO: implement
-- end

return M
