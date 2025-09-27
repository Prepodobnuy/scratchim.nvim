return {
  buffer_name = '__SCRATCH__',
  cache_path = vim.fn.stdpath 'cache' .. '/scratch.json',
  save_timeout = 1000,
  do_not_save = false,
  default_content = nil,
}
