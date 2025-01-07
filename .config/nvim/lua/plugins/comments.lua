return {
  'numToStr/Comment.nvim',
  opts = {
    -- add any options here
  },
  lazy = false,
  config = function()
    require('Comment').setup {
      ignore = '^$',
    }

    vim.keymap.set("n", "gcl", function()
      vim.api.nvim_feedkeys("gcc", 'm', false)
    end, { silent = true, noremap = true })

    vim.api.nvim_create_user_command("CommentAndPasteLines", function(opts)
      local start_line = opts.line1
      local end_line = opts.line2
      local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)

      if start_line == end_line then
        -- if vim.api.nvim_get_current_line() == "" then
        if lines[1] == "" then
          -- empty line
          return
        end
        local row, col = unpack(vim.api.nvim_win_get_cursor(0))

        -- copy line
        vim.fn.setreg('a', lines)

        -- comment out line
        vim.api.nvim_feedkeys("gcl", 'x', true)

        -- move to next line
        vim.api.nvim_feedkeys("o", 'x', true)

        -- paste lins
        vim.api.nvim_paste(vim.fn.getreg('a'), true, -1)

        -- set cursor position
        vim.api.nvim_win_set_cursor(0, { row + 1, col })
        return
      else
        -- copy lines
        vim.fn.setreg('a', lines)

        -- comment out lines
        lines = end_line - start_line
        vim.api.nvim_feedkeys("V" .. lines .. "j", 'x', true)
        vim.api.nvim_feedkeys("gcl", 'x', true)

        -- move to first line after selected lines
        vim.api.nvim_win_set_cursor(0, { end_line, 0 })
        vim.api.nvim_feedkeys("o", 'x', true)

        -- paste lins
        vim.api.nvim_paste(vim.fn.getreg('a'), true, -1)
        vim.api.nvim_win_set_cursor(0, { end_line + 1, 0 })

        -- set cursor location
        local line = vim.api.nvim_get_current_line()
        local char = line:sub(1, 1)
        if char == " " then
          vim.api.nvim_feedkeys("I", 'x', true)
          vim.api.nvim_feedkeys("l", 'x', true)
        end
      end
    end, { force = true, range = true })

    vim.keymap.set({ "n", "v" }, "gcn", ":CommentAndPasteLines<CR>", { silent = true, noremap = true })
  end
}
