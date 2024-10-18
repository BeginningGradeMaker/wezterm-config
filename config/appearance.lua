local wezterm = require('wezterm')
local gpu_adapters = require('utils.gpu_adapter')
local colors = require('colors.custom')
local fonts = require('config.fonts')
local colorscheme = wezterm.color.get_builtin_schemes()["Catppuccin Frappe"]
-- colorscheme.tab_bar.background = '#1c1b19'


return {
   animation_fps = 120,
   max_fps = 120,
   front_end = 'WebGpu',
   webgpu_power_preference = 'HighPerformance',
   webgpu_preferred_adapter = gpu_adapters:pick_best(),
   enable_kitty_keyboard = true,

   -- color scheme
   colors = colorscheme,
   -- color_scheme = 'Tokyo Night Moon',
   -- color_scheme = 'Catppuccin Mocha',
   -- color_scheme = 'Catppuccin Frappe',

   -- background
   background = {
      {
         source = { File = wezterm.GLOBAL.background },
      },
      {
         source = { Color = colors.background },
         height = '100%',
         width = '100%',
         opacity = 0.95,
         -- opacity = 1,
      },
   },

   -- window_background_opacity = 0.5,
   macos_window_background_blur = 20,

   -- scrollbar
   enable_scroll_bar = true,

   -- tab bar
   enable_tab_bar = true,
   hide_tab_bar_if_only_one_tab = false,
   use_fancy_tab_bar = false,
   tab_max_width = 25,
   show_tab_index_in_tab_bar = false,
   switch_to_last_active_tab_when_closing_tab = true,
   tab_and_split_indices_are_zero_based = false,

   -- window
   window_padding = {
      left = 5,
      right = '1cell',
      top = 12,
      bottom = 7,
   },
   -- window_close_confirmation = 'NeverPrompt',
   window_frame = {
      -- active_titlebar_bg = '#090909', -- Tokyonight
      active_titlebar_bg = '#89b4fa', -- Catppuccin Mocha
      font = fonts.font,
      font_size = fonts.font_size,
   },
   inactive_pane_hsb = {
      -- saturation = 0.9,
      -- brightness = 0.65,
   },
   show_new_tab_button_in_tab_bar = false,
}
