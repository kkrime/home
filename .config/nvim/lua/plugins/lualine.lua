return {
  {
    "nvim-lualine/lualine.nvim",

    config = function()
      local custom_gruvbox             = require('lualine.themes.gruvbox')
      custom_gruvbox.normal.a.bg       = 'green'
      custom_gruvbox.normal.a.fg       = 'black'
      custom_gruvbox.insert.a.bg       = 'red'
      custom_gruvbox.insert.a.fg       = 'black'
      custom_gruvbox.command.a.bg      = 'yellow'
      custom_gruvbox.command.a.fg      = 'black'
      custom_gruvbox.visual.a.fg       = 'black'

      custom_gruvbox.normal.c.bg       = custom_gruvbox.normal.a.bg
      custom_gruvbox.normal.c.fg       = custom_gruvbox.normal.c.bg
      custom_gruvbox.insert.c.bg       = custom_gruvbox.insert.a.bg
      custom_gruvbox.insert.c.fg       = custom_gruvbox.insert.c.bg
      custom_gruvbox.command.c.bg      = custom_gruvbox.command.a.bg
      custom_gruvbox.command.c.fg      = custom_gruvbox.command.c.bg
      custom_gruvbox.visual.c.bg       = custom_gruvbox.visual.a.bg
      custom_gruvbox.visual.c.fg       = custom_gruvbox.visual.c.bg
      custom_gruvbox.inactive.c.fg     = '#3c3836'

      custom_gruvbox.normal['y']       = { bg = custom_gruvbox.normal.a.bg, fg = 'white', gui = 'bold' }
      custom_gruvbox.insert['y']       = { bg = custom_gruvbox.insert.a.bg, fg = 'black', gui = 'bold' }
      custom_gruvbox.command['y']      = { bg = custom_gruvbox.command.a.bg, fg = 'black', gui = 'bold' }
      custom_gruvbox.visual['y']       = { bg = custom_gruvbox.visual.a.bg, fg = 'black', gui = 'bold' }
      custom_gruvbox.inactive['y']     = { bg = '#3c3836', fg = 'white', gui = 'bold' }

      local lualine_b                  = {
        {
          'filename',
          color = function()
            if vim.bo.modified then
              return { bg = '#fdaa88', fg = 'black' }
            end
            return { fg = 'white' }
          end,

          file_status = true,    -- Displays file status (readonly status, modified status)
          newfile_status = true, -- Display new file status (new file means no write after created)
          path = 3,              -- 0: Just the filename
          symbols = {
            modified = '',
            readonly = '[--]',
            unnamed = '[No Name]',
            newfile = '[New]',
          }
        },
      }

      local lualine_c                  = {
        {
          function()
            return " "
          end,
          padding = 1000,
        },
      }

      local go_get_current_buildtarget = require('buildtargets').get_current_buildtarget
      local lualine_x                  = {
        {
          'filetype',
          fmt = function(str)
            if str == 'go' then
              local buildtarget = go_get_current_buildtarget()
              if buildtarget then
                return buildtarget
              end
            end
            return str
          end,

          color = { fg = 'white', bg = 'black', gui = 'bold' }
        },
      }

      local lualine_z                  = {
        {
          'location',
          color = { fg = 'white', bg = 'black', gui = 'bold' }
        },
      }
      local lualine_y                  = { 'progress' }

      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = custom_gruvbox,
        },
        sections = {
          lualine_a = {
            {
              'mode',
              fmt = function(str)
                return str:sub(1, 1)
              end,
            },
          },
          lualine_b = lualine_b,
          lualine_c = lualine_c,
          lualine_x = lualine_x,
          lualine_y = lualine_y,
          lualine_z = lualine_z,
        },
        inactive_sections = {
          -- lualine_a = {},
          lualine_b = lualine_b,
          lualine_c = lualine_c,
          lualine_x = lualine_x,
          lualine_y = lualine_y,
          lualine_z = lualine_z,
        },
      }
    end
  },
}

