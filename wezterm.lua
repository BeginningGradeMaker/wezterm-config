local Config = require('config')

require('utils.backdrops'):set_files()
--
-- require('events.right-status').setup()
-- require('events.tab-title').setup()
-- require('events.new-tab-button').setup()
require("events.tabline")

-- local workspace_switcher = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")
-- workspace_switcher.apply_to_config(Config)

return Config:init()
   :append(require('config.appearance'))
   :append(require('config.bindings'))
   :append(require('config.domains'))
   :append(require('config.fonts'))
   :append(require('config.general'))
   :append(require('config.launch')).options
