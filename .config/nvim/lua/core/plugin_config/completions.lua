local cmp = require("cmp")
ls = require("luasnip")

-- require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-o>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert }),


    -- ['<CR>'] = cmp.mapping(function(fallback)
    --   cmp.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert })

    -- local key = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
    -- vim.api.nvim_feedkeys(key, 'i', false)

    -- if ls.jumpable(1) then
    -- ls.jump(1)
    -- end
    -- end, { 'i', 's' }),

  }),

  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  }),
})

-- break out of snippet mode
vim.keymap.set({ "i", "s" }, "<CR>", function()
  vim.print(cmp.visible())
  if cmp.visible() then
    return "<CR>"
  elseif ls.in_snippet() then
    -- if ls.in_snippet() then
    vim.print("inside")
    return "<Esc>o"
  else
    vim.print("outside")
    return "<CR>"
  end
end, { silent = true, buffer = true, expr = true })
