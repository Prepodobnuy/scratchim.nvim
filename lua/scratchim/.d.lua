---@class ScratchCache
---@field cache table<string, string>
---@field load fun()
---@field save fun()
---@field set fun(value: string)
---@field get fun(): string?

---@class ScratchOpts
---@field buffer_name string?
---@field cache_path string?
---@field save_timeout integer?
---@field do_not_save boolean?
---@field default_content string?

---@class ScratchConfig
---@field get fun(): ScratchOpts
---@field validate fun(opts: ScratchOpts?)
---@field value ScratchOpts?
