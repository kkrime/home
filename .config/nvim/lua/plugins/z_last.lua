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
--         vim.notify(vim.inspect({ result = result }))
--         print(vim.inspect({ result = result }))

--         for _, res in pairs(result) do
--           local len = #res.location.uri
--           local file = string.sub(res.location.uri, len - 6, len - 3)
--           if file == "main" then
--             -- if res.kind == 12 then
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
--

-- vim.keymap.set("n", "<C-h>", function()
--   local popup = require("plenary.popup")

--   local Win_id

--   function ShowMenu(opts, cb)
--     vim.api.nvim_win_set_cursor(0, { 5, 0 })
--     local height = 20
--     local width = 30
--     local borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }

--     Win_id = popup.create(opts, {
--       title = "MyProjects",
--       highlight = "MyProjectWindow",
--       line = math.floor(((vim.o.lines - height) / 5.0) - 1),
--       col = math.floor((vim.o.columns - width) / 2),
--       minwidth = width,
--       minheight = height,
--       borderchars = borderchars,
--       callback = cb,
--     })
--     local bufnr = vim.api.nvim_win_get_buf(Win_id)
--     vim.api.nvim_buf_set_keymap(bufnr, "n", "q", ":q<CR>", { silent = false })
--   end

--   local opts = {}
--   local cb = function(_, sel)
--     vim.notify(vim.inspect("Wo0p!"))
--   end
--   -- ShowMenu(opts, cb)
-- end, { silent = true, noremap = true })

local save_path = '~/.go_build.json'

vim.keymap.set("n", "<C-h>", function()
  local project_root = require("project_nvim.project").get_project_root()

  local ms = require('vim.lsp.protocol').Methods
  local method = ms.workspace_symbol
  local result = vim.lsp.buf_request_sync(0, method, { query = "main" })

  local projects = {}
  projects[project_root] = {}
  if result then
    for _, ress in pairs(result) do
      for _, resss in pairs(ress) do
        for _, res in pairs(resss) do
          if res.name == "main" then
            -- filter functions only (vlaue 12)
            if res.kind == 12 then
              local filename = vim.uri_to_fname(res.location.uri)

              if not vim.startswith(filename, project_root) then
                goto continue
              end

              -- open file
              vim.api.nvim_command('badd ' .. filename)

              local bufnr = vim.fn.bufnr(filename)

              local parser = vim.treesitter.get_parser(bufnr, "go")
              local tree = parser:parse()[1]

              local query = vim.treesitter.query.parse(
                "go", -- Language
                [[
                  (package_clause
                    (package_identifier) @main.package)
                  (function_declaration
                    name: (identifier) @main.function
                    parameters: (parameter_list) @function.parameters
                    !result
                  (#eq? @main.package "main")
                  (#eq? @function.parameters "()")
                  (#eq? @main.function "main"))
                ]])

              local ts_query_match = 0
              for id, node, _, _ in query:iter_captures(tree:root(), bufnr, nil, nil) do
                -- local name = query.captures[id] -- name of the capture in the query
                -- local function_name = vim.treesitter.get_node_text(node, bufnr)
                -- vim.notify(vim.inspect({ filename = filename, name = name, function_name = function_name }))

                -- if name == "main.function" then
                --   local start_line, _, _, _ = node:range()
                --   local main_line = vim.api.nvim_buf_get_lines(bufnr, start_line, start_line + 1, false)[1]
                --   local main_match = main_line:match("^%s*func%s+main\\(\\)%s+{$")
                --   -- if not main_match then
                --   if main_match then
                --     goto continue
                --   end
                -- end
                ts_query_match = ts_query_match + 1
                -- ::continue::
              end

              if ts_query_match == 3 then
                table.insert(projects[project_root], { 0, filename })
              end
            end
          end
          ::continue::
        end
      end
    end
  end
  local json = vim.json.encode(projects)
  -- vim.notify(vim.inspect({ json = json }j)
  vim.notify(vim.inspect({ projects = projects }))
end, { silent = true, noremap = true })




return {}
