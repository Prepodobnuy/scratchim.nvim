local M = {}
local timer = nil

function M.debounce(delay, fn)
  delay = delay or 1000
  if timer then timer:close() end

  timer = vim.uv.new_timer()

  timer:start(
    delay,
    0,
    vim.schedule_wrap(function()
      timer:close()
      timer = nil
      fn()
    end)
  )
end

return M
