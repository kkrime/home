vim.keymap.set("n", "<C-h>", function()
  require("buildtargets").select_buildtarget()
end)

-- local target = nil

-- vim.keymap.set("n", "<C-h>", function()
--   local dap = require('dap')
--   if target == nil then
--     local bufnr = vim.api.nvim_get_current_buf()
--     local configs = dap.providers.configs
--     for _, config in pairs(configs) do
--       for _, c in pairs(config(bufnr)) do
--         if c.name == "zitadel" then
--           vim.notify(vim.inspect({ "c", c }))
--           target = c
--           break
--         end
--       end
--     end
--   end

--   if target ~= nil then
--     dap.run(target, nil)
--   else
--     vim.notify("target not found")
--   end
-- end)

return {}

