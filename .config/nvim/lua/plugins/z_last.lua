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

local ShowMenu = function(opts, cb, lines)
  -- vim.notify(vim.inspect({ lines = lines }))
  -- vim.api.nvim_win_set_cursor(0, { 5, 0 })
  local popup = require("plenary.popup")
  local height = 20
  local width = 30
  local borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
  Win_id = popup.create(opts, {
    title = "Select Go Project",
    -- highlight = "MyProjectWindow",
    line = math.floor(((vim.o.lines - height) / 5.0) - 1),
    col = math.floor((vim.o.columns - width) / 2),
    minwidth = width,
    minheight = height,
    borderchars = borderchars,
    callback = cb,
  })
  local bufnr = vim.api.nvim_win_get_buf(Win_id)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "q", ":q<CR>", { silent = false })
  -- vim.api.nvim_buf_set_option(bufnr, 'guicursor', 'a:Cursor/off')
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
  -- disable insert mode
  vim.cmd("set nomodifiable")
  -- https://github.com/goolord/alpha-nvim/discussions/75
  local hl = vim.api.nvim_get_hl_by_name('Cursor', true)
  hl.blend = 0
  vim.api.nvim_set_hl(0, 'Cursor', hl)
  vim.opt.guicursor:append('a:Cursor/lCursor')
end

local projects = {}

local save_path = vim.fn.expand("$HOME/.go_build.json")

vim.keymap.set("n", "<C-h>", function()
  local project_root = require("project_nvim.project").get_project_root()

  local ms = require('vim.lsp.protocol').Methods
  local method = ms.workspace_symbol
  local result = vim.lsp.buf_request_sync(0, method, { query = "main" })

  local projects_ = {}
  projects_[project_root] = {}
  local order = 1
  if result then
    for _, ress in pairs(result) do
      for _, resss in pairs(ress) do
        for _, res in pairs(resss) do
          if res.name == "main" then
            -- filter functions only (vlaue 12)
            if res.kind == 12 then
              local filelocation = vim.uri_to_fname(res.location.uri)

              if not vim.startswith(filelocation, project_root) then
                goto continue
              end

              -- TODO check if filelocation already opened
              -- open file
              vim.api.nvim_command('badd ' .. filelocation)

              local bufnr = vim.fn.bufnr(filelocation)

              local parser = vim.treesitter.get_parser(bufnr, "go")
              local tree = parser:parse()[1]

              -- search for 'package main' and 'func main()'
              local query = vim.treesitter.query.parse(
                "go", -- Language
                [[
                  (package_clause
                    (package_identifier) @main.package)
                  (function_declaration
                    name: (identifier) @main.function
                    parameters: (parameter_list) @main.function.parameters
                    !result
                  (#eq? @main.package "main")
                  (#eq? @main.function "main"))
                  (#eq? @main.function.parameters "()")
                ]])

              local ts_query_match = 0
              for _, _, _, _ in query:iter_captures(tree:root(), bufnr, nil, nil) do
                ts_query_match = ts_query_match + 1
              end

              if ts_query_match == 3 then
                local projectname = getprojectname(filelocation)
                projects_[project_root][projectname] = { order, filelocation }
                order = order + 1
              end
            end
          end
          ::continue::
        end
      end
    end
  end

  writebuildsfile(projects_)
  projects = projects_
  -- vim.notify(vim.inspect({ projects = projects }))
  update_project_map(project_root, "asset_generator")

  opts = {}
  local cb = function(_, sel)
    vim.notify(vim.inspect("Wo0p!"))
  end
  ShowMenu(opts, cb, projects_[project_root]['menu'])
  -- ShowMenu(opts, cb)
end, { silent = true, noremap = true })

function update_project_map(project_root, selection)
  local selection_idx = projects[project_root][selection][1]
  if selection_idx == 1 then
    return
  end
  -- vim.notify(vim.inspect({ projects = projects }))
  projects[project_root]['menu'] = nil
  local lines = {}
  for project, proj_details in pairs(projects[project_root]) do
    local proj_idx = proj_details[1]
    if proj_idx < selection_idx then
      proj_idx = proj_idx + 1
      projects[project_root][project][1] = proj_idx
    end
    lines[proj_idx] = project
  end
  projects[project_root][selection][1] = 1
  lines[1] = selection

  projects[project_root]['menu'] = lines
end

-- function select_project(project_root, selection)
--   local selection_idx = projects[project_root][selection][1]
--   if selection_idx == 1 then
--     return
--   end

--   vim.notify(vim.inspect({ projects = projects }))
--   -- local arr = {}
--   local arr
--   -- projects_array[project_root] = {}
--   -- local arr = projects_array[project_root]
--   -- projects_array[project_root] = nil
--   -- if not projects_array[project_root] then
--   if not arr then
--     arr = {}
--     for project, proj_details in pairs(projects[project_root]) do
--       local proj_idx = proj_details[1]
--       local proj_dir = proj_details[2]
--       arr[proj_idx] = { project, proj_dir }
--     end
--   end
--   -- vim.notify(vim.inspect({ arr = arr }))
--   -- print(vim.inspect({ arr = arr }))

--   if true then
--     -- return
--   end

--   local projects_selection_backup = projects[project_root][selection]
--   local projects_array_selection_backup = arr[projects_selection_backup[1]]
--   if selection_idx ~= projects_selection_backup[1] then
--     vim.notify(vim.inspect("nope"))
--     assert("nope")
--   end

--   -- vim.notify(vim.inspect({ selection_idx = selection_idx }))
--   vim.notify(vim.inspect({ selection_idx = selection_idx }))
--   for i = selection_idx, 2, -1 do
--     arr[i] = arr[(i - 1)]
--   end


--   arr[1] = projects_array_selection_backup
--   vim.notify(vim.inspect({ arrrrrr = arr }))
--   print(vim.inspect({ arrrrrr = arr }))
-- end

-- function select_project(project_root, selection)
--   local selection_idx = projects[project_root][selection][1]
--   if selection_idx == 1 then
--     return
--   end

--   vim.notify(vim.inspect({ projects = projects }))

--   if not projects_array[project_root] then
--     projects_array[project_root] = {}
--     for project, proj_details in pairs(projects[project_root]) do
--       local proj_idx = proj_details[1]
--       local proj_dir = proj_details[2]
--       projects_array[project_root][proj_idx] = { project, proj_dir }
--     end
--   end
--   vim.notify(vim.inspect({ projects_array = projects_array[project_root] }))

--   -- backup selection
--   local projects_selection_backup = projects[project_root][selection]
--   local projects_array_selection_backup = projects_array[project_root][projects_selection_backup[1]]

--   if selection_idx ~= projects_selection_backup[1] then
--     vim.notify(vim.inspect("nope"))
--     assert("nope")
--   end

--   -- vim.notify(vim.inspect({ selection_idx = selection_idx }))
--   vim.notify(vim.inspect({ selection_idx = selection_idx }))
--   for i = selection_idx, 2, -1 do
--     -- vim.notify(vim.inspect({ i = i + 1, ii = projects_array[project_root][i], iPlus = projects_array[project_root]
--     -- [i + 1] }))
--     projects_array[project_root][i] = projects_array[project_root][i + 1]
--     vim.notify(vim.inspect({ i = i, pp = projects_array[project_root][tonumber(i)] }))
--   end

--   projects_array[project_root][1] = projects_array_selection_backup
--   -- vim.notify(vim.inspect({ projects_array = projects_array[project_root] }))
--   vim.notify(vim.inspect({ projects_array_size = #projects_array[project_root] }))

--   -- for k, v in ipairs(projects_array[project_root]) do
--   --   vim.notify(vim.inspect({ k = k, v = v }))
--   -- end
-- end

-- function select_project(project_root, selection)
--   local selection_idx = projects[project_root][selection][1]
--   if selection_idx == 1 then
--     return
--   end

--   vim.notify(vim.inspect({ projects = projects }))
--   if not projects_array[project_root] then
--     projects_array[project_root] = {}
--     for project, proj_details in pairs(projects[project_root]) do
--       local proj_idx = proj_details[1]
--       local proj_dir = proj_details[2]
--       -- vim.notify(vim.inspect({ proj_idx = proj_idx, project = project }))
--       -- projects_array[project_root][tostring(proj_idx)] = { project, proj_dir }
--       projects_array[project_root][proj_idx] = { project, proj_dir }
--       -- table.insert(projects_array[project_root], proj_idx, { project, proj_dir })
--     end
--   end
--   -- vim.notify(vim.inspect({ projects = projects }))
--   vim.notify(vim.inspect({ projects_array = projects_array }))
--   for k, v in ipairs(projects_array[project_root]) do
--     -- vim.notify(vim.inspect({ k = k, v = v }))
--   end


--   if true then
--     -- return
--   end


--   -- vim.notify(vim.inspect({ projects_array = projects_array }))
--   local projects_selection_backup = projects[project_root][selection]
--   -- projects[project_root][selection] = nil
--   local projects_array_selection_backup = projects_array[project_root][projects_selection_backup[1]]
--   if selection_idx ~= projects_selection_backup[1] then
--     vim.notify(vim.inspect("nope"))
--     assert("nope")
--   end
--   -- vim.notify(vim.inspect({ selection_idx = selection_idx }))
--   vim.notify(vim.inspect({ selection_idx = selection_idx }))
--   for i = selection_idx, 2, -1 do
--     -- projects_array[project_root][i] = nil
--     projects_array[project_root][i] = projects_array[project_root][i + i]
--     -- projects_array[project_root][i] = vim.deepcopy(projects_array[project_root][i + i])
--   end

--   projects_array[project_root][1] = projects_array_selection_backup
--   -- projects_array[project_root][1] = nil
--   -- table.insert(projects_array[project_root], 1, projects_array_selection_backup)
--   vim.notify(vim.inspect({ projects_array_size = #projects_array[project_root] }))
--   for k, v in pairs(projects_array[project_root]) do
--     -- vim.notify(vim.inspect({ k = k, v = v }))
--   end
-- end

function getprojectname(location)
  local filename = location:match("^.*/(.*)%.go$")
  if filename ~= "main" then
    return filename
  end

  local name = location:match("^.*/(.*)/.*$")
  return name
end

function writebuildsfile(data)
  local data = vim.json.encode(data)
  if projects ~= data then
    require("bookmarks.util").write_file(save_path, data)
  end
end

function readbuildsfile()
  require("bookmarks.util").read_file(save_path, function(data)
    projects = vim.json.decode(data)
  end)
end

return {}
