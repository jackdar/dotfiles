local wezterm = require 'wezterm'

local theme = {
  none = '',
  gruvbox = 'GruvboxDarkHard',
  onedark = 'OneDark',
  rosepine = 'rose-pine',
  nord = 'Nord',
}

local fonts = {
  blexmono = 'BlexMono Nerd Font Mono',
  fira = 'FiraCode Nerd Font Mono',
  jetbrains = 'JetBrainsMono Nerd Font Mono',
}

local selected = {
  theme = theme.none,
  font = fonts.blexmono,
}

local config = wezterm.config_builder()

config = {
  automatically_reload_config = true,
  enable_tab_bar = false,
  window_decorations = 'RESIZE',
  window_close_confirmation = 'NeverPrompt',
  color_scheme = selected.theme,
  font = wezterm.font {
    family = selected.font,
    weight = 400,
  },
  freetype_load_target = 'Light',
  font_size = 18,
  window_background_opacity = 0.9,
  initial_cols = 160,
  initial_rows = 40,
}

return config
