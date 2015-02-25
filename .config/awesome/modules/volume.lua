local wibox = require("wibox")
local awful = require("awful")

volumectl = wibox.widget.textbox()
volumectl:set_align("right")

function update_volume(widget)
   local fd = io.popen("amixer sget Master")
   local status = fd:read("*all")
   fd:close()

   local volume = tonumber(string.match(status, "(%d?%d?%d)%%"))
   volume = string.format("%-3d", volume)

   status = string.match(status, "%[(o[^%]]*)%]")

   if string.find(status, "on", 1, true) then
       -- For the volume numbers
       volume = "VOL: " .. volume .. "%"
   else
       -- For the mute button
       volume = "VOL: " .. volume .. "M"
   end

   volume = "<span font=\"Terminus Bold 12\"><span color=\"red\"> | </span>" .. volume .. "</span>"

   widget:set_markup(volume)
end

volumectl:buttons (awful.util.table.join (
    awful.button ({}, 4, function()
	awful.util.spawn ("amixer -q sset Master 5%+")
    end),
    awful.button ({}, 5, function()
	awful.util.spawn ("amixer -q sset Master 5%-")
    end)
))

update_volume(volumectl)

mytimer = timer({ timeout = 0.2 })
mytimer:connect_signal("timeout", function () update_volume(volumectl) end)
mytimer:start()
