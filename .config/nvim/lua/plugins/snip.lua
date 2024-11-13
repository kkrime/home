return {
  {
    "L3MON4D3/LuaSnip",
    config = function(_)
      local ls = require("luasnip") --{{{

      -- require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/snippets/" })
      require("luasnip").config.setup({ store_selection_keys = "<A-p>" })

      vim.cmd([[command! LuaSnipEdit :lua require("luasnip.loaders.from_lua").edit_snippet_files()]]) --}}}

      -- Virtual Text{{{
      local types = require("luasnip.util.types")
      ls.config.set_config({
        -- history = true,                             --keep around last snippet local to jump back
        -- Below line is commented out due to; https://github.com/hrsh7th/nvim-cmp/issues/1743
        update_events = "TextChanged,TextChangedI", --update changes as you type
        enable_autosnippets = true,
        -- region_check_events = "CursorMoved,CursorHold,InsertEnter",
        region_check_events = "InsertEnter",
        -- delete_check_events = "TextChanged,InsertEnter",
        ext_opts = {
          [types.choiceNode] = {
            active = {
              virt_text = { { "●", "GruvboxOrange" } },
            },
          },
          -- [types.insertNode] = { active = {
          -- 		virt_text = { { "●", "GruvboxBlue" } },
          -- 	},
          -- },
        },
      }) --}}}

      -- Key Mapping --{{{

      vim.keymap.set({ "i", "s" }, "<c-s>", "<Esc>:w<cr>")
      vim.keymap.set({ "i", "s" }, "<c-u>", '<cmd>lua require("luasnip.extras.select_choice")()<cr><C-c><C-c>')

      vim.keymap.set({ "i", "s" }, "<C- >", function()
        if ls.expand_or_jumpable() then
          ls.expand()
        end
      end, { silent = true })


      -- vim.keymap.set({ "i", "s" }, "<C-k>", function()
      -- 	if ls.expand_or_jumpable() then
      -- 		ls.expand_or_jump()
      -- 	end
      -- end, { silent = true })
      -- vim.keymap.set({ "i", "s" }, "<C-j>", function()
      -- 	if ls.jumpable() then
      -- 		ls.jump(-1)
      -- 	end
      -- end, { silent = true })

      vim.keymap.set({ "i", "s" }, "<a-k>", function()
        if ls.jumpable(1) then
          ls.jump(1)
        end
      end, { silent = true })

      vim.keymap.set({ "i", "s" }, "<a-j>", function()
        if ls.jumpable(-1) then
          ls.jump(-1)
        end
      end, { silent = true })

      vim.keymap.set({ "i", "s" }, "<a-n>", function()
        if ls.choice_active() then
          ls.change_choice(1)
        else
          -- print current time
          local t = os.date("*t")
          local time = string.format("%02d:%02d:%02d", t.hour, t.min, t.sec)
          print(time)
        end
      end)
      vim.keymap.set({ "i", "s" }, "<a-p>", function()
        if ls.choice_active() then
          ls.change_choice(-1)
        end
      end) --}}}

      -- More Settings --

      vim.keymap.set("n", "<Leader><CR>", "<cmd>LuaSnipEdit<cr>", { silent = true, noremap = true })
      -- vim.cmd([[autocmd BufEnter */snippets/*.lua nnoremap <silent> <buffer> <CR> /-- End Refactoring --<CR>O<Esc>O]])



      vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
        vim.lsp.handlers.hover,
        { border = 'rounded' }
      )

      vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
        vim.lsp.handlers.signature_help,
        { border = 'rounded' }
      )

      -- TODO look into this
      -- break out of snippet mode
      --ggocal cmp = require("cmp")
      -- vim.keymap.set({ "i", "s" }, "<CR>", function()
      --   vim.print(cmp.visible())
      --   if cmp.visible() then
      --     return "<CR>"
      --   elseif ls.in_snippet() then
      --     -- if ls.in_snippet() then
      --     vim.print("inside")
      --     return "<Esc>o"
      --   else
      --     vim.print("outside")
      --     return "<CR>"
      --   end
      -- end, { silent = true, buffer = true, expr = true })
    end
  },
}
