return {
  "kkrime/build.nvim",
  lazy = false,
  config = function()
    local buildtargets = require("buildtargets")
    buildtargets.setup({
      get_project_root_func = require("project_nvim.project").get_project_root,
      select_buildtarget_callback = require('lualine').refresh,
      close_menu_keys = { '<Esc>', '' }
    })
  end
}
