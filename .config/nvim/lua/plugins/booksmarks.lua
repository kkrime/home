local bookmark_list_map = {}
local find_or_create_project_bookmark_group = function()
  local project_root = require("project_nvim.project").get_project_root()
  if not project_root then
    return
  end

  local Service = require("bookmarks.domain.service")
  local bookmark_list = bookmark_list_map[project_root]

  if bookmark_list then
    Service.set_active_list(bookmark_list.id)
    require("bookmarks.sign").safe_refresh_signs()
  end

  local project_name = string.gsub(project_root, "^" .. os.getenv("HOME") .. "/", "")
  local Repo = require("bookmarks.domain.repo")
  bookmark_list = nil

  for _, bl in ipairs(Repo.find_lists()) do
    if bl.name == project_name then
      bookmark_list = bl
      break
    end
  end

  if not bookmark_list then
    bookmark_list = Service.create_list(project_name)
  end
  Service.set_active_list(bookmark_list.id)
  require("bookmarks.sign").safe_refresh_signs()

  bookmark_list_map[project_root] = bookmark_list
end

vim.api.nvim_create_autocmd({ "VimEnter", "BufEnter" }, {
  group = vim.api.nvim_create_augroup("BookmarksGroup", {}),
  pattern = { "*" },
  callback = find_or_create_project_bookmark_group,
})

return {
  "LintaoAmons/bookmarks.nvim",
  dependencies = {
    { "kkharji/sqlite.lua" },
    { "nvim-telescope/telescope.nvim" },
    { "stevearc/dressing.nvim" } -- optional: better UI
  },
  config = function()
    local opts = {}                  -- go to the following link to see all the options in the deafult config file
    require("bookmarks").setup(opts) -- you must call setup to init sqlite db

    vim.keymap.set("n", "md", "<cmd>BookmarksMark<CR><CR>", { silent = true, noremap = true })
    vim.keymap.set("n", "mm", function()
      vim.cmd('BookmarksMark')
      vim.schedule(function()
        local keys = vim.api.nvim_replace_termcodes('<CR>', true, false, true)
        vim.api.nvim_set_current_line("")
        vim.api.nvim_feedkeys(keys, 'm', false)
      end)
    end, { silent = true, noremap = true })

    vim.keymap.set("n", "mn", "<cmd>BookmarksGotoNext<CR>", { silent = true, noremap = true })
    vim.keymap.set("n", "mN", "<cmd>BookmarksGotoPrev<CR>", { silent = true, noremap = true })

    vim.keymap.set({ "n", "v" }, "ml", "<cmd>BookmarksGoto<cr>",
      { desc = "Go to bookmark at current active BookmarkList" })

    vim.keymap.set({ "n", "v" }, "mx",
      function()
        require("bookmarks.commands").delete_mark_of_current_file()
      end, { silent = true })
  end,
}
