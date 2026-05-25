local fileTypeSettings = require('fileTypeSettings')
if fileTypeSettings.loaded[vim.bo.filetype] then
  return
end
fileTypeSettings.loaded[vim.bo.filetype] = true


vim.notify("AFTER DART")
local function addKeyMappings(original_tab)
  -- create break in log
  vim.api.nvim_feedkeys(vim.keycode("r"), "m", false)
  vim.keymap.set("n", "<CR>", function()
    local result = vim.fn.system(
      "echo '\n\n###########################################################################################################################################################################################################################################################################################################################################\n\n\n\n\n\n\n' > /tmp/flutter.out ")
  end, { buffer = vim.api.nvim_get_current_buf() })
  -- perform break in log
  vim.api.nvim_feedkeys(vim.keycode("<CR>"), "m", false)

  -- hot reload
  vim.keymap.set("n", "r", function()
    local result = vim.fn.system(
      'kill -USR1 $(cat /tmp/flutter.pid)')
    vim.notify(vim.inspect({ "result", result }))
    local result = vim.fn.system(
      'aerospace focus --window-id $(aerospace list-windows --all | rg "Android Emulator" | choose 0)')
    vim.notify(vim.inspect({ "result", result }))
  end, { buffer = vim.api.nvim_get_current_buf() })

  -- perform hot reload
  vim.api.nvim_feedkeys(vim.keycode("r"), "m", false)

  -- ESC to go back to previous tab
  vim.keymap.set("n", "<ESC>", function()
    vim.api.nvim_set_current_tabpage(original_tab)
  end, { buffer = vim.api.nvim_get_current_buf() })

  -- hot restart
  vim.keymap.set("n", "R", function()
    local result = vim.fn.system(
      'kill -USR2 $(cat /tmp/flutter.pid)')
    vim.notify(vim.inspect({ "result", result }))
    local result = vim.fn.system(
      'aerospace focus --window-id $(aerospace list-windows --all | rg "Android Emulator" | choose 0)')
    vim.notify(vim.inspect({ "result", result }))
  end, { buffer = vim.api.nvim_get_current_buf() })
end

local log_tab
local log_tabnr
local original_tab

local function build_function()
  if log_tab == vim.api.nvim_get_current_tabpage() then
    vim.notify("current tab")
    return
  end

  original_tab = vim.api.nvim_get_current_tabpage()
  vim.cmd("w")

  vim.schedule(function()
    is_location_list_open = vim.fn.getloclist(0, { winid = 0 }).winid ~= 0


    if not is_location_list_open then
      original_tab = vim.api.nvim_get_current_tabpage()

      vim.notify(vim.inspect({ "#vim.fn.win_findbuf(tab_bufnr)", #vim.fn.win_findbuf(tab_bufnr) }))
      if tab_bufnr and #vim.fn.win_findbuf(tab_bufnr) > 0 and vim.api.nvim_buf_is_valid(tab_bufnr) then
        vim.notify(vim.inspect({ "#vim.fn.win_findbuf(tab_bufnr)", #vim.fn.win_findbuf(tab_bufnr) }))
        vim.notify(vim.inspect({ "log_tab", log_tab }))

        vim.api.nvim_set_current_tabpage(log_tab)

        addKeyMappings(original_tab)
        -- vim.api.nvim_feedkeys(vim.keycode("r"), "m", false)
        return
      end

      vim.cmd("tabnew | terminal tail -f /tmp/flutter.out")
      log_tab = vim.api.nvim_get_current_tabpage()
      vim.cmd("$")
      vim.cmd("tabmove 0")
      tab_bufnr = vim.api.nvim_get_current_buf()

      vim.notify(vim.inspect({ "vim.api.nvim_buf_is_valid(tab_bufnr)", vim.api.nvim_buf_is_valid(tab_bufnr) }))
      addKeyMappings(original_tab)
      vim.api.nvim_feedkeys(vim.keycode("r"), "m", false)

      -- vim.notify(vim.inspect({ "result", result }))
    end
  end)
end

fileTypeSettings.callbacks[vim.bo.filetype] = build_function
