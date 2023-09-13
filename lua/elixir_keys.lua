-- main module file
local map = require("elixir_keys.map")

---@class ElixirKeys
local M = {}

-- replaces the map keys from string to atom or from atom to string based on
-- the current key type
M.toggle_map = function()
  map.toggle()
end

return M
