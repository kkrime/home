-- vim.keymap.set("n", "<C-h>", function()
--   local util = require('vim.lsp.util')
--   local params = util.make_position_params()
--   local ms = require('vim.lsp.protocol').Methods

--   local method = ms.workspace_symbol

--   local a = require 'plenary.async'
--   local tx, rx = a.control.channel.oneshot()

--   run = function()
--     a.run(function()
--       -- handler function derived from /neovim/0.10.2_1/share/nvim/runtime/lua/vim/lsp/handlers.lua:M.hover()
--       local handler = function(_, result, ctx, _)
--         if not result then
--           vim.notify('Nothing sent from LSP')
--           return
--         end

--         for _, res in pairs(result) do
--           local len = #res.location.uri
--           local file = string.sub(res.location.uri, len - 6, len - 3)
--           -- if file == "main" then
--           if res.kind == 12 then
--             -- if res.location.range.start.line == 18 then
--             vim.notify(vim.inspect({ ressssss = res }))
--             local kind = vim.lsp.util._get_symbol_kind_name(res.kind)
--             vim.notify(res.kind .. " >>> " .. kind)
--           end

--           -- vim.notify(vim.inspect({ file = file }))
--           -- return
--         end

--         tx({ type, nil })
--       end

--       vim.lsp.buf_request(0, method, { query = "main" }, handler)
--       -- vim.notify(unpack(rx()))
--       -- local res = vim.lsp.buf.workspace_symbol()
--       -- vim.notify(vim.inspect({ res = res }))
--       local t, err = unpack(rx())
--     end)
--   end
--   run()
-- end, { silent = true, noremap = true })


-- vim.keymap.set("n", "<C-h>", function()
--   -- Get the current buffer and parser
--   local parser = vim.treesitter.get_parser(0, "go") -- Replace "lua" with the language
--   local tree = parser:parse()[1]                    -- Get the syntax tree

--   local query = vim.treesitter.query.parse(
--     "go", -- Language
--     [[
--       (package_identifier) @package
--       (function_declaration
--         name: (identifier) @function.name)
--     ]])

--   local iter = query:iter_matches(tree:root(), 0, 0, -1)
--   vim.notify(vim.inspect({ iter = iter }))
--   local _, match, _ = iter()
--   -- vim.notify(vim.inspect(match))
--   -- match()
--   -- local i, node = unpack(match)
--   -- vim.notify(vim.inspect(node[1]))
--   -- local capture_name = query.captures[1]                         -- Capture group name
--   -- vim.notify(vim.inspect({ capture_name = capture_name }))
--   -- local element_name = vim.treesitter.get_node_text(match[1], 0) -- Extract matched text
--   -- vim.notify(element_name)

--   for _, match, _ in iter do
--     for id, node in pairs(match) do
--       vim.notify(vim.inspect({ id = id }))
--       local capture_name = query.captures[id]                    -- Capture group name
--       local element_name = vim.treesitter.get_node_text(node, 0) -- Extract matched text
--       vim.notify(element_name)
--     end
--   end
-- end, { silent = true, noremap = true })

vim.keymap.set("n", "*", function()
  local popup = require("plenary.popup")

  local Win_id

  function ShowMenu(opts, cb)
    vim.api.nvim_win_set_cursor(0, { 5, 0 })
    local height = 20
    local width = 30
    local borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }

    Win_id = popup.create(opts, {
      title = "MyProjects",
      highlight = "MyProjectWindow",
      line = math.floor(((vim.o.lines - height) / 5.0) - 1),
      col = math.floor((vim.o.columns - width) / 2),
      minwidth = width,
      minheight = height,
      borderchars = borderchars,
      callback = cb,
    })
    local bufnr = vim.api.nvim_win_get_buf(Win_id)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "q", ":q<CR>", { silent = false })
  end

  local opts = {}
  local cb = function(_, sel)
    vim.notify(vim.inspect("Wo0p!"))
  end
  ShowMenu(opts, cb)
end, { silent = true, noremap = true })







return {}
