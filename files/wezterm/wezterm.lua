-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.enable_wayland = true

config.xcursor_theme = "Qogir Recolored Catppuccin Pink"
config.default_cursor_style = 'BlinkingBar'

-- config.front_end = "WebGpu"
-- config.webgpu_force_fallback_adapter = true

config.color_scheme = 'Catppuccin Mocha'
config.hide_tab_bar_if_only_one_tab = true

config.window_padding = {
  left = 20,
  right = 20,
  top = 10,
  bottom = 10,
}


-- config.font = wezterm.font('SpaceMono Nerd Font', { style = 'Regular' })
config.font = wezterm.font 'SpaceMono Nerd Font'
config.font_size = 12.5

config.keys = {
  -- Turn off the default CMD-m Hide action, allowing CMD-m to
  -- be potentially recognized and handled by the tab
  {
    key = 'c',
    mods = 'CTRL',
    action = wezterm.action.CopyTo 'ClipboardAndPrimarySelection',
  },

  {
      key = 'v',
      mods = 'CTRL',
      action = wezterm.action.PasteFrom 'PrimarySelection'
  },
}

-- and finally, return the configuration to wezterm
return config

