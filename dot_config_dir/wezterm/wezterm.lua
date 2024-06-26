local wezterm = require 'wezterm';

wezterm.on("window-config-reloaded", function(window, pane)
  window:toast_notification("wezterm", "Configuration reloaded!", nil, 3000)
end)

return {
  use_ime = true,
  default_cursor_style = "BlinkingBlock",
  scrollback_lines = 99999,
  font = wezterm.font_with_fallback {
	"mononoki Nerd Font Mono",
	"HackGen35 Console NFJ"
  },
  font_size = 14.0,
  adjust_window_size_when_changing_font_size = false,
  initial_rows = 50,
  initial_cols = 200,
  color_scheme = "Builtin Pastel Dark",
  window_background_opacity = 0.67,
  use_fancy_tab_bar = false,
  hide_tab_bar_if_only_one_tab = true,
  exit_behavior = "CloseOnCleanExit",
  window_close_confirmation = "NeverPrompt",
  hyperlink_rules = {
    {
      regex = "\\b\\w+://(?:[\\w.-\\.]+):\\d+\\S*\\b",
      format = "$0",
    }
  },
  keys = {
    {key="d", mods="SUPER", action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
    {key="d", mods="SUPER|SHIFT",  action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
  }
}
