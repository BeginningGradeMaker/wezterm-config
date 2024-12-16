local wezterm = require('wezterm')
local grey = '#949cbb'

local tabline = wezterm.plugin.require('https://github.com/michaelbrusegard/tabline.wez')
local colorscheme = wezterm.color.get_builtin_schemes()['Catppuccin Frappe']
tabline.setup({
   options = {
      icons_enabled = true,
      theme = 'Catppuccin Frappe',
      color_overrides = {
         normal_mode = {
            -- a = { fg = colorscheme.foreground, bg = colorscheme.background },
            -- b = { fg = colorscheme.foreground, bg = colorscheme.background },
            -- c = { fg = colorscheme.foreground, bg = colorscheme.background },
            x = { fg = grey },
         },
         -- copy_mode = {
         --    a = { fg = colorscheme.foreground, bg = colorscheme.background },
         --    b = { fg = colorscheme.foreground, bg = colorscheme.background },
         --    c = { fg = colorscheme.foreground, bg = colorscheme.background },
         -- },
         -- search_mode = {
         --    a = { fg = colorscheme.foreground, bg = colorscheme.background },
         --    b = { fg = colorscheme.foreground, bg = colorscheme.background },
         --    c = { fg = colorscheme.foreground, bg = colorscheme.background },
         -- },
         -- -- Defining colors for a new key table
         -- window_mode = {
         --    a = { fg = colorscheme.foreground, bg = colorscheme.background },
         --    b = { fg = colorscheme.foreground, bg = colorscheme.background },
         --    c = { fg = colorscheme.foreground, bg = colorscheme.background },
         -- },
         tab = {
            -- active = { fg = '#8caaee', bg = colorscheme.background },
            -- active = { fg = colorscheme.foreground, bg = colorscheme.background },
            -- active = { bg = '#98c379', fg = colorscheme.tab_bar.background }, -- Catppuccin
            inactive = { fg = '#949cbb' },
            -- inactive_hover = { bg = colorscheme.background },
            -- inactive_hover = { fg = colors.ansi[6], bg = colors.background },
         },
      },
   },
   sections = {
      tabline_a = { 'mode' },
      tabline_b = { 'workspace' },
      tabline_c = { ' ' },
      tab_active = {
         'index',
         -- { 'parent', padding = 0 },
         -- '/',
         { 'cwd', padding = { left = 0, right = 1 } },
         { 'zoomed', padding = 0 },
      },
      tab_inactive = { 'index', { 'cwd', padding = { left = 0, right = 1 } } },
      tabline_x = { 'ram', 'cpu' },
      tabline_y = { 'datetime' },
      tabline_z = { 'battery' },
   },
   extensions = {},
})
