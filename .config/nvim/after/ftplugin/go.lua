local saveAllProjectGoFiles = function()
  local project_dir = require("project_nvim.project").get_project_root()

  -- loop though and save .go files in current project only
  for _, buf_hndl in ipairs(vim.api.nvim_list_bufs()) do
    local file = vim.api.nvim_buf_get_name(buf_hndl)
    local file_in_project = vim.startswith(file, project_dir)

    if file_in_project then
      local fileType = vim.fn.getbufvar(buf_hndl, "&filetype")
      if fileType == "go" then
        if string.sub(file, #file - 5, #file) ~= ".pb.go" then
          vim.api.nvim_buf_call(buf_hndl, function()
            vim.cmd('w')
          end)
        else
          vim.notify(vim.inspect({ "string.sub(file, #file - 5, #file)", string.sub(file, #file - 5, #file) }))
        end
      end
    end
  end
end

-- build
local buildtargets = require("buildtargets")
vim.keymap.set({ 'n', 'i' }, "<C-b>", function()
  saveAllProjectGoFiles()

  buildtargets.run_action(function(_, target_location)
    vim.api.nvim_command([[:GoBuild ]] .. target_location)
  end)
end, { silent = true, noremap = true })
