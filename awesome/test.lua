
local open_programs = {}

local function open_program(program, cmd, idx)
	if open_programs[program] then
		-- local screen = awful.screen.focused()
		-- local tag = screen.tags[idx]
		-- if tag then
		-- 	tag:view_only()
		-- end
	else
		print("assigning idx " .. idx .. " to " .. program)
		open_programs[program] = { cmd, idx }
		-- awful.spawn(idx, { tag = "" .. idx })
	end
end
local function switch_window_with_rofi()
	local cmd = 'echo "'
	for k, _ in pairs(open_programs) do
		cmd = cmd .. k .. "\n"
	end
	cmd = cmd .. '" | rofi -dmenu -p "Switch to:"'
	local handle = io.popen(cmd)
	local result = handle:read("*a")
	handle:close()
  local test = 'hoi dit is een test\n'
	test = test:gsub('\n', '')
	result = string.gsub(tostring(result),"\n", "")
	if open_programs[result] then
	local entry = open_programs[result]
	print(entry[2])
else
				print("no match found for " .. result)
	end
end
open_program("test1", "test4", 1)
open_program("test2", "test5", 2)
open_program("test3", "test6", 3)
open_program("test4", "test7", 4)
open_program("test5", "test8", 5)
switch_window_with_rofi()
