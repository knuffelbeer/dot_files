colors = {
	{ "xrandr --output ", " --gamma 1.00000000:0.18172716:0.00000001" },
	{ "xrandr --output ", " --gamma 1.00000000:0.42322816:0.00000001" },
	{ "xrandr --output ", " --gamma 1.00000000:0.54360078:0.08679949" },
	{ "xrandr --output ", " --gamma 1.00000000:0.64373109:0.28819679" },
	{ "xrandr --output ", " --gamma 1.00000000:0.71976951:0.42860152" },
	{ "xrandr --output ", " --gamma 1.00000000:0.77987699:0.54642268" },
	{ "xrandr --output ", " --gamma 1.00000000:0.82854786:0.64816570" },
	{ "xrandr --output ", " --gamma 1.00000000:0.86860704:0.73688797" },
	{ "xrandr --output ", " --gamma 1.00000000:0.90198230:0.81465502" },
	{ "xrandr --output ", " --gamma 1.00000000:0.93853986:0.88130458" },
	{ "xrandr --output ", " --gamma 1.00000000:0.97107439:0.94305985" },
	{ "xrandr --output ", " --gamma 1.00000000:1.00000000:1.00000000" },
	{ "xrandr --output ", " --gamma 0.95160805:0.96983355:1.00000000" },
	{ "xrandr --output ", " --gamma 0.91194747:0.94470005:1.00000000" },
	{ "xrandr --output ", " --gamma 0.87906581:0.92357340:1.00000000" },
	{ "xrandr --output ", " --gamma 0.85139976:0.90559011:1.00000000" },
	{ "xrandr --output ", " --gamma 0.82782969:0.89011714:1.00000000" },
	{ "xrandr --output ", " --gamma 0.80753191:0.87667891:1.00000000" },
	{ "xrandr --output ", " --gamma 0.78988728:0.86491137:1.00000000" },
	{ "xrandr --output ", " --gamma 0.77442176:0.85453121:1.00000000" },
}

colors_values = {
	"1.00000000:0.18172716:0.00000001",
	"1.00000000:0.42322816:0.00000001",
	"1.00000000:0.54360078:0.08679949",
	"1.00000000:0.64373109:0.28819679",
	"1.00000000:0.71976951:0.42860152",
	"1.00000000:0.77987699:0.54642268",
	"1.00000000:0.82854786:0.64816570",
	"1.00000000:0.86860704:0.73688797",
	"1.00000000:0.90198230:0.81465502",
	"1.00000000:0.93853986:0.88130458",
	"1.00000000:0.97107439:0.94305985",
	"1.00000000:1.00000000:1.00000000",
	"0.95160805:0.96983355:1.00000000",
	"0.91194747:0.94470005:1.00000000",
	"0.87906581:0.92357340:1.00000000",
	"0.85139976:0.90559011:1.00000000",
	"0.82782969:0.89011714:1.00000000",
	"0.80753191:0.87667891:1.00000000",
	"0.78988728:0.86491137:1.00000000",
	"0.77442176:0.85453121:1.00000000",
}

function ChooseColor(idx, output, brightness)
	return colors[idx][1] .. output .. colors[idx][2] .. " --brightness " .. brightness
end

function AdjustColorIdx(currentColor, up)
	if up then
		if currentColor < 20 then
			return currentColor + 1
		end
	else
		if currentColor > 1 then
			return currentColor - 1
		end
	end
	return currentColor
end

function AdjustBrightnessIdx(currentBrightness, up)
	if up and currentBrightness + 0.1 <= 1 then
		return currentBrightness + 0.1
	elseif not up and currentBrightness - 0.1 >= 0 then
		return currentBrightness - 0.1
	end
	return currentBrightness
end

function AdjustBrightness(brightness, output, currentColor)
	print(brightness)
	print(colors_values[currentColor])
	return "xrandr --output " .. output .. " --gamma " .. colors_values[currentColor] .. " --brightness " .. brightness
end
brightness = 1
gamma = 1
print(AdjustBrightness(brightness, "eDP-1", gamma))
