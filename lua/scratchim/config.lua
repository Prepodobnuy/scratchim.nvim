local consts = require 'scratchim.consts'

---@type ScratchConfig
M = {
  buffer_name = consts.buffer_name,
  cache_path = consts.cache_path,
  save_delay = consts.save_delay,
  dont_save = consts.dont_save,
  default_content = consts.default_content,

  ---@param opts ScratchOpts?
  validate = function(opts)
    opts = opts or {}

    -- stylua: ignore start
    M.buffer_name     = opts.buffer_name     or consts.buffer_name
    M.cache_path      = opts.cache_path      or consts.cache_path
    M.save_delay      = opts.save_delay      or consts.save_delay
    M.dont_save       = opts.dont_save       or consts.dont_save
    M.default_content = opts.default_content or consts.default_content
    -- stylua: ignore end
  end,
}

return M
