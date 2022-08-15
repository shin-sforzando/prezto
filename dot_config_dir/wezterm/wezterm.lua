local wezterm = require 'wezterm';

wezterm.on("window-config-reloaded", function(window, pane)
  window:toast_notification("wezterm", "Configuration reloaded!", nil, 4000)
end)

return {
  use_ime = true,
  default_cursor_style = "BlinkingBlock",
  scrollback_lines = 99999,
  font = wezterm.font_with_fallback {
	"Firge35Nerd Console",
	"mononoki Nerd Font Mono",
	"HackGen35 Console NFJ"
  },
  font_size = 13.0,
  adjust_window_size_when_changing_font_size = false,
  initial_rows = 48,
  initial_cols = 160,
  color_scheme = "Builtin Pastel Dark",
  window_background_opacity = 0.67,
  use_fancy_tab_bar = false,
  hide_tab_bar_if_only_one_tab = true,
  exit_behavior = "CloseOnCleanExit",
  window_close_confirmation = "NeverPrompt",
  keys = {
    {key="d", mods="SUPER", action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
    {key="d", mods="SUPER|SHIFT",  action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
  }
}
