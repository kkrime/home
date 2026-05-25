-- load lsp
vim.lsp.enable('buf_ls')
vim.notify(vim.inspect({ "", vim.bo.filetype }))

local function build_function()
  local project_dir = require("project_nvim.project").get_project_root()
  vim.system({ 'buf', 'generate', '--error-format', 'json' }, { text = true }, function(obj)
    -- This runs in the background and calls back when finished
    if obj.code == 0 then
      vim.notify("proto generated successfully")
      -- nil
    else
      print("Error: " .. obj.stderr)
    end
  end)
end

require('fileTypeSettings').callbacks[vim.bo.filetype] = build_function
