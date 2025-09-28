local config = require 'scratchim.config'
local cache = require 'scratchim.cache'
local augroup = vim.api.nvim_create_augroup('ScratchimChange', { clear = true })

---@return boolean
local function is_buf_modified()
  local buf = vim.api.nvim_get_current_buf()
  return vim.api.nvim_get_option_value('modified', { buf = buf }) or false
end

local function listen_changes()
  local buf = vim.api.nvim_get_current_buf()

  vim.api.nvim_create_autocmd({ 'TextChanged', 'TextChangedI', 'TextChangedP', 'TextChangedT' }, {
    buffer = buf,
    group = augroup,
    callback = function()
      local lines = table.concat(vim.api.nvim_buf_get_lines(buf, 0, -1, false), '\n')
      cache.set(lines)
      cache.save()
    end,
  })
end

---@param buf integer
---@param capt string[]
local function buf_set_lines(buf, capt) vim.api.nvim_buf_set_lines(buf, 0, -1, false, capt) end

---@param buf integer
local function buf_set_cache(buf)
  local lines = table.concat(vim.api.nvim_buf_get_lines(buf, 0, -1, false), '\n')
  cache.set(lines)
end

---@return string[]
local function get_cache()
  local cached_content = cache.get() or ''
  return vim.fn.split(cached_content, '\n', true)
end

---@param split boolean?
---@param buf integer? buffer id
local function open_existing_buffer(split, buf)
  split = split or false

  if type(buf) ~= 'number' or buf < 1 then
    error 'Invalid buffer number provided to switch_to_existing_buffer'
    return
  end

  -- See if this buffer is already open in a window
  local window_num = vim.fn.bufwinnr(buf)

  if window_num ~= -1 then
    -- Switch to that window (even if we're already there)
    vim.cmd(window_num .. ' wincmd w')
  else
    -- Switch to the existing scratch buffer
    local cmd = split and 'split +buffer ' or 'buffer '
    vim.cmd(cmd .. buf)
  end

  buf = vim.api.nvim_get_current_buf()
  local cached = get_cache()
  buf_set_lines(buf, cached)
  listen_changes()
end

---@param split boolean?
local function open_new_buffer(split)
  split = split or false

  local cmd = split and 'new ' or 'edit '
  vim.cmd(cmd .. config.buffer_name)

  local buf = vim.api.nvim_get_current_buf()

  -- stylua: ignore start
  vim.api.nvim_set_option_value('bufhidden', 'hide',   { buf = buf }) -- what to do when the buffer is hidden
  vim.api.nvim_set_option_value('buflisted', true,     { buf = buf }) -- include the buffer in the :bnext list
  vim.api.nvim_set_option_value('buftype',   'nofile', { buf = buf }) -- nofile means the buffer isn't backed by a file and we control its name
  vim.api.nvim_set_option_value('swapfile',  false,    { buf = buf }) -- never swapfiles
  -- stylua: ignore end

  local cached = get_cache()
  buf_set_lines(buf, cached)
  buf_set_cache(buf)
  listen_changes()
end

---@param split boolean
return function(split)
  split = split or is_buf_modified()

  local buf = vim.fn.bufnr(config.buffer_name)
  if buf ~= -1 then
    open_existing_buffer(split, buf)
  else
    open_new_buffer(split)
  end
end
