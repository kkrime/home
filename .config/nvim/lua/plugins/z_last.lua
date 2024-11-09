-- local inspect = require('inspect')
-- require("notify")(_VERSION)


-- vim.keymap.set("n", "<C-h>", function()
--     local inspect = require('inspect')
--     local bufnr = vim.api.nvim_get_current_buf()
--     local bufInfo = vim.fn.getbufinfo(bufnr)
--     print(inspect(bufInfo))
--     local winid = bufInfo[1].windows[1]
--     print(inspect(winid))
--     -- print("current buffer")
--     -- print(current_bufnr)
--     -- local file_path = vim.api.nvim_buf_get_name(current_bufnr)

--     -- local bufnr = vim.fn.winbufnr(1)
--     -- buffnr = vim.fn.winbufnr(bufnr)
--     -- winid = vim.fn.bufwinid(bufnr)
--     -- vim.api.nvim_set_current_win(winid)

--     local wininfo = vim.fn.getwininfo(winid)
--     print(wininfo[1].lastused)
--     -- print(inspect(wininfo))
--     -- print(winid)

--     -- vim.api.nvim_command("edit " .. file_path)
--   end,
--   { silent = true, noremap = true })

vim.keymap.set("n", "<C-h>", function()
    local bufnr = vim.api.nvim_get_current_buf()
    local bufInfo = vim.fn.getbufinfo(bufnr)
    local winid = bufInfo[1].windows[1]
    local wininfo = vim.fn.getwininfo(winid)
    print(wininfo[1].lastused)
  end,
  { silent = true, noremap = true })

return {}










































-- get window configs
-- {
--   local current_window = vim.api.nvim_get_current_win()
--   -- Get the configuration of the current window
--   local window_config = vim.api.nvim_win_get_config(current_window)
--   -- Extract the name of the current window from the configuration
--   local window_name = window_config.relative and window_config.relative ~= '' and window_config.relative or nil
--   -- Print the window config
--   require("notify")(inspect(window_config))
-- }
