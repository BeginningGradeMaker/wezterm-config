local wezterm = require('wezterm')
local platform = require('utils.platform')

local font = 'JetBrainsMono Nerd Font'
local font_size = platform().is_mac and 15.5 or 9

return {
   font = wezterm.font(font),
   harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
   font_size = font_size,

   --ref: https://wezfurlong.org/wezterm/config/lua/config/freetype_pcf_long_family_names.html#why-doesnt-wezterm-use-the-distro-freetype-or-match-its-configuration
   freetype_load_target = 'Normal', ---@type 'Normal'|'Light'|'Mono'|'HorizontalLcd'
   freetype_render_target = 'Normal', ---@type 'Normal'|'Light'|'Mono'|'HorizontalLcd'
}
