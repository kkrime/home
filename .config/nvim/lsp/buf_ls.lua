-- Register the buf-config filetype for Buf configuration files.
vim.filetype.add({
  filename = {
    ['buf.yaml'] = 'buf-config',
    ['buf.gen.yaml'] = 'buf-config',
    ['buf.policy.yaml'] = 'buf-config',
    ['buf.lock'] = 'buf-config',
  },
})
return {
  -- Optionally, use Treesitter's YAML parser for syntax highlighting.
  -- vim.treesitter.language.register('yaml', 'buf-config')

  -- Register buf_ls as an LSP server.
  -- If you use nvim-lspconfig (https://github.com/neovim/nvim-lspconfig), you can
  -- replace the vim.lsp.config() and vim.lsp.enable() calls below with:
  --   require('lspconfig').buf_ls.setup({})
  -- vim.lsp.config('buf_ls', {
  -- Command and arguments to start the server.
  cmd = { 'buf', 'lsp', 'serve' },
  -- Filetypes to automatically attach to.
  filetypes = { 'proto', 'buf-config' },
  -- Set the workspace for the LSP to the directory of the first matching file.
  root_markers = { 'buf.yaml', '.git' },
  -- })
  -- Enable buf_ls configuration.

  -- Create mappings and enable format on save for LSP-enabled files.
  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
      -- Type 'gd' in normal mode to go to definition.
      -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = args.buf, desc = 'Go to definition' })
      -- NOTE: In Neovim, many LSP and diagnostic mappings and options are set by
      -- default and do not need to be mapped explicitly.
      --
      -- Uncomment below to override these default mappings:

      --vim.keymap.set('n', 'grr', vim.lsp.buf.references, {buffer = args.buf, desc = 'References'})
      --vim.keymap.set('n', 'grt', vim.lsp.buf.type_definition, {buffer = args.buf, desc = 'Type definition'})
      --vim.keymap.set('n', 'gO', vim.lsp.buf.document_symbol, {buffer = args.buf, desc = 'Document symbol'})
      --vim.keymap.set('n', 'grn', vim.lsp.buf.rename, {buffer = args.buf, desc = 'Rename'})
      --vim.keymap.set('n', 'gra', vim.lsp.buf.code_action, {buffer = args.buf, desc = 'Code action'})

      -- See :help lspdefaults for more details, including:
      --
      -- * K is mapped to hover
      -- * grn is mapped to rename
      -- * gra is mapped to code action (organize imports, deprecations, quick fixes)
      -- * omnifunc and tagfunc are automatically set
      -- * formatexpr is automatically set to use the LSP's formatter
      --
      -- Diagnostics (see `:help diagnostic-defaults`):
      --
      -- * ]d/[d jumps to next/prev diagnostic, respectively
      -- * ]D/[D jumps to first/last diagnostics in buffer, respectively
      -- * <C-w>d shows diagnostic at the cursor in a floating window
      --
      -- Uncomment below for a basic example diagnostic configuration that underlines locations and shows virtual text.

      --vim.diagnostic.config({
      --  virtual_text = true,
      --  underline = true
      --})

      -- Format on save.
      -- vim.api.nvim_create_autocmd('BufWritePre', { buffer = args.buf, callback = vim.lsp.buf.format })

      -- Set up autocompletion.
      --
      -- A popup menu will be shown when the Buf Language Server notifies Neovim that it has
      -- completion suggestions. Use <control-n>/<control-p> to move through suggested completions
      -- and <control-y> to select a completion.
      --
      -- For more details on Neovim's completion, see `:help popupmenu-completion`
      -- local client = vim.lsp.get_client_by_id(args.data.client_id)
      -- if client:supports_method('textDocument/completion') then
      --   vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
      --   -- Request completions manually with <control-space>.
      --   vim.keymap.set('i', '<c-space>', vim.lsp.completion.get,
      --     { buffer = args.buf, desc = 'Manually request completions' })
      -- end
    end
  })
}
