local consts = require 'scratchim.consts'

---@type ScratchConfig
local M = {}

---@type ScratchOpts
M.value = {
  buffer_name = consts.buffer_name,
  cache_path = consts.cache_path,
  save_timeout = consts.save_timeout,
  do_not_save = consts.do_not_save,
  default_content = consts.default_content,
}

-- stylua: ignore start
---@param opts ScratchOpts?
function M.validate(opts)
  opts = opts or {}

  M.value.buffer_name     = opts.buffer_name     or consts.buffer_name
  M.value.cache_path      = opts.cache_path      or consts.cache_path
  M.value.save_timeout    = opts.save_timeout    or consts.save_timeout
  M.value.do_not_save     = opts.do_not_save     or consts.do_not_save
  M.value.default_content = opts.default_content or consts.default_content
end
-- stylua: ignore end

---@return ScratchOpts
function M.get()
  if not M.value then M.validate {} end
  return M.value
end

return M
