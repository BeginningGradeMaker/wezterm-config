local wezterm = require('wezterm')
local grey = '#949cbb'

local tabline = wezterm.plugin.require('https://github.com/michaelbrusegard/tabline.wez')
tabline.setup({
   options = {
      icons_enabled = true,
      theme = Color,
      -- Catppuccin
      color_overrides = {
         normal_mode = {
            x = { fg = grey },
         },
         tab = {
            inactive = { fg = grey },
         },
      },
      -- Gruvbox Material
      -- color_overrides = {
      --    normal_mode = {
      --       a = { fg = colorscheme.cursor_fg, bg = "#a89984" },
      --       b = { fg = "#d4be98", bg = "#5a524c" },
      --       c = { fg = colorscheme.foreground, bg = colorscheme.tab_bar.background },
      --       x = { fg = colorscheme.foreground },
      --    },
      --    tab = {
      --       -- active = { fg = '#8caaee', bg = colorscheme.background },
      --       -- active = { fg = colorscheme.foreground, bg = colorscheme.background },
      --       active = { bg = colorscheme.tab_bar.active_tab.bg_color, fg = colorscheme.tab_bar.active_tab.fg_color },
      --       inactive = { bg = colorscheme.tab_bar.inactive_tab.bg_color, fg = colorscheme.tab_bar.inactive_tab.fg_color, },
      --       inactive_hover = { bg = colorscheme.tab_bar.inactive_tab_hover.bg_color, fg = colorscheme.tab_bar.inactive_tab_hover.fg_color },
      --       -- inactive_hover = { fg = colors.ansi[6], bg = colors.background },
      --    },
      -- },
   },
   sections = {
      tabline_a = { 'mode' },
      -- tabline_b = { 'workspace' },
      tabline_b = {},
      tabline_c = { ' ' },
      tab_active = {
         'index',
         -- { 'parent', padding = 0 },
         -- '/',
         { 'cwd', padding = { left = 0, right = 1 } },
         { 'zoomed', padding = 0 },
      },
      tab_inactive = { 'index', { 'cwd', padding = { left = 0, right = 1 } } },
      -- tabline_x = { 'ram', 'cpu' },
      -- tabline_y = { 'datetime' },
      -- tabline_z = { 'battery' },
      tabline_x = {},
      tabline_y = {},
      tabline_z = {},
   },
   extensions = {},
})
