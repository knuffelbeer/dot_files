-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")
taskbar = true
-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
-- local battery_widget = require("battery-widget")
require("brightness")
Gamma = 10
CurrentBrightness = 1
GammaHdmi = 10
CurrentBrightnessHdmi = 1
require("awful.autofocus")
-- require("collision")()
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
-- local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")
-- {{{ Random Wallpapers

-- Get the list of files from a directory. Must be all images or folders and non-empty.
-- function scanDir(directory)
-- 	local i, fileList, popen = 0, {}, io.popen
-- 	for filename in popen([[find "]] ..directory.. [[" -type f]]):lines() do
-- 	    i = i + 1
-- 	    fileList[i] = filename
-- 	end
-- 	return fileList

-- Load Debian menu entries
-- local debian = require("debian.menu")
local has_fdo, freedesktop = pcall(require, "freedesktop")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
--
--
--
if awesome.startup_errors then
	naughty.notify({
		preset = naughty.config.presets.critical,
		title = "Oops, there were errors during startup!",
		text = awesome.startup_errors,
	})
end

-- current_brightness = 50
-- function setBrightess(current_brightness, value)
--    local total_brightness = current_brightness + value
--         if total_brightness > 0 and total_brightness <= 100 then
--             awful.spawn("./usr/local/bin/gummy -b "..total_brightness)
--             print("./usr/local/bin/gummy -b "..total_brightness)
--         current_brightness = current_brightness + value
--         end
-- end

do
	local in_error = false
	awesome.connect_signal("debug::error", function(err)
		-- Make sure we don't go into an endless error loop
		if in_error then
			return
		end
		in_error = true

		naughty.notify({
			preset = naughty.config.presets.critical,
			title = "Oops, an error happened!",
			text = tostring(err),
		})
		in_error = false

		awful.client.movetoscreen(c, mouse.screen)
	end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
-- beautiful.init("/home/knuffelbeer/.config/awesome/theme.lua")
beautiful.init(gears.filesystem.get_configuration_dir() .. "theme.lua")
--gears.wallpaper.maximized("/home/knuffelbeer/backgrounds/deadpool.jpg", 1)
--gears.wallpaper.set("#000000")
gears.wallpaper.maximized("/home/knuffelbeer/backgrounds/jeSOBWZ-kenny-south-park-wallpaper.jpg", 1)
--gears.wallpaper.maximized("/home/knuffelbeer/backgrounds/towelie2.jpg", 1)

-- This is used later as the default terminal ad editor to run.
math.randomseed(os.time())
--terminal = "x-terminal-emulator"
terminal = "/usr/bin/alacritty"

editor = os.getenv("EDITOR") or "editor"
editor_cmd = terminal .. " -e " .. editor
-- Apply a random wallpaper on startup.
-- gears.wallpaper.maximized(wallpaperList[math.random(1, #wallpaperList)], 1)

-- Apply a random wallpaper every changeTime seconds.
-- changeTime = 120
-- wallpaperTimer = timer { timeout = changeTime }
--  wallpaperTimer:connect_signal("timeout", function()
--      gears.wallpaper.maximized(wallpaperList[math.random(1, #wallpaperList)], 1)

--  -- stop the timer (we don't need multiple instances running at the same time)
--      wallpaperTimer:stop()

--  --restart the timer
--      wallpaperTimer.timeout = changeTime
--      wallpaperTimer:start()
--  end)

-- initial start when rc.lua is first run
--  wallpaperTimer:start()
-- }}}
-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
	--    awful.layout.suit.floating,
	awful.layout.suit.tile,
	--    awful.layout.suit.tile.left,
	--awful.layout.suit.fair,
	--    awful.layout.suit.tile.bottom,
	--    awful.layout.suit.tile.top,
	--    awful.layout.suit.fair.horizontal,
	--    awful.layout.suit.spiral,
	--    awful.layout.suit.spiral.dwindle,
	--    awful.layout.suit.max,
	    --awful.layout.suit.max.fullscreen,
	--    awful.layout.suit.magnifier,
	--    awful.layout.suit.corner.nw,
	-- awful.layout.suit.corner.ne,
	-- awful.layout.suit.corner.sw,
	-- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
	{
		"hotkeys",
		function()
			hotkeys_popup.show_help(nil, awful.screen.focused())
		end,
	},
	{ "manual",      terminal .. " -e man awesome" },
	{ "edit config", editor_cmd .. " " .. awesome.conffile },
	{ "restart",     awesome.restart },
	{
		"quit",
		function()
			awesome.quit()
		end,
	},
}

--local menu_awesome = { "awesome", myawesomemenu, beautiful.awesome_icon }
--local menu_terminal = { "open terminal", terminal }
--
--if has_fdo then
--    mymainmenu = freedesktop.menu.build({
--        before = { menu_awesome },
--        after =  { menu_terminal }
--    })
--else
--    mymainmenu = awful.menu({
--        items = {
--                  menu_awesome,
--                  { "Debian", debian.menu.Debian_menu.Debian },
--                  menu_terminal,
--                }
--    })
--end
--
--
--mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
--                                     menu = mymainmenu })

-- Menubar configuration
--menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
-- mytextclock = wibox.widget.textclock()
--
-- -- Create a wibox for each screen and add it
-- local taglist_buttons = gears.table.join(
--                    awful.button({ }, 1, function(t) t:view_only() end),
--                     awful.button({ modkey }, 1, function(t)
--                                               if client.focus then
--                                                   client.focus:move_to_tag(t)
--                                               end
--                                           end),
--                     awful.button({ }, 3, awful.tag.viewtoggle),
--                     awful.button({ modkey }, 3, function(t)
--                                               if client.focus then
--                                                   client.focus:toggle_tag(t)
--                                               end
--                                           end),
--                     awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
--                     awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
--                 )
--
-- local tasklist_buttons = gears.table.join(
--                      awful.button({ }, 1, function (c)
--                                               if c == client.focus then
--                                                   c.minimized = true
--                                               else
--                                                   c:emit_signal(
--                                                       "request::activate",
--                                                       "tasklist",
--                                                       {raise = true}
--                                                   )
--                                               end
--                                           end),
--                      awful.button({ }, 3, function()
--                                               awful.menu.client_list({ theme = { width = 250 } })
--                                           end),
--                      awful.button({ }, 4, function ()
--                                               awful.client.focus.byidx(1)
--                                           end),
--                      awful.button({ }, 5, function ()
--                                               awful.client.focus.byidx(-1)
--                                           end))
--
--local function set_wallpaper(s)
--    -- Wallpaper
--    if beautiful.wallpaper then
--        local wallpaper = beautiful.wallpaper
--        -- If wallpaper is a function, call it with the screen
--        if type(wallpaper) == "function" then
--            wallpaper = wallpaper(s)
--        end
--        gears.wallpaper.maximized(wallpaper, s, true)
--    end
--end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
-- screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
	-- Wallpaper
	-- set_wallpaper(s)

	-- Each screen has its own tag table.
	awful.tag({ "1", "2", "3", "4", "5"  ,"6", "7", "8","9","10" }, s, awful.layout.layouts[1])

	-- Create a promptbox for each screen
	s.mypromptbox = awful.widget.prompt()
	-- Create an imagebox widget which will contain an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	--   s.mylayoutbox = awful.widget.layoutbox(s)
	--  s.mylayoutbox:buttons(gears.table.join(
	--                         awful.button({ }, 1, function () awful.layout.inc( 1) end),
	--                         awful.button({ }, 3, function () awful.layout.inc(-1) end),
	--                         awful.button({ }, 4, function () awful.layout.inc( 1) end),
	--                         awful.button({ }, 5, function () awful.layout.inc(-1) end)))
	-- Create a taglist widget
	-- s.mytaglist = awful.widget.taglist {
	--     screen  = s,
	--     filter  = awful.widget.taglist.filter.all,
	--     buttons = taglist_buttons
	-- }
	--
	-- Create a tasklist widget
	-- s.mytasklist = awful.widget.tasklist {
	--     screen  = s,
	--     filter  = awful.widget.tasklist.filter.currenttags,
	--     buttons = tasklist_buttons
	-- }
	--
	-- Create the wibox
	-- s.mywibox = awful.wibar({ position = "top", screen = s, opacity=0.8 })

	-- --  -- Add widgets to the wibox
	--   s.mywibox:setup {
	--      layout = wibox.layout.align.horizontal,
	--     { -- Left widgets
	--         layout = wibox.layout.fixed.horizontal,
	--          -- mylauncher,
	--         s.mytaglist,
	--         s.mypromptbox
	--     },
	--     s.mytasklist, -- Middle widget
	--     { -- Right widgets
	--           layout = wibox.layout.fixed.horizontal,
	--           -- mykeyboardlayout,
	--           -- wibox.widget.systray(),
	--           mytextclock,
	--           s.mylayoutbox,
	--       battery_widget {
	--       ac = "AC",
	--       adapter = "BAT0",
	--       ac_prefix = "AC: ",
	--       battery_prefix = "",
	--       percent_colors = {
	--           { 25, "red"   },
	--           { 50, "orange"},
	--           {999, "green" },
	--       },
	--       listen = true,
	--       timeout = 10,
	--       widget_text = "${AC_BAT}${color_on}${percent}%${color_off}",
	--        widget_font = "Deja Vu Sans Mono 16",
	--       tooltip_text = "Battery ${state}${time_est}\nCapacity: ${capacity_percent}%",
	--       alert_threshold = 5,
	--       alert_timeout = 0,
	--       alert_title = "Low battery !",
	--       alert_text = "${AC_BAT}${time_est}",
	--       alert_icon = "~/Downloads/low_battery_icon.png",
	--       warn_full_battery = true,
	--       full_battery_icon = "~/Downloads/full_battery_icon.png",
	--       },
	--
	--     }
	-- }
end)
-- }}}
qutebrowser_darkmode = "firefox"
default_browser = "firefox"
-- {{{ Mouse bindings
root.buttons(gears.table.join(
	awful.button({}, 3, function()
		mymainmenu:toggle()
	end),
	awful.button({}, 4, awful.tag.viewnext),
	awful.button({}, 5, awful.tag.viewprev)
))
-- }}}
require("personal_mappings")
personal_mappings = personal_mappings()
print(personal_mappings)
-- {{{ Key bindings
globalkeys = gears.table.join(

	awful.key({ modkey, "Control" }, "w", function()
		if taskbar then
			awful.spawn("killall polybar")
			taskbar = false
		else
			awful.spawn("sh /home/knuffelbeer/.config/polybar/launch.sh")
			taskbar = true
		end
	end),
	awful.key({ "Shift" }, "XF86MonBrightnessUp", function()
		Gamma = AdjustColorIdx(Gamma, true)
		awful.spawn(ChooseColor(Gamma, "eDP-1", CurrentBrightness))
	end),
	awful.key({ modkey, "Shift" }, "r", function()
		awful.spawn("rofi -show filebrowser")
	end),
	awful.key({ "Shift" }, "XF86MonBrightnessDown", function()
		Gamma = AdjustColorIdx(Gamma, false)
		awful.spawn(ChooseColor(Gamma, "eDP-1", CurrentBrightness))
	end),

	awful.key({ "Shift", modkey }, "XF86MonBrightnessUp", function()
		GammaHdmi = AdjustColorIdx(Gamma, true)
		awful.spawn(ChooseColor(Gamma, "HDMI-1", currentBrightness))
	end),
	awful.key({ "Shift", modkey }, "XF86MonBrightnessDown", function()
		GammaHdmi = AdjustColorIdx(Gamma, false)
		awful.spawn(ChooseColor(Gamma, "HDMI-1", CurrentBrightness))
	end),

	awful.key({ "Control" }, "XF86MonBrightnessDown", function()
		awful.spawn("python /home/knuffelbeer/bashScripts/increase_terminal_opacity_toml.py")
	end),
	awful.key({ "Control" }, "XF86MonBrightnessUp", function()
		awful.spawn("python /home/knuffelbeer/bashScripts/decrease_terminal_opacity_toml.py")
	end),

	awful.key({}, "XF86MonBrightnessUp", function()
		CurrentBrightness = AdjustBrightnessIdx(CurrentBrightness, true)
		awful.spawn(AdjustBrightness(CurrentBrightness, "eDP-1", Gamma))
	end),
	awful.key({}, "XF86MonBrightnessDown", function()
		CurrentBrightness = AdjustBrightnessIdx(CurrentBrightness, false)
		awful.spawn(AdjustBrightness(CurrentBrightness, "eDP-1", Gamma))
	end),
	awful.key({}, "XF86AudioMute", function()
		awful.spawn("amixer -D pulse sset Master toggle", false)
	end),
	awful.key({}, "XF86AudioLowerVolume", function()
		awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%")
	end, { description = "lower volume", group = "system" }),
	awful.key({}, "XF86AudioRaiseVolume", function()
		awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%")
	end, { description = "increase volume", group = "system" }),
	awful.key({ "Control", "Shift" }, "q", function()
		awful.spawn("poweroff")
	end, { description = "Power Off" }),
	awful.key({ modkey, "Shift" }, "c", function()
		awful.spawn(default_browser .. " --new-window https://canvas.uva.nl/")
	end, { description = "Open canvas new window", group = "applications" }),

	awful.key({ modkey}, "c", function()
		awful.spawn(default_browser .. " https://canvas.uva.nl/")
	end, { description = "Open canvas same window", group = "applications" }),
	awful.key({ modkey, "Shift" }, "g", function()
		awful.spawn(default_browser .. " https://chat.openai.com/")
	end, { description = "Chatgpt", group = "applications" }),
	awful.key({ modkey, "Shift" }, "b", function()
		awful.spawn("blueman-manager")
	end, { description = "Go to Bluetooth Settings", group = "applications" }),

	awful.key({ modkey }, "g", function()
		awful.spawn(qutebrowser_darkmode)
	end, { description = "Open Google Chrome", group = "applications" }),
	awful.key({ modkey }, "w", function()
		awful.spawn(default_browser .. " https://web.whatsapp.com/")
	end, { description = "Open Whatsapp", group = "applications" }),
	awful.key({ modkey }, "s", function()
		awful.spawn("spotify")
	end, { description = "Open spotifOpen spotify" }),

	awful.key({ modkey, "Shift" }, "f", function()
		awful.spawn(default_browser .. " https://fmoviesz.to/tv/south-park-j2ywy")
	end, { description = "Open fmovies", group = "applications" }),
	-- awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
	--           {description="show help", group="awesome"}),
	awful.key({ modkey }, "Left", awful.tag.viewprev, { description = "view previous", group = "tag" }),
	awful.key({ modkey }, "Right", awful.tag.viewnext, { description = "view next", group = "tag" }),
	awful.key({ modkey }, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" }),
	awful.key({ modkey }, "j", function()
		awful.client.focus.byidx(1)
	end, { description = "focus next by index", group = "client" }),
	awful.key({ modkey }, "k", function()
		awful.client.focus.byidx(-1)
	end, { description = "focus previous by index", group = "client" }),
	awful.key({ modkey, "Shift" }, "j", function()
		awful.client.swap.byidx(1)
	end, { description = "swap with next client by index", group = "client" }),
	awful.key({ modkey, "Shift" }, "k", function()
		awful.client.swap.byidx(-1)
	end, { description = "swap with previous client by index", group = "client" }),
	awful.key({ modkey, "Control" }, "j", function()
		awful.screen.focus_relative(1)
	end, { description = "focus the next screen", group = "screen" }),
	awful.key({ modkey, "Control" }, "k", function()
		awful.screen.focus_relative(-1)
	end, { description = "focus the previous screen", group = "screen" }),
	awful.key({ modkey }, "u", awful.client.urgent.jumpto,
		{ description = "jump to urgent client", group = "client" }),
	awful.key({ modkey }, "Tab", function()
		awful.client.focus.history.previous()
		if client.focus then
			client.focus:raise()
		end
	end, { description = "go back", group = "client" }),

	-- Standard program
	awful.key({ modkey }, "Return", function()
		awful.spawn("alacritty")
	end, { description = "open a terminal", group = "launcher" }),
	awful.key({ modkey, "Control" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
	awful.key({ modkey, "Shift" }, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),
	awful.key({ modkey }, "l", function()
		awful.tag.incmwfact(0.05)
	end, { description = "increase master width factor", group = "layout" }),
	awful.key({ modkey }, "h", function()
		awful.tag.incmwfact(-0.05)
	end, { description = "decrease master width factor", group = "layout" }),
	awful.key({ modkey, "Shift" }, "h", function()
		awful.tag.incnmaster(1, nil, true)
	end, { description = "increase the number of master clients", group = "layout" }),
	awful.key({ modkey, "Shift" }, "l", function()
		awful.tag.incnmaster(-1, nil, true)
	end, { description = "decrease the number of master clients", group = "layout" }),
	awful.key({ modkey, "Control" }, "h", function()
		awful.tag.incncol(1, nil, true)
	end, { description = "increase the number of columns", group = "layout" }),
	awful.key({ modkey, "Control" }, "l", function()
		awful.tag.incncol(-1, nil, true)
	end, { description = "decrease the number of columns", group = "layout" }),
	awful.key({ modkey }, "space", function()
		awful.layout.inc(1)
	end, { description = "select next", group = "layout" }),
	awful.key({ modkey, "Shift" }, "space", function()
		awful.layout.inc(-1)
	end, { description = "select previous", group = "layout" }),

	awful.key({ modkey, "Control" }, "n", function()
		local c = awful.client.restore()
		-- Focus restored client
		if c then
			c:emit_signal("request::activate", "key.unminimize", { raise = true })
		end
	end, { description = "restore minimized", group = "client" }),

	-- Prompt
	awful.key({ modkey }, "r", function()
		awful.spawn("rofi -show drun -terminal alacritty")
	end, { description = "run prompt", group = "launcher" }),
	awful.key({ modkey, "Control" }, "b", function()
		local s = awful.screen.focused()
		s.mywibox.visible = not s.mywibox.visible
	end)
)

clientkeys = gears.table.join(
	awful.key({ modkey }, "f", function(c)
		c.fullscreen = not c.fullscreen
		c:raise()
	end, { description = "toggle fullscreen", group = "client" }),
	awful.key({ modkey }, "x", function(c)
		c:kill()
	end, { description = "close", group = "client" }),
	awful.key(
		{ modkey, "Control" },
		"space",
		awful.client.floating.toggle,
		{ description = "toggle floating", group = "client" }
	),
	awful.key({ modkey, "Control" }, "Return", function(c)
		c:swap(awful.client.getmaster())
	end, { description = "move to master", group = "client" }),
	awful.key({ modkey }, "o", function(c)
		c:move_to_screen()
	end, { description = "move to screen", group = "client" }),
	awful.key({ modkey }, "t", function(c)
		c.ontop = not c.ontop
	end, { description = "toggle keep on top", group = "client" }),
	awful.key({ modkey }, "n", function(c)
		-- The client currently has the input focus, so it cannot be
		-- minimized, since minimized clients can't have the focus.
		c.minimized = true
	end, { description = "minimize", group = "client" }),
	awful.key({ modkey }, "m", function(c)
		c.maximized = not c.maximized
		c:raise()
	end, { description = "(un)maxi/mize", group = "client" }),
	awful.key({ modkey, "Control" }, "m", function(c)
		c.maximized_vertical = not c.maximized_vertical
		c:raise()
	end, { description = "(un)maximize vertically", group = "client" }),
	awful.key({ modkey, "Shift" }, "m", function(c)
		c.maximized_horizontal = not c.maximized_horizontal
		c:raise()
	end, { description = "(un)maximize horizontally", group = "client" }),
	awful.key({ modkey }, "a", function()
		awful.spawn("xrandr --auto")
	end, { description = "restore screen", group = "launcher" })
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 10 do

	local tagnum = i
	if i == 10 then
		tagnum = 0
	end

	globalkeys = gears.table.join(
		globalkeys,
		-- View tag only.

		awful.key({ modkey }, tagnum, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				tag:view_only()
			end
		end, { description = "view tag #" .. i, group = "tag" }),
		-- Toggle tag display.?
		awful.key({ modkey, "Control" }, i, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				awful.tag.viewtoggle(tag)
			end
		end, { description = "toggle tag #" .. i, group = "tag" }),
		-- Move client to tag.
		awful.key({ modkey, "Shift" }, i, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:move_to_tag(tag)
				end
			end
		end, { description = "move focused client to tag #" .. i, group = "tag" }),
		-- Toggle tag on focused client.
		awful.key({ modkey, "Control", "Shift" }, i, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:toggle_tag(tag)
				end
			end
		end, { description = "toggle focused client on tag #" .. i, group = "tag" })
	)
end

clientbuttons = gears.table.join(
	awful.button({}, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
	end),
	awful.button({ modkey }, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.move(c)
	end),
	awful.button({ modkey }, 3, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.resize(c)
	end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
	{
		rule = { class = "Spotify" },
		properties = { screen = 1, tag = "5" },
		{ rule = { class = "Blueman-manager" }, properties = { screen = 1, tag = "5" } },
	},
	{
		rule = { class = "ogreBullet" },
		properties = { screen = 1, tag = "3" },
	},
	--     -- { rule = {class = "thorium-browser" , maximized=false},{rule= {class="qutebrowser", properties={screen=1, tag="5"}
	{ rule = { class = "qutebrowser" }, properties = { screen = 1, tag = "3" } },
	-- {rule = {class="qutebrowser"},
	-- properties = {screen=1, tag="2"}
	-- },
	{ rule = { class = "Polybar" },     properties = { below = true } },
	-- All clients will match this rule.
	{
		rule = {},
		properties = {
			border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			focus = awful.client.focus.filter,
			raise = true,
			keys = clientkeys,
			buttons = clientbuttons,
			screen = awful.screen.preferred,
			placement = awful.placement.no_overlap + awful.placement.no_offscreen,
		},
	},

	-- Floating clients.
	{
		rule_any = {
			instance = {
				-- "DTA",  -- Firefox addon DownThemAll.
				"copyq", -- Includes session name in class.
				"pinentry",
			},
			class = {
				"Arandr",
				--          "Blueman-manager",
				"Gpick",
				"Kruler",
				"MessageWin", -- kalarm.
				"Sxiv",
				"Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
				"Wpa_gui",
				"veromix",
				"xtightvncviewer",
			},

			-- Note that the name property shown in xprop might be set slightly after creation of the client
			-- and the name shown there might not match defined rules here.
			name = {
				"Event Tester", -- xev.
			},
			role = {
				"AlarmWindow", -- Thunderbird's calendar.
				"ConfigManager", -- Thunderbird's about:config.
				--          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
			},
		},
		properties = { floating = true },
	},
	--      }, properties = { titlebars_enabled = true }
	--    },
	--
	-- Set Firefox to always map on the tag named "2" on screen 1.
}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
	-- Set the windows at the slave,
	-- i.e. put it at the end of others instead of setting it master.
	-- if not awesome.startup then awful.client.setslave(c) end

	if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
		-- Prevent clients from being unreachable after screen count changes.
		awful.placement.no_offscreen(c)
	end
end)

-- awful.util.spawn("gummy start")
-- awful.util.spawn('gummy -b 50')
-- awful.util.spawn('qutebrowser', {tag="2"})
local screen = awful.screen.focused()
-- screen.mywibox.visible = not screen.mywibox.visible
-- local tag = screen.tags[3]
awful.util.spawn("alacritty")
awful.util.spawn("firefox", { tag = "2" })
-- battery warning
-- created by bpdp

local function trim(s)
	return s:find("^%s*$") and "" or s:match("^%s*(.*%S)")
end

local function bat_notification()
	local f_capacity = assert(io.open("/sys/class/power_supply/BAT0/capacity", "r"))
	local f_status = assert(io.open("/sys/class/power_supply/BAT0/status", "r"))

	local bat_capacity = tonumber(f_capacity:read("*all"))
	local bat_status = trim(f_status:read("*all"))

	if bat_capacity <= 15 and bat_status == "Discharging" then
		naughty.notify({
			title = "Battery Warning",
			text = "Battery low! " .. bat_capacity .. "%" .. " left!",
			fg = "#88c0d0",
			bg = "#4c566a",
			timeout = 15,
			position = "bottom_left",
		})
	end
end

battimer = timer({ timeout = 120 })
battimer:connect_signal("timeout", bat_notification)
battimer:start()
-- awful.util.spawn(default_browser)
----experimental-backends --no-fading-openclose
awful.spawn("picom")
-- beautiful.useless_gap = 5
-- s.mywibox.visible = false
-- }}}
client.connect_signal("property::maximized", function(c)
	if c.maximized and c.class == "firefox" then
		c.maximized = false
	end
end)
