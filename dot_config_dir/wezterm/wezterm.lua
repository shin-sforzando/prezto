local wezterm = require 'wezterm';

wezterm.on("window-config-reloaded", function(window, pane)
  window:toast_notification("wezterm", "Configuration reloaded!", nil, 4000)
end)

wezterm.on("update-right-status", function(window, pane)
	local cwd_uri = pane:get_current_working_dir()
	local cwd = ""
	local hostname = ""
	if cwd_uri then
		cwd_uri = cwd_uri:sub(8)
		local slash = cwd_uri:find("/")
		if slash then
			hostname = cwd_uri:sub(1, slash - 1)
			-- Remove the domain name portion of the hostname
			local dot = hostname:find("[.]")
			if dot then
				hostname = hostname:sub(1, dot - 1)
			end
			if hostname ~= "" then
				hostname = "@" .. hostname
			end
			-- and extract the cwd from the uri
			cwd = utils.convert_home_dir(cwd)
		end
	end

	window:set_right_status(wezterm.format({
		{ Attribute = { Underline = "Single" } },
		{ Attribute = { Italic = true } },
		{ Text = cwd .. hostname },
	}))
end)

return {
  use_ime = true,
  scrollback_lines = 99999,
  font = wezterm.font("HackGen35Nerd", {weight="Regular", stretch="Normal", italic=false}),
  font_size = 13.0,
  adjust_window_size_when_changing_font_size = false,
  color_scheme = "Builtin Pastel Dark",
  window_background_opacity = 0.67,
  hide_tab_bar_if_only_one_tab = true,
  exit_behavior = "CloseOnCleanExit",
}
