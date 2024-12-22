local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config = {
  automatically_reload_config = true,
  enable_tab_bar = false,
  window_decorations = 'RESIZE',
  window_close_confirmation = 'NeverPrompt',
  color_scheme = 'GruvboxDarkHard',
  font = wezterm.font {
    family = 'BlexMono Nerd Font Mono',
    weight = 400,
  },
  freetype_load_target = 'Light',
  font_size = 18,
  -- window_background_opacity = 0.8,
  initial_cols = 160,
  initial_rows = 40,
}

return config
