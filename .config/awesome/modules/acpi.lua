local wibox = require("wibox")
local awful = require("awful")

acpictl = wibox.widget.textbox()
acpictl:set_align("right")

function update_acpi(widget)
   local ts  -- temp stauts
   local bs  -- batt status

   local acpi

   ts = assert(io.popen("acpi -t | awk '{print $4}'", "r"))
   bs = assert(io.popen("acpi -b | awk '{print $4}' | sed 's/[,%]//g'", "r"))

   acpi = "<span font=\"Terminus Bold 12\"><span color=\"red\"> | </span>" .. "BAT: " .. bs:read("*l") .. "% " .. ts:read("*l") .. " C" .. "</span>"

   widget:set_markup(acpi)
end

update_acpi(acpictl)

mytimer = timer({ timeout = 5 })
mytimer:connect_signal("timeout", function () update_acpi(acpictl) end)
mytimer:start()
