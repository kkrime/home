-- vim.keymap.set("n", "<C-h>", function()
--   require("buildtargets").select_buildtarget()
-- end)

-- local target = nil

-- vim.keymap.set("n", "<C-h>", function()

local source = ".persistence.json"
local zitadel_db = "/tmp/zitadel_db"
vim.keymap.set({ "n", "v" }, "<C-h>", function()
  local handler = require("dbee.api.core")

  -- 1. get current connection
  local current_connection = handler.get_current_connection()
  if current_connection == nil then
    vim.notify("can't read current connection", vim.log.levels.ERROR)
    return
  end

  -- 2. read zitadel_db
  local ok, db = pcall(vim.fn.readfile, zitadel_db)
  if not ok then
    vim.notify("can't read " .. zitadel_db, vim.log.levels.ERROR)
    return
  end
  db = db[1]

  -- 3. check if we're already connected to db
  if current_connection ~= nil and current_connection.name == db then
    return
  end

  -- 4. check if db connection already exists
  local found
  local connections = handler.source_get_connections(source)
  for _, conn in ipairs(connections) do
    if conn.name == db then
      found = true
      break
    end
  end

  -- 5. add db and connect
  if not found then
    vim.notify("DB NOT FOUND ADDING " .. db, vim.log.levels.INFO)
    handler.source_add_connection(source,
      { name = db, type = "postgres", url = "postgres://zitadel:zitadel@localhost:5432/" .. db .. "?sslmode=disable" })
  else
    handler.set_current_connection(db)
  end
end)

return {}

