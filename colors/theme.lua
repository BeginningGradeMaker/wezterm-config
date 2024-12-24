-- A slightly altered version of catppucchin mocha
local mocha = {
   rosewater = '#f5e0dc',
   flamingo = '#f2cdcd',
   pink = '#f5c2e7',
   mauve = '#cba6f7',
   red = '#f38ba8',
   maroon = '#eba0ac',
   peach = '#fab387',
   yellow = '#f9e2af',
   green = '#a6e3a1',
   teal = '#94e2d5',
   sky = '#89dceb',
   sapphire = '#74c7ec',
   blue = '#89b4fa',
   lavender = '#b4befe',
   text = '#cdd6f4',
   subtext1 = '#bac2de',
   subtext0 = '#a6adc8',
   overlay2 = '#9399b2',
   overlay1 = '#7f849c',
   overlay0 = '#6c7086',
   surface2 = '#585b70',
   surface1 = '#45475a',
   surface0 = '#313244',
   -- base = '#1f1f28',
   base = '#1f1f2a',
   mantle = '#181825',
   crust = '#11111b',
}

local neofusion_theme = {
   foreground = '#e0d9c7',
   background = '#070f1c',
   cursor_bg = '#e0d9c7',
   cursor_border = '#e0d9c7',
   cursor_fg = '#070f1c',
   selection_bg = '#ea6847',
   selection_fg = '#e0d9c7',
   ansi = {
      '#070f1c', -- Black (Host)
      '#ea6847', -- Red (Syntax string)
      '#ea6847', -- Green (Command)
      '#5db2f8', -- Yellow (Command second)
      '#2f516c', -- Blue (Path)
      '#d943a8', -- Magenta (Syntax var)
      '#86dbf5', -- Cyan (Prompt)
      '#e0d9c7', -- White
   },
   brights = {
      '#2f516c', -- Bright Black
      '#d943a8', -- Bright Red (Command error)
      '#ea6847', -- Bright Green (Exec)
      '#86dbf5', -- Bright Yellow
      '#5db2f8', -- Bright Blue (Folder)
      '#d943a8', -- Bright Magenta
      '#ea6847', -- Bright Cyan
      '#e0d9c7', -- Bright White
   },
}

local colorscheme = {
   foreground = mocha.text,
   background = mocha.base,
   cursor_bg = mocha.rosewater,
   cursor_border = mocha.rosewater,
   cursor_fg = mocha.crust,
   selection_bg = mocha.surface2,
   selection_fg = mocha.text,
   ansi = {
      '#0C0C0C', -- black
      '#C50F1F', -- red
      '#13A10E', -- green
      '#C19C00', -- yellow
      '#0037DA', -- blue
      '#881798', -- magenta/purple
      '#3A96DD', -- cyan
      '#CCCCCC', -- white
   },
   brights = {
      '#767676', -- black
      '#E74856', -- red
      '#16C60C', -- green
      '#F9F1A5', -- yellow
      '#3B78FF', -- blue
      '#B4009E', -- magenta/purple
      '#61D6D6', -- cyan
      '#F2F2F2', -- white
   },
   tab_bar = {
      background = 'rgba(0, 0, 0, 0.4)',
      -- background = 'rgba(0, 0, 0)',
      active_tab = {
         bg_color = mocha.surface2,
         fg_color = mocha.text,
      },
      inactive_tab = {
         bg_color = mocha.surface0,
         fg_color = mocha.subtext1,
      },
      inactive_tab_hover = {
         bg_color = mocha.surface0,
         fg_color = mocha.text,
      },
      new_tab = {
         bg_color = mocha.base,
         fg_color = mocha.text,
      },
      new_tab_hover = {
         bg_color = mocha.mantle,
         fg_color = mocha.text,
         italic = true,
      },
   },
   visual_bell = mocha.surface0,
   indexed = {
      [16] = mocha.peach,
      [17] = mocha.rosewater,
   },
   scrollbar_thumb = mocha.surface2,
   split = mocha.overlay0,
   compose_cursor = mocha.flamingo, -- nightbuild only
}

-- Same with gruvbox-material.nvim
local gruvbox = {
   -- bg_dim = '#1b1b1b',
   -- bg0 = '#282828',
   -- bg1 = '#32302f',
   -- bg2 = '#32302f',
   -- bg3 = '#45403d',
   -- bg4 = '#45403d',
   -- bg5 = '#5a524c',
   -- bg_statusline1 = '#32302f',
   -- bg_statusline2 = '#3a3735',
   -- bg_statusline3 = '#504945',
   -- bg_diff_green = '#34381b',
   -- bg_visual_green = '#3b4439',
   -- bg_diff_red = '#402120',
   -- bg_visual_red = '#4c3432',
   -- bg_diff_blue = '#0e363e',
   -- bg_visual_blue = '#374141',
   -- bg_visual_yellow = '#4f422e',
   -- bg_current_word = '#3c3836',
   -- fg0 = '#d4be98',
   -- fg1 = '#ddc7a1',
   -- red = '#ea6962',
   -- bg_red = '#ea6962',
   -- orange = '#e78a4e',
   -- yellow = '#d8a6757',
   -- bg_yellow = '#d8a6757',
   -- green = '#a9b665',
   -- aqua = '#89b482',
   -- blue = '#7daea3',
   -- purple = '#d3869b',
   -- grey0 = '#7c6f64',
   -- grey1 = '#928374',
   -- grey2 = '#a89984',
   foreground = '#D4BE98',
   background = '#282828',
   cursor_bg = '#D4BE98',
   cursor_border = '#D4BE98',
   cursor_fg = '#1D2021',
   selection_bg = '#D4BE98',
   selection_fg = '#3C3836',
   tab_bar = {
      background = '#32302f',
      inactive_tab = { bg_color = '#32302f', fg_color = "#ddc7a1" },
      inactive_tab_hover = { bg_color = '#32302f', fg_color = "#ddc7a1" },
      active_tab = { bg_color = "#a89984", fg_color = "#000000"}
   },

   ansi = { '#1d2021', '#ea6962', '#a9b665', '#d8a657', '#7daea3', '#d3869b', '#89b482', '#d4be98' },
   brights = {
      '#eddeb5',
      '#ea6962',
      '#a9b665',
      '#d8a657',
      '#7daea3',
      '#d3869b',
      '#89b482',
      '#d4be98',
   },
}

Color = "Catppuccin Mocha"

return require('wezterm').color.get_builtin_schemes()[Color]
-- return gruvbox
