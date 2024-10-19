
package.path = package.path .. "/home/knuffelbeer/.config/awesome"

require("brightness")
CurrentBrightness = 50
Gamma = -30
GammaHdmi = AdjustColorIdx(Gamma, false)
ChooseColor(Gamma, "HDMI-1", CurrentBrightness)
