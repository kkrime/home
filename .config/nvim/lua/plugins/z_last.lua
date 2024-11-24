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

vim.keymap.set("n", "<C-h>",
  function()
    -- vim.keymap.set('n', '<Leader>w', ':GoAddTags test<CR>', { noremap = true, silent = true })
    -- vim.cmd('GoAddTag test')
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(':GoAddTag test<CR>', true, false, true), 'n', false)
    -- local config = require("project_nvim.config")
    -- local clients = vim.lsp.get_clients({ bufnr = 0 })
    -- local buf_ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })

    -- local current_file = vim.api.nvim_buf_get_name(0)
    -- local project_dir

    -- for _, client in pairs(clients) do
    --   local filetypes = client.config.filetypes
    --   if filetypes and vim.tbl_contains(filetypes, buf_ft) then
    --     if not vim.tbl_contains(config.options.ignore_lsp, client.name) then
    --       for _, workspace in pairs(client.workspace_folders) do
    --         vim.notify(vim.inspect(workspace.name))
    --         local workspace_len = #workspace.name
    --         if project_dir and #project_dir > workspace_len then
    --           -- vim.notify(vim.inspect("wo0p!"))
    --           goto continue
    --         end
    --         if workspace_len > #current_file then
    --           -- vim.notify(vim.inspect("wo0p!"))
    --           goto continue
    --         end
    --         if string.sub(current_file, 0, workspace_len) == workspace.name then
    --           vim.notify(vim.inspect("wo0p!"))
    --           project_dir = workspace.name
    --         end
    --         -- vim.notify(vim.inspect("wo0p!"))
    --         ::continue::
    --       end
    --       return project_dir, client.name
    --     end
    --   end
    -- end



    local util = require('vim.lsp.util')
    local params = util.make_position_params()
    local ms = require('vim.lsp.protocol').Methods

    local method = ms.textDocument_hover

    local a = require 'plenary.async'
    local tx, rx = a.control.channel.oneshot()


    -- run = function()
    --   local lanes = require("lanes").configure()

    --   -- Create a Linda (shared data space)
    --   local linda = lanes.linda()
    --   linda:send("channel", i)
    --   local key, value = linda:receive("channel")
    --   print("Consumer received:", value)

    --   return
    --       a.run(function()
    --         -- handler function derived from /neovim/0.10.2_1/share/nvim/runtime/lua/vim/lsp/handlers.lua:M.hover()
    --         local handler = function(_, result, ctx, _)
    --           if vim.api.nvim_get_current_buf() ~= ctx.bufnr then
    --             -- Ignore result since buffer changed. This happens for slow language servers.
    --             return
    --           end
    --           if not (result and result.contents) then
    --             vim.notify('Nothing sent from LSP')
    --             return
    --           end

    --           local contents ---@type string[]
    --           if type(result.contents) == 'table' and result.contents.kind == 'plaintext' then
    --             contents = vim.split(result.contents.value or '', '\n', { trimempty = true })
    --           else
    --             contents = util.convert_input_to_markdown_lines(result.contents)
    --           end
    --           if vim.tbl_isempty(contents) then
    --             vim.notify('No information available')
    --             return
    --           end

    --           local type = contents[2]:match("^var%s+%w+%s+(.*)$")
    --           if not type then
    --             vim.notify('Regex failed')
    --             return
    --           end

    --           -- tx(nil)
    --           tx({ type, nil })
    --         end

    --         print("params")
    --         print(vim.inspect(params))
    --         vim.lsp.buf_request(0, method, params, handler)
    --         -- vim.notify(unpack(rx()))
    --         local t, err = unpack(rx())
    --         print("t")
    --         print(t)
    --         print(string.sub(t, 1, 2) ~= "[]")
    --         -- print("err")
    --         -- print(err)
    --         -- print("after")
    --       end, _)
    -- end
    -- run()
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
