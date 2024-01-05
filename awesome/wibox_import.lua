require("awful")
require("awful.autofocus")

modkey        = "Mod4"
terminal      = "alacritty"
terminalr     = "sudo terminal --default-working-directory=/root/ --geometry=200x49+80+36"
configuration = "TERM=screen-256color lilyterm -T 'Awesome Configuration' -g 228x62+0+16 -x ~/.gem/ruby/1.9.1/bin/mux start configuration"
rttmux        = "sudo terminal --geometry=220x59+20+36 --default-working-directory=/root/ -x tmux -2"
ttmux         = "lilyterm -T tmux -g 221x60+20+36 -e tmux -2"
tetmux        = "terminal --geometry=189x54+20+36 -x tmux -2"
sakura        = "sakura -c 222 -r 60 --geometry=+15+30"
lilyterm      = "lilyterm -g 221x60+20+36"
musicplr      = "lilyterm -T Music -g 130x34-320+16 -e ncmpcpp"
iptraf        = "lilyterm -T 'IP traffic monitor' -g 180x54-20+34 -e sudo iptraf-ng -i all"
mailmutt      = "lilyterm -T 'Mutt' -g 140x44-20+34 -e mutt"
chat          = "TERM=screen-256color lilyterm -T 'Chat' -g 228x62+0+16 -x ~/.gem/ruby/1.9.1/bin/mux start chat"
editor        = os.getenv("EDITOR") or "vim"
editor_cmd    = terminal .. " -e " .. editor
browser       = "firefox"
fm            = "spacefm"
mysystray = widget({ type = "systray" })

mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                 client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=450 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))
for s = 1, screen.count() do
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)
    mytasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, mytasklist.buttons)

--{{---| Chat widget |------------------------------------------------------------------------------

chaticon = widget ({type = "imagebox" })
chaticon.image = image(beautiful.widget_chat)
chaticon:buttons(awful.util.table.join(awful.button({ }, 1,
function () awful.util.spawn_with_shell(chat) end)))

--{{---| Mail widget |------------------------------------------------------------------------------

mailicon = widget ({type = "imagebox" })
mailicon.image = image(beautiful.widget_mail)
mailicon:buttons(awful.util.table.join(awful.button({ }, 1, 
function () awful.util.spawn_with_shell(mailmutt) end)))

--{{---| Music widget |-----------------------------------------------------------------------------

music = widget ({type = "imagebox" })
music.image = image(beautiful.widget_music)
music:buttons(awful.util.table.join(
  awful.button({ }, 1, function () awful.util.spawn_with_shell(musicplr) end),
  awful.button({ modkey }, 1, function () awful.util.spawn_with_shell("ncmpcpp toggle") end),
  awful.button({ }, 3, function () couth.notifier:notify( couth.alsa:setVolume('Master','toggle')) end),
  awful.button({ }, 4, function () couth.notifier:notify( couth.alsa:setVolume('PCM','2dB+')) end),
  awful.button({ }, 5, function () couth.notifier:notify( couth.alsa:setVolume('PCM','2dB-')) end),
  awful.button({ }, 4, function () couth.notifier:notify( couth.alsa:setVolume('Master','2dB+')) end),
  awful.button({ }, 5, function () couth.notifier:notify( couth.alsa:setVolume('Master','2dB-')) end)))

--{{---| TaskWarrior widget |-----------------------------------------------------------------------

task_warrior = blingbling.task_warrior.new(beautiful.widget_task)
task_warrior:set_task_done_icon(beautiful.task_done_icon)
task_warrior:set_task_icon(beautiful.task_icon)
task_warrior:set_project_icon(beautiful.project_icon)

--{{---| MEM widget |-------------------------------------------------------------------------------

memwidget = widget({ type = "textbox" })
vicious.register(memwidget, vicious.widgets.mem, '<span background="#777E76" font="Terminus 12"> <span font="Terminus 9" color="#EEEEEE" background="#777E76">$2MB </span></span>', 13)
memicon = widget ({type = "imagebox" })
memicon.image = image(beautiful.widget_mem)

--{{---| CPU / sensors widget |---------------------------------------------------------------------

cpuwidget = widget({ type = "textbox" })
vicious.register(cpuwidget, vicious.widgets.cpu,
'<span background="#4B696D" font="Terminus 12"> <span font="Terminus 9" color="#DDDDDD">$2% <span color="#888888">·</span> $3% </span></span>', 3)
cpuicon = widget ({type = "imagebox" })
cpuicon.image = image(beautiful.widget_cpu)
sensors = widget({ type = "textbox" })
vicious.register(sensors, vicious.widgets.sensors)
tempicon = widget ({type = "imagebox" })
tempicon.image = image(beautiful.widget_temp)
blingbling.popups.htop(cpuwidget,
{ title_color = beautiful.notify_font_color_1, 
user_color = beautiful.notify_font_color_2, 
root_color = beautiful.notify_font_color_3, 
terminal   = "terminal --geometry=130x56-10+26"})

--{{---| FS's widget / udisks-glue menu |-----------------------------------------------------------

fswidget = widget({ type = "textbox" })
vicious.register(fswidget, vicious.widgets.fs,
'<span background="#D0785D" font="Terminus 12"> <span font="Terminus 9" color="#EEEEEE">${/mnt/storage avail_gb}GB </span></span>', 8)
udisks_glue = blingbling.udisks_glue.new(beautiful.widget_hdd)
udisks_glue:set_mount_icon(beautiful.accept)
udisks_glue:set_umount_icon(beautiful.cancel)
udisks_glue:set_detach_icon(beautiful.cancel)
udisks_glue:set_Usb_icon(beautiful.usb)
udisks_glue:set_Cdrom_icon(beautiful.cdrom)
awful.widget.layout.margins[udisks_glue.widget] = { top = 0}
udisks_glue.widget.resize = false

--{{---| Battery widget |---------------------------------------------------------------------------  

baticon = widget ({type = "imagebox" })
baticon.image = image(beautiful.widget_battery)
batwidget = widget({ type = "textbox" })
vicious.register( batwidget, vicious.widgets.bat, '<span background="#92B0A0" font="Terminus 12"> <span font="Terminus 9" color="#FFFFFF" background="#92B0A0">$1$2% </span></span>', 1, "BAT0" )

--{{---| Net widget |-------------------------------------------------------------------------------

netwidget = widget({ type = "textbox" })
vicious.register(netwidget, 
vicious.widgets.net,
'<span background="#C2C2A4" font="Terminus 12"> <span font="Terminus 9" color="#FFFFFF">${eth0 down_kb} ↓↑ ${eth0 up_kb}</span> </span>', 3)
neticon = widget ({type = "imagebox" })
neticon.image = image(beautiful.widget_net)
netwidget:buttons(awful.util.table.join(awful.button({ }, 1,
function () awful.util.spawn_with_shell(iptraf) end)))

--{{---| Binary Clock |-----------------------------------------------------------------------------

binaryclock = {}
binaryclock.widget = widget({type = "imagebox"})
binaryclock.w = 42  
binaryclock.h = 16  
binaryclock.show_sec = true 
binaryclock.color_active = beautiful.binclock_fga
binaryclock.color_bg = beautiful.binclock_bg
binaryclock.color_inactive = beautiful.binclock_fgi
binaryclock.dotsize = math.floor(binaryclock.h / 5)
binaryclock.step = math.floor(binaryclock.dotsize / 3)
binaryclock.widget.image = image.argb32(binaryclock.w, binaryclock.h, nil) 
if (binaryclock.show_sec) then binaryclock.timeout = 1 else binaryclock.timeout = 20 end 
binaryclock.DEC_BIN = function(IN) 
local B,K,OUT,I,D=2,"01","",0
while IN>0 do
I=I+1
IN,D=math.floor(IN/B),math.mod(IN,B)+1
OUT=string.sub(K,D,D)..OUT
end
return OUT
end
binaryclock.paintdot = function(val,shift,limit) 
local binval = binaryclock.DEC_BIN(val)
local l = string.len(binval)
local height = 0 
if (l < limit) then
for i=1,limit - l do binval = "0" .. binval end
end
for i=0,limit-1 do
if (string.sub(binval,limit-i,limit-i) == "1") then
binaryclock.widget.image:draw_rectangle(shift,
binaryclock.h - binaryclock.dotsize - height, 
binaryclock.dotsize, binaryclock.dotsize, true, binaryclock.color_active)
else
binaryclock.widget.image:draw_rectangle(shift,
binaryclock.h - binaryclock.dotsize - height, 
binaryclock.dotsize,binaryclock.dotsize, true, binaryclock.color_inactive)
end
height = height + binaryclock.dotsize + binaryclock.step
end
end
binaryclock.drawclock = function ()
binaryclock.widget.image:draw_rectangle(0, 0, binaryclock.w, binaryclock.h, true, binaryclock.color_bg)
local t = os.date("*t")
local hour = t.hour
if (string.len(hour) == 1) then
hour = "0" .. t.hour
end
local min = t.min
if (string.len(min) == 1) then
min = "0" .. t.min
end
local sec = t.sec
if (string.len(sec) == 1) then
sec = "0" .. t.sec
end
local col_count = 6
if (not binaryclock.show_sec) then col_count = 4 end
local step = math.floor((binaryclock.w - col_count * binaryclock.dotsize) / 8)
binaryclock.paintdot(0 + string.sub(hour, 1, 1), step, 2)
binaryclock.paintdot(0 + string.sub(hour, 2, 2), binaryclock.dotsize + 2 * step, 4)
binaryclock.paintdot(0 + string.sub(min, 1, 1),binaryclock.dotsize * 2 + 4 * step, 3)
binaryclock.paintdot(0 + string.sub(min, 2, 2),binaryclock.dotsize * 3 + 5 * step, 4)
if (binaryclock.show_sec) then
binaryclock.paintdot(0 + string.sub(sec, 1, 1), binaryclock.dotsize * 4 + 7 * step, 3)
binaryclock.paintdot(0 + string.sub(sec, 2, 2), binaryclock.dotsize * 5 + 8 * step, 4)
end
binaryclock.widget.image = binaryclock.widget.image
end
binarytimer = timer { timeout = binaryclock.timeout }
binarytimer:add_signal("timeout", function()
binaryclock.drawclock()
end)
binarytimer:start()

-- binaryclock.widget:buttons(awful.util.table.join(
--   awful.button({ }, 1, function () 
--   end)
-- ))

--{{---| Calendar widget |--------------------------------------------------------------------------

-- my_cal = blingbling.calendar.new({type = "imagebox", image = beautiful.widget_cal})
-- my_cal:set_cell_padding(4)
-- my_cal:set_title_font_size(9)
-- my_cal:set_title_text_color("#4F98C1")
-- my_cal:set_font_size(9)
-- my_cal:set_inter_margin(1)
-- my_cal:set_columns_lines_titles_font_size(8)
-- my_cal:set_columns_lines_titles_text_color("#d4aa00ff")
-- my_cal:set_link_to_external_calendar(true) --{{ <-- popup reminder

--{{---| Separators widgets |-----------------------------------------------------------------------

spr = widget({ type = "textbox" })
spr.text = ' '
sprd = widget({ type = "textbox" })
sprd.text = '<span background="#313131" font="Terminus 12"> </span>'
spr3f = widget({ type = "textbox" })
spr3f.text = '<span background="#777e76" font="Terminus 12"> </span>'
arr1 = widget ({type = "imagebox" })
arr1.image = image(beautiful.arr1)
arr2 = widget ({type = "imagebox" })
arr2.image = image(beautiful.arr2)
arr3 = widget ({type = "imagebox" })
arr3.image = image(beautiful.arr3)
arr4 = widget ({type = "imagebox" })
arr4.image = image(beautiful.arr4)
arr5 = widget ({type = "imagebox" })
arr5.image = image(beautiful.arr5)
arr6 = widget ({type = "imagebox" })
arr6.image = image(beautiful.arr6)
arr7 = widget ({type = "imagebox" })
arr7.image = image(beautiful.arr7)
arr8 = widget ({type = "imagebox" })
arr8.image = image(beautiful.arr8)
arr9 = widget ({type = "imagebox" })
arr9.image = image(beautiful.arr9)
arr0 = widget ({type = "imagebox" })
arr0.image = image(beautiful.arr0)


--{{---| Panel |------------------------------------------------------------------------------------

mywibox[s] = awful.wibox({ position = "top", screen = s, height = "16" })

mywibox[s].widgets = {
   { mylauncher, mytaglist[s], mypromptbox[s], layout = awful.widget.layout.horizontal.leftright },
     mylayoutbox[s],
     arr1,
     spr3f,
     binaryclock.widget,
     spr3f, 
     -- arrl, 
     -- my_cal.widget,
     arr2, 
     netwidget,
     neticon,
     arr3,
     batwidget,
     baticon,
     arr4, 
     fswidget,
     udisks_glue.widget,
     arr5,
     sensors,
     tempicon,
     arr6,
     cpuwidget,
     cpuicon,
     arr7,
     memwidget,
     memicon,
     arr8,
     task_warrior.widget,
     arr9,
     music,
     arr0,
     mailicon, 
     arr9,
     spr,
     s == 1 and mysystray, spr or nil, mytasklist[s], 
     layout = awful.widget.layout.horizontal.rightleft } end
