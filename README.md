# Neovim Scratch Buffer Plugin

This plugin provides a simple way to work with scratch buffers in Neovim. It
allows you to quickly open a scratch buffer in your current window or in a new
split window. The plugin also offers the flexibility to configure the default
name of the scratch buffer.

This plugin is based on
[vim-scratch](https://github.com/duff/vim-scratch/tree/master), but written in
lua for Neovim.

## Features

- Open a scratch buffer in the current window.
- Open a scratch buffer in a new split window.
- Automatically switch to an existing scratch buffer if it's already open.
- Configure the default name for the scratch buffer.
- The scratch buffer acts as a temporary workspace and is not backed by a file.
- Project relative bookmark storage

## Installation

To install this plugin, you can use your favorite Neovim package manager. For example:

### [lazy](https://github.com/folke/lazy.nvim)

```lua
return {
  'Prepodobnuy/scratchim.nvim',
  lazy = true,
  keys = {
    { '<leader>bs', '<cmd>Scratchim<cr>', desc = 'Scratch Buffer', mode = 'n' },
    { '<leader>bS', '<cmd>ScratchimSplit<cr>', desc = 'Scratch Buffer (split)', mode = 'n' },
  },
  cmd = {
    'Scratchim',
    'ScratchimSplit',
  },
  opts = {
    buffer_name = 'Scratchim',
  },
}
```

### [pckr](https://github.com/lewis6991/pckr.nvim)

```lua
{
  'Prepodobnuy/scratchim.nvim',
  config = function()
    require('scratch').setup()
  end
}
```

### Configuring

The default configuration options are listed below:

```lua
opts = {
  -- The name of the scratch buffer
  buffer_name = '_SCRATCH_',

  -- Path to cache file
  cache_path = '~/.config/nvim/lol.json',

  -- Write debounce delay in ms (>=1)
  save_delay = 1000,

  -- Dont use cache
  dont_save = true,

  -- New scratches default content
  default_content = 'print("hello world")'
}
```

## Usage

### Commands

The plugin provides two commands:

- `:Scratchim` — Opens or switches to the scratch buffer in the current window.
- `:ScratchimSplit` — Opens or switches to the scratch buffer in a new split window.

### Lua Functions

You can also use the plugin's Lua functions directly:

- `require('scratchim').open()` — Equivalent to `:Scratchim`.
- `require('scratchim').split()` — Equivalent to `:ScratchSplitim`.

## License

[MIT License](LICENSE)

## Contributing

Contributions are welcome! Feel free to open issues or submit pull requests.
