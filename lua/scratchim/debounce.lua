local timer = nil
local consts = require 'scratchim.consts'

return function(delay, fn)
  delay = delay or consts.save_delay
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
