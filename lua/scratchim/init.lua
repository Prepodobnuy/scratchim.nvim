local config = require 'scratchim.config'
local cache = require 'scratchim.cache'
local open_or_split = require 'scratchim.buffer'

local M = {}

function M.split() open_or_split(true) end
function M.open() open_or_split(false) end
function M.setup(opts)
  config.validate(opts)
  cache.load()

  vim.api.nvim_create_user_command('Scratchim', M.open, {})
  vim.api.nvim_create_user_command('ScratchimSplit', M.split, {})
end

return M
