local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config = {
  automatically_reload_config = true,
  enable_tab_bar = false,
  window_close_confirmation = 'NeverPrompt',
  window_decorations = 'RESIZE',
  color_scheme = 'Catppuccin Macchiato (Gogh)',
  font = wezterm.font {
    family = 'BlexMono Nerd Font Mono',
    weight = 'Medium',
  },
  freetype_load_target = 'Light',
  font_size = 18,
  -- window_background_opacity = 0.8,
  initial_cols = 160,
  initial_rows = 40,
}

return config
