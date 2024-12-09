vim.keymap.set("n", "<C-h>", function()
  local util = require('vim.lsp.util')
  local params = util.make_position_params()
  local ms = require('vim.lsp.protocol').Methods

  local method = ms.workspace_symbol

  local a = require 'plenary.async'
  local tx, rx = a.control.channel.oneshot()

  run = function()
    a.run(function()
      -- handler function derived from /neovim/0.10.2_1/share/nvim/runtime/lua/vim/lsp/handlers.lua:M.hover()
      local handler = function(_, result, ctx, _)
        if not result then
          vim.notify('Nothing sent from LSP')
          return
        end

        for _, res in pairs(result) do
          local len = #res.location.uri
          local file = string.sub(res.location.uri, len - 6, len - 3)
          -- if file == "main" then
          if res.kind == 12 then
            -- if res.location.range.start.line == 18 then
            vim.notify(vim.inspect({ ressssss = res }))
            local kind = vim.lsp.util._get_symbol_kind_name(res.kind)
            vim.notify(res.kind .. " >>> " .. kind)
          end

          -- vim.notify(vim.inspect({ file = file }))
          -- return
        end

        tx({ type, nil })
      end

      vim.lsp.buf_request(0, method, { query = "main" }, handler)
      -- vim.notify(unpack(rx()))
      -- local res = vim.lsp.buf.workspace_symbol()
      -- vim.notify(vim.inspect({ res = res }))
      local t, err = unpack(rx())
    end)
  end
  run()
end, { silent = true, noremap = true })

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
