local wezterm = require('wezterm')
local platform = require('utils.platform')()
local backdrops = require('utils.backdrops')
local act = wezterm.action

local resurrect = wezterm.plugin.require('https://github.com/MLFlexer/resurrect.wezterm')
-- resurrect.init_directories()
resurrect.periodic_save()
local workspace_state = resurrect.workspace_state
local workspace_switcher =
   wezterm.plugin.require('https://github.com/MLFlexer/smart_workspace_switcher.wezterm')

local mod = {}

if platform.is_mac then
   mod.SUPER = 'SUPER'
   mod.SUPER_REV = 'SUPER|CTRL'
elseif platform.is_win or platform.is_linux then
   mod.SUPER = 'ALT' -- to not conflict with Windows key shortcuts
   mod.SUPER_REV = 'ALT|CTRL'
end

-- stylua: ignore
local keys = {
    -- misc/useful --
    { key = 'F1', mods = 'NONE', action = 'ActivateCopyMode' },
    { key = 'F2', mods = 'NONE', action = act.ActivateCommandPalette },
    { key = 'F3', mods = 'NONE', action = act.ShowLauncher },
    { key = 'F4', mods = 'NONE', action = act.ShowLauncherArgs({ flags = 'FUZZY|TABS' }) },
    {
        key = 'F5',
        mods = 'NONE',
        action = act.ShowLauncherArgs({ flags = 'FUZZY|WORKSPACES' }),
    },
    -- toggle fullscreen
    { key = 'F11', mods = 'NONE',    action = act.ToggleFullScreen },
    { key = 'F12', mods = 'NONE',    action = act.ShowDebugOverlay },
    { key = 'f',   mods = mod.SUPER, action = act.Search({ CaseInSensitiveString = '' }) },
    {
        key = 'u',
        mods = mod.SUPER,
        action = wezterm.action.QuickSelectArgs({
            label = 'open url',
            patterns = {
                'https?://\\S+',
            },
            action = wezterm.action_callback(function(window, pane)
                local url = window:get_selection_text_for_pane(pane)
                wezterm.log_info('opening: ' .. url)
                wezterm.open_with(url)
            end),
        }),
    },

    -- copy/paste --
    { key = 'c', mods = 'CTRL|SHIFT',  action = act.CopyTo('Clipboard') },
    { key = 'v', mods = 'CTRL|SHIFT',  action = act.PasteFrom('Clipboard') },

    -- tabs --
    -- tabs: spawn+close
    { key = 't', mods = mod.SUPER,     action = act.SpawnTab('DefaultDomain') },
    { key = 't', mods = mod.SUPER_REV, action = act.SpawnTab({ DomainName = 'WSL:Ubuntu' }) },
    { key = 'w', mods = mod.SUPER_REV, action = act.CloseCurrentTab({ confirm = true }) },

    -- tabs: navigation
    { key = '[', mods = mod.SUPER,     action = act.ActivateTabRelative(-1) },
    { key = ']', mods = mod.SUPER,     action = act.ActivateTabRelative(1) },
    { key = 'h', mods = mod.SUPER,     action = act.ActivateTabRelative(-1) },
    { key = 'l', mods = mod.SUPER,     action = act.ActivateTabRelative(1) },
    { key = '[', mods = mod.SUPER_REV, action = act.MoveTabRelative(-1) },
    { key = ']', mods = mod.SUPER_REV, action = act.MoveTabRelative(1) },

    -- window --
    -- spawn windows
    { key = 'n', mods = mod.SUPER,     action = act.SpawnWindow },
    { key = 'q', mods = 'CMD',         action = act.QuitApplication },
    -- { key = 'q', mods = mod.SUPER_REV, action = wezterm.action.QuitApplication },
    -- background controls --
    {
        key = [[/]],
        mods = mod.SUPER,
        action = wezterm.action_callback(function(window, _pane)
            backdrops:random(window)
        end),
    },
    {
        key = [[,]],
        mods = mod.SUPER,
        action = wezterm.action_callback(function(window, _pane)
            backdrops:cycle_back(window)
        end),
    },
    {
        key = [[.]],
        mods = mod.SUPER,
        action = wezterm.action_callback(function(window, _pane)
            backdrops:cycle_forward(window)
        end),
    },
    {
        key = [[/]],
        mods = mod.SUPER_REV,
        action = act.InputSelector({
            title = 'Select Background',
            choices = backdrops:choices(),
            fuzzy = true,
            fuzzy_description = 'Select Background: ',
            action = wezterm.action_callback(function(window, _pane, idx)
                ---@diagnostic disable-next-line: param-type-mismatch
                backdrops:set_img(window, tonumber(idx))
            end),
        }),
    },

    -- panes --
    -- panes: split panes
    {
        key = [[\]],
        mods = mod.SUPER,
        action = act.SplitVertical({ domain = 'CurrentPaneDomain' }),
    },
    {
        key = [[\]],
        mods = mod.SUPER_REV,
        action = act.SplitHorizontal({ domain = 'CurrentPaneDomain' }),
    },

    -- panes: zoom+close pane
    { key = 'Enter', mods = mod.SUPER,     action = act.TogglePaneZoomState },
    { key = 'w',     mods = mod.SUPER,     action = act.CloseCurrentPane({ confirm = false }) },

    -- panes: navigation
    { key = 'k',     mods = mod.SUPER_REV, action = act.ActivatePaneDirection('Up') },
    { key = 'j',     mods = mod.SUPER_REV, action = act.ActivatePaneDirection('Down') },
    { key = 'h',     mods = mod.SUPER_REV, action = act.ActivatePaneDirection('Left') },
    { key = 'l',     mods = mod.SUPER_REV, action = act.ActivatePaneDirection('Right') },
    { key = 'K',     mods = mod.SUPER,     action = act.ActivatePaneDirection('Up') },
    { key = 'J',     mods = mod.SUPER,     action = act.ActivatePaneDirection('Down') },
    { key = 'H',     mods = mod.SUPER,     action = act.ActivatePaneDirection('Left') },
    { key = 'L',     mods = mod.SUPER,     action = act.ActivatePaneDirection('Right') },
    {
        key = 'p',
        mods = mod.SUPER_REV,
        action = act.PaneSelect({ alphabet = '1234567890', mode = 'SwapWithActiveKeepFocus' }),
    },

    -- key-tables --
    -- resizes fonts
    {
        key = 'f',
        mods = 'LEADER',
        action = act.ActivateKeyTable({
            name = 'resize_font',
            one_shot = false,
            timemout_miliseconds = 1000,
        }),
    },
    -- resize panes
    {
        key = 'p',
        mods = 'LEADER',
        action = act.ActivateKeyTable({
            name = 'resize_pane',
            one_shot = false,
            timemout_miliseconds = 1000,
        }),
    },
    { mods = "OPT", key = "LeftArrow",  action = act.SendKey({ mods = "ALT", key = "b" }) },
    { mods = "OPT", key = "RightArrow", action = act.SendKey({ mods = "ALT", key = "f" }) },
    { mods = "CMD", key = "LeftArrow",  action = act.SendKey({ mods = "CTRL", key = "a" }) },
    { mods = "CMD", key = "RightArrow", action = act.SendKey({ mods = "CTRL", key = "e" }) },
    { mods = "CMD", key = "Backspace",  action = act.SendKey({ mods = "CTRL", key = "u" }) },
    {
        key = 'o',
        mods = 'CMD',
        action = wezterm.action.ActivateLastTab,
    },
    { key = 'm',         mods = 'CMD',   action = wezterm.action.HideApplication },
    -- {
    --     key = "s",
    --     mods = mod.SUPER_REV,
    --     action = wezterm.action.Multiple({
    --         wezterm.action_callback(function(win, pane)
    --             resurrect.save_state(workspace_state.get_workspace_state(), pane.get_current_working_dir())
    --         end),
    --     }),
    -- },
    -- {
    --     key = "l",
    --     mods = mod.SUPER_REV,
    --     action = wezterm.action.Multiple({
    --         wezterm.action_callback(function(win, pane)
    --             resurrect.fuzzy_load(win, pane, function(id, label)
    --                 id = string.match(id, "([^/]+)$")
    --                 id = string.match(id, "(.+)%..+$")
    --                 local state = resurrect.load_state(id, "workspace")
    --                 workspace_state.restore_workspace(state, {
    --                     relative = true,
    --                     restore_text = true,
    --                     on_pane_restore = resurrect.tab_state.default_on_pane_restore,
    --                 })
    --             end)
    --         end),
    --     }),
    -- },
    -- {
    --     key = "s",
    --     mods = mod.SUPER,
    --     action = workspace_switcher.switch_workspace(),
    -- },
    { key = 'UpArrow',   mods = 'SHIFT', action = act.ScrollByLine(-1) },
    { key = 'DownArrow', mods = 'SHIFT', action = act.ScrollByLine(1) },
    { key = 'UpArrow',   mods = 'CMD', action = act.ScrollToTop },
    { key = 'DownArrow', mods = 'CMD', action = act.ScrollToBottom },
}

-- loads the state whenever I create a new workspace
wezterm.on('smart_workspace_switcher.workspace_switcher.created', function(window, path, label)
   resurrect.workspace_state.restore_workspace(resurrect.load_state(label, 'workspace'), {
      window = window,
      relative = true,
      restore_text = true,
      on_pane_restore = resurrect.tab_state.default_on_pane_restore,
   })
end)

-- Saves the state whenever I select a workspace
wezterm.on('smart_workspace_switcher.workspace_switcher.selected', function(window, path, label)
   resurrect.workspace_state.resurrect.save_state(workspace_state.get_workspace_state())
end)

-- stylua: ignore
local key_tables = {
    resize_font = {
        { key = 'k',      action = act.IncreaseFontSize },
        { key = 'j',      action = act.DecreaseFontSize },
        { key = 'r',      action = act.ResetFontSize },
        { key = 'Escape', action = 'PopKeyTable' },
        { key = 'q',      action = 'PopKeyTable' },
    },
    resize_pane = {
        { key = 'k',      action = act.AdjustPaneSize({ 'Up', 1 }) },
        { key = 'j',      action = act.AdjustPaneSize({ 'Down', 1 }) },
        { key = 'h',      action = act.AdjustPaneSize({ 'Left', 1 }) },
        { key = 'l',      action = act.AdjustPaneSize({ 'Right', 1 }) },
        { key = 'Escape', action = 'PopKeyTable' },
        { key = 'q',      action = 'PopKeyTable' },
    },
}

local mouse_bindings = {
   -- Ctrl-click will open the link under the mouse cursor
   {
      event = { Up = { streak = 1, button = 'Left' } },
      mods = 'CTRL',
      action = act.OpenLinkAtMouseCursor,
   },
}

return {
   disable_default_key_bindings = false,
   leader = { key = 'Space', mods = mod.SUPER_REV },
   keys = keys,
   key_tables = key_tables,
   mouse_bindings = mouse_bindings,
}
