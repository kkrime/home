local source = ".persistence.json"
local zitadel_db = "/tmp/zitadel_db"
local zitadel_connect = function()
  local handler = require("dbee.api.core")

  -- 1. read zitadel_db
  local ok, db = pcall(vim.fn.readfile, zitadel_db)
  if not ok then
    vim.notify("can't read " .. zitadel_db, vim.log.levels.ERROR)
    return
  end
  db = db[1]

  -- 2. get current connection
  local current_connection = handler.get_current_connection()
  if current_connection == nil then
    vim.notify("can't read current connection", vim.log.levels.ERROR)
    return
  end

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
  if found then
    handler.set_current_connection(db)
  else
    vim.notify("DB NOT FOUND ADDING " .. db, vim.log.levels.INFO)
    handler.source_add_connection(source,
      {
        id = db,
        name = db,
        type = "postgres",
        -- url = "postgres://zitadel:zitadel@localhost:5432/" ..
        url = "postgres://postgres:postgres@localhost:5433/" ..
            db .. "?sslmode=disable"
      })
  end
end

return {
  {
    "kndndrj/nvim-dbee",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    build = function()
      require("dbee").install()
    end,
    config = function()
      dbee = require("dbee")
      ui = dbee.api.ui

      dbee.setup({
        result = {
          focus_result = false,
          page_size = 500
        },
        sources = {
          require("dbee.sources").FileSource:new(vim.fn.expand("$HOME") .. "/.persistence.json"),
        },
        editor = {
          -- see drawer comment.
          window_options = {},
          buffer_options = {},

          -- mappings for the buffer
          mappings = {
            {
              key = "<CR>",
              mode = "n",
              action = function()
                zitadel_connect()
                ui.editor_do_action("run_under_cursor")
              end,
            },
            {
              key = "BB",
              mode = "v",
              action = function()
                zitadel_connect()
                ui.editor_do_action("run_selection")
              end,
            },
            {
              key = "BB",
              mode = "n",
              action = function()
                zitadel_connect()
                ui.editor_do_action("run_file")
              end,
            },
          },
        },
      })
    end,
  },
}
