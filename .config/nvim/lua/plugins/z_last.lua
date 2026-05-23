vim.api.nvim_create_user_command('Z', function()
  vim.cmd("e ~/.config/nvim/lua/plugins/z_last.lua")
end, {})


vim.keymap.set("n", "<C-h>", function()
  require("buildtargets").select_buildtarget()
end)


-------------------------------------------------------------------------------------------------------------------------------------


local function tab_exists(tab)
  for _, t in ipairs(vim.api.nvim_list_tabpages()) do
    if t == tab then
      return true
    end
  end
  return false
end








vim.keymap.del("n", "<C-h>")

-- local log_tab
-- local log_tabnr
-- local original_tab
-- vim.keymap.set("n", "<C-h>", function()
--   if log_tab == vim.api.nvim_get_current_tabpage() then
--     vim.notify("current tab")
--     return
--   end
--   vim.cmd("w")

--   vim.schedule(function()
--     is_location_list_open = vim.fn.getloclist(0, { winid = 0 }).winid ~= 0

--     vim.notify("after")

--     if not is_location_list_open then
--       -- 1. open tab with log
--       original_tab = vim.api.nvim_get_current_tabpage()
--       if tab_bufnr and #vim.fn.win_findbuf(tab_bufnr) > 0 and vim.api.nvim_buf_is_valid(tab_bufnr) then
--         vim.api.nvim_set_current_tabpage(log_tab)

--         -- vim.keymap.del("n", "<ESC>")
--         vim.keymap.set("n", "<ESC>", function()
--           vim.api.nvim_set_current_tabpage(original_tab)
--         end, { buffer = vim.api.nvim_get_current_buf() })

--         -- 2. show Android Emulator
--         local result = vim.fn.system(
--           'aerospace focus --window-id $(aerospace list-windows --all | rg "Android Emulator" | choose 0)')
--         return
--       end

--       vim.cmd("tabnew | terminal tail -f /tmp/flutter.out")
--       vim.cmd("$")
--       vim.cmd("tabmove 0")
--       log_tab = vim.api.nvim_get_current_tabpage()
--       tab_bufnr = vim.api.nvim_get_current_buf()

--       vim.keymap.set("n", "<ESC>", function()
--         vim.api.nvim_set_current_tabpage(original_tab)
--       end, { buffer = vim.api.nvim_get_current_buf() })

--       tab = vim.api.nvim_get_current_buf()

--       -- 2. show Android Emulator
--       local result = vim.fn.system(
--         'aerospace focus --window-id $(aerospace list-windows --all | rg "Android Emulator" | choose 0)')
--       vim.notify(vim.inspect({ "result", result }))
--     end
--   end)
-- end)

-- -- end)

-- return {}
--
--
local function addKeyMappings(original_tab)
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

  -- create break in log
  vim.api.nvim_feedkeys(vim.keycode("r"), "m", false)
  vim.keymap.set("n", "<ENTER>", function()
    local result = vim.fn.system(
      "echo '\n\n###########################################################################################################################################################################################################################################################################################################################################\n\n\n\n\n\n\n' > /tmp/flutter.out ")
  end, { buffer = vim.api.nvim_get_current_buf() })
end
local log_tab
local log_tabnr
local original_tab
vim.keymap.set("n", "<C-h>", function()
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
end)


-- end)

return {}
