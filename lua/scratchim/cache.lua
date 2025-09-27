local config = require 'scratchim.config'

---@type ScratchCache
local M = {}
local root = vim.fn.getcwd()

M.cache = {}

---@return string
local function read()
  local path = config.get().cache_path
  local ok, file = pcall(io.open, path, 'r')
  if not ok or not file then return '' end

  local content = file:read '*a'
  file:close()
  return content
end

---@param data string
local function write(data)
  local path = config.get().cache_path
  local ok, file = pcall(io.open, path, 'w')
  if not ok or not file then return end

  file:write(data)
  file:close()
end

function M.load()
  local raw = read()
  if raw ~= '' then
    local ok, decoded = pcall(vim.fn.json_decode, raw)
    if ok and type(decoded) == 'table' then
      M.cache = decoded
      return
    end
  end
  M.cache = {}
end

function M.save() write(vim.fn.json_encode(M.cache)) end
function M.set(value) M.cache[root] = value end
function M.get() return M.cache[root] end

return M
