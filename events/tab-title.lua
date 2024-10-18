local wezterm = require('wezterm')

-- Inspired by https://github.com/wez/wezterm/discussions/628#discussioncomment-1874614

local GLYPH_SEMI_CIRCLE_LEFT = '' -- nf.ple_left_half_circle_thick
local GLYPH_SEMI_CIRCLE_RIGHT = '' -- nf.ple_right_half_cirlce_thick
-- local GLYPH_CIRCLE = '' -- nf.fa_circle
local GLYPH_CIRCLE = '' -- nf.fa_circle
local GLYPH_ADMIN = '󰞀' -- nf.md_shield_half_full

local M = {}

local __cells__ = {}

local colorscheme = wezterm.color.get_builtin_schemes()["Catppuccin Frappe"]
-- colorscheme.tab_bar.background = '#1c1b19'

local colors = {
   default = { bg = '#45475a', fg = colorscheme.tab_bar.background },
   -- is_active = { bg = '#7FB4CA', fg = '#11111b', },
   -- is_active = { bg = '#89b4fa', fg = '#11111b', }, -- Catppuccin
   is_active = { bg = '#98c379', fg = colorscheme.tab_bar.background }, -- Catppuccin
   -- hover = { bg = '#587d8c', fg = '#1c1b19', },
   hover = { bg = '#a8c3a9', fg = colorscheme.tab_bar.background },
}

local _set_process_name = function(s)
   local a = string.gsub(s, '(.*[/\\])(.*)', '%2')
   return a:gsub('%.exe$', '')
end

local _set_title = function(process_name, base_title, max_width, inset)
   local title
   inset = inset or 6

   if process_name:len() > 0 then
      title = process_name
   else
      title = base_title
   end

   -- if title:len() > max_width - inset then
   --    local diff = title:len() - max_width + inset
   --    title = wezterm.truncate_right(title, title:len() - diff)
   -- end

   return title
end

local _check_if_admin = function(p)
   if p:match('^Administrator: ') then
      return true
   end
   return false
end

---@param fg string
---@param bg string
---@param attribute table
---@param text string
local _push = function(bg, fg, attribute, text)
   table.insert(__cells__, { Background = { Color = bg } })
   table.insert(__cells__, { Foreground = { Color = fg } })
   table.insert(__cells__, { Attribute = attribute })
   table.insert(__cells__, { Text = text })
end

M.setup = function()
   wezterm.on('format-tab-title', function(tab, _tabs, panes_, config, hover, max_width)
      if config.use_fancy_tab_bar or not config.enable_tab_bar then
         return
      end
      __cells__ = {}

      local bg
      local fg
      -- local lfs = require("lfs")
      -- local current_dir = lfs.currentdir()
      local active_pane = tab.active_pane
      local trimmed_path = active_pane.current_working_dir.file_path:gsub('[/\\]*$', '')
      local index = trimmed_path:find('[^/\\]*$')
      local cwd = index and trimmed_path:sub(index) or trimmed_path

      local process_name = _set_process_name(tab.active_pane.foreground_process_name)
      local is_admin = _check_if_admin(tab.active_pane.title)
      local title = _set_title(cwd, tab.active_pane.title, max_width, (is_admin and 8))

      if tab.is_active then
         bg = colors.is_active.bg
         fg = colors.is_active.fg
      elseif hover then
         bg = colors.hover.bg
         fg = colors.hover.fg
      else
         bg = colors.default.bg
         fg = colors.default.fg
      end

      -- local has_unseen_output = false
      -- for _, pane in ipairs(tab.panes) do
      --    if pane.has_unseen_output then
      --       has_unseen_output = true
      --       break
      --    end
      -- end

      -- Block: █

      -- Left semi-circle
      local tab_idx = tab.tab_index
      local sep = (tab_idx == 0 and '▐') or ''
      _push(fg, bg, { Intensity = 'Bold' }, sep)

      -- Admin Icon
      if is_admin then
         _push(bg, fg, { Intensity = 'Bold' }, ' ' .. GLYPH_ADMIN)
      end

      -- Title
      _push(bg, fg, { Intensity = 'Bold' }, ' ' .. title)

      -- Unseen output alert
      -- if has_unseen_output then
      --    _push(bg, '#FFA066', { Intensity = 'Bold' }, ' ' .. GLYPH_CIRCLE)
      -- end

      -- Right padding
      _push(bg, fg, { Intensity = 'Bold' }, ' ')

      -- Right semi-circle
      _push(fg, bg, { Intensity = 'Bold' }, '')

      return __cells__
   end)
end

return M
