local wezterm = require 'wezterm'
local act = wezterm.action

local M = {}

M.globalsPath = os.getenv 'HOME' .. '/.config/wezterm/globals.toml'
M.scriptsPath = os.getenv 'HOME' .. '/.config/wezterm/scripts/'

M.runScript = function(script, args)
  wezterm.background_child_process { M.scriptsPath .. script, args and args }
end

M.getGlobals = function()
  local file = assert(io.open(M.globalsPath, 'r'))
  local globals = file:read '*all'
  file:close()
  return wezterm.serde.toml_decode(globals)
end

M.cmd_to_tmux_prefix = function(key, tmux_key)
  return {
    mods = 'CMD',
    key = key,
    action = act.Multiple {
      act.SendKey { mods = 'CTRL', key = 's' },
      act.SendKey { key = tmux_key },
    },
  }
end

M.font_switcher = function()
  M.runScript 'font-switcher.sh'
end

M.theme_switcher = function()
  M.runScript 'theme-switcher.sh'
end

M.global_bg = function()
  return act.PromptInputLine {
    description = 'Enter a global bg color! 🎨',
    action = wezterm.action_callback(function(_, _, line)
      if line == '' then
        M.runScript 'clear-global-bg.zsh'
      elseif line then
        M.runScript('update-global-bg.zsh', line)
      end
    end),
  }
end

M.increaseOpacity = function()
  M.runScript 'inc-opacity.zsh'
end
M.decreaseOpacity = function()
  M.runScript 'dec-opacity.zsh'
end
M.resetOpacity = function()
  M.runScript 'reset-opacity.zsh'
end

M.toggleOLED = function()
  M.runScript 'toggle-oled.zsh'
end

return M
