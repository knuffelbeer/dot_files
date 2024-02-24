return {
	"goolord/alpha-nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},

	button = { type = "button", opts = { hl = "AlphaButtons" } },
	config = function()
		--vim.cmd([[set linespace=0]])
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.startify")

		--		dashboard.section.header.val = {
		--			[[                                                                       ]],
		--			[[                                                                       ]],
		--			[[                                                                       ]],
		--			[[                                                                       ]],
		--			[[                                                                     ]],
		--			[[       ████ ██████           █████      ██                     ]],
		--			[[      ███████████             █████                             ]],
		--			[[      █████████ ███████████████████ ███   ███████████   ]],
		--			[[     █████████  ███    █████████████ █████ ██████████████   ]],
		--			[[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
		--			[[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
		--			[[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
		--			[[                                                                       ]],
		--			[[                                                                       ]],
		--			[[                                                                       ]],
		--dashboard.section.footer.val = {
		--			[[                                                                       ]],
		--			[[                                                                       ]],
		--			[[                                                                       ]],
		--			[[                                                                       ]],
		--			[[                                                                     ]],
		--			[[       ████ ██████           █████      ██                     ]],
		--			[[      ███████████             █████                             ]],
		--			[[      █████████ ███████████████████ ███   ███████████   ]],
		--			[[     █████████  ███    █████████████ █████ ██████████████   ]],
		--			[[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
		--			[[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
		--			[[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
		--			[[                                                                       ]],
		--			[[                                                                       ]],
		--			[[                                                                       ]],
		--			}
		--  [[         _          __________                                                                  .                                   	]],
		--  [[     _.-(_)._     ."          ".      .--""--.          _.-{__}-._                              M                                   	]],
		--  [[   .'________'.   | .--------. |    .'        '.      .:-'`____`'-:.                           dM                                   	]],
		--  [[  [____________] /` |________| `\  /   .'``'.   \    /_.-"`_  _`"-._\                          MMr                                  	]],
		--  [[  /  / .\/. \  \|  / / .\/. \ \  ||  .'/.\/.\'.  |  /`   / .\/. \   `\                        4MMML                  .              	]],
		--  [[  |  \__/\__/  |\_/  \__/\__/  \_/|  : |_/\_| ;  |  |    \__/\__/    |                        MMMMM.                xf              	]],
		--  [[  \            /  \            /   \ '.\    /.' / .-\                >/.      .              "MMMMM               .MM-              	]],
		--  [[  /'._  --  _.'\  /'._  --  _.'\   /'. `'--'` .'\/   '._-.__--__.-_.'   \      Mh..          +MMMMMM            .MMMM               	]],
		--  [[ /_   `""""`   _\/_   `""""`   _\ /_  `-./\.-'  _\'.    `""""""""`'`\    \     .MMM.         .MMMMML.          MMMMMh               	]],
		--  [[(__/    '|    \ _)_|           |_)_/            \__)|        '           |      )MMMh.        MMMMMM         MMMMMMM                	]],
		--  [[  |_____'|_____|   \__________/|;                  `_________'________`;-'       3MMMMx.     'MMMMMMf      xnMMMMMM"                	]],
		--  [[   '----------'    '----------'   '--------------'`--------------------`         '*MMMMM      MMMMMM.     nMMMMMMP"                 	]],
		--  [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡀⣤⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⡄⠀⠀⢀⣤⣄⡀⠀⠀⠀⠀⠀                       *MMMMMx    "MMMMM\    .MMMMMMM=                   ]],
		--  [[⠀⣠⣾⡿⠿⣿⣿⣿⣶⣶⣶⡾⠙⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡤⢶⢿⣿⣶⡶⠠⡾⠟⠁⢠⣾⡏⠛⠋⠀⠀⠀⠀⠀⠀                        *MMMMMh   "MMMMM"   JMMMMMMP                     ]],
		--  [[⢰⡟⠁⣠⡾⠉⣿⣿⢹⠉⠉⠀⠀⣿⣇⣰⣦⣀⠀⣠⣤⡀⢀⣴⣄⠀⠀⠀⣀⣴⣄⡀⠀⠀⠀⠀⠀⢸⣿⡇⡆⠀⠉⠋⠀⣠⣤⣀⠀⢸⣿⣇⠀⡀⠀⢀⣠⣤⠀⠀                          MMMMMM   3MMMM.  dMMMMMM            .          ]],
		--  [[⠾⢀⣾⣿⠁⠀⣿⣿⢻⠀⠀⠀⠀⣿⡏⠉⣿⣿⠉⢹⣿⡏⠈⣿⣿⠀⢰⣾⡏⠙⣿⣿⠀⠀⠀⠀⣀⣼⣿⡇⡇⠀⠀⠀⠀⠉⣿⣿⠙⠻⣿⡟⠛⠃⢸⣿⡟⣿⣧⡀                           MMMMMM  "MMMM  .MMMMM(        .nnMP"          ]],
		--  [[⠀⢸⣿⣟⠀⠀⣿⣿⣸⠀⠀⠀⠀⣿⡇⠀⣿⣿⠀⢸⣿⡇⠀⣿⣷⠀⢸⣿⡇⠀⣿⣿⠀⠀⠀⢰⠿⢻⣿⡇⡇⠀⠀⠀⠀⠀⣿⣿⠀⠰⣿⡇⠀⠀⢸⣿⣇⡼⠛⠁               =..          *MMMMx  MMM"  dMMMM"    .nnMMMMM*            ]],
		--  [[⠀⠸⣿⣿⡀⢀⡿⠛⢻⠀⠀⠀⢠⣿⡇⠀⣿⣿⠀⢸⣿⡇⠀⣿⣿⠀⢸⣿⡇⠀⣿⣿⠀⠀⠀⠀⠀⢸⣿⠇⡇⠀⠀⠀⠀⠀⣿⣿⠀⢸⣿⡇⠀⠀⢸⣿⡇⠀⠀⠀                 "MMn...     'MMMMr 'MM   MMM"   .nMMMMMMM*"             ]],
		--  [[⠀⠀⢻⣿⣿⣏⡀⠀⣹⠀⢀⣠⢼⣿⣇⠀⣿⣿⠀⢸⣿⣇⢀⣿⣿⠀⢸⣿⣇⠀⣿⣿⠀⠀⠀⠀⣠⣿⣧⣶⣷⣤⣀⣀⡤⢀⣿⣿⠀⢸⣿⣇⢀⠀⣸⣿⣧⣀⣀⠀                  "4MMMMnn..   *MMM  MM  MMP"  .dMMMMMMM""               ]],
		--  [[⠀⠀⠀⠙⠻⠿⣿⣿⣿⠿⠛⠁⠈⠻⠟⠁⣿⡿⠀⠈⠛⠿⠋⠛⠿⠋⠈⠙⣿⠟⢿⣿⡆⠀⠠⠞⠋⠉⠛⠛⠛⠿⠿⠏⠀⠈⠻⠿⠃⠈⠛⠿⠋⠀⠀⠙⠻⠟⠁⠀                    ^MMMMMMMMx.  *ML "M .M*  .MMMMMM**"                  ]],
		--  [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡼⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⣶⣮⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀                       *PMMMMMMhn. *x > M  .MMMM**""                      ]],
		--  [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀     ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀                          ""**MMMMhx/.h/ .=*"                             ]],
		--  [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀                                    .3P"%....                             ]],
		--  [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀                                  nP"     "*MMnx                 ]],
		-- 		dashboard.section.header.val = {
		-- --			[[                                                          /\              ]],
		-- --			[[                               __                  |\    /  \    /|       ]],
		-- --			[[  ___     ___    ___   __  __ /\_\    ___ ___      | \   \  /   / |       ]],
		-- --			[[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\    |  |  \  /  |  |       ]],
		-- --			[[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \    \  \ \  / /  /        ]],
		-- --			[[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\ |\__\ \\  // /__/|      ]],
		-- --			[[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/  \___--    --___/       ]],
		-- --			[[                                                       /_/||\_\           ]],
		dashboard.section.header.val = {
			[[ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡀⣤⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⡄⠀⠀⢀⣤⣄⡀⠀⠀⠀⠀⠀                                   .                                   	]],
			[[ ⠀⣠⣾⡿⠿⣿⣿⣿⣶⣶⣶⡾⠙⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡤⢶⢿⣿⣶⡶⠠⡾⠟⠁⢠⣾⡏⠛⠋⠀⠀⠀⠀⠀⠀                                   M                                   	]],
			[[ ⢰⡟⠁⣠⡾⠉⣿⣿⢹⠉⠉⠀⠀⣿⣇⣰⣦⣀⠀⣠⣤⡀⢀⣴⣄⠀⠀⠀⣀⣴⣄⡀⠀⠀⠀⠀⠀⢸⣿⡇⡆⠀⠉⠋⠀⣠⣤⣀⠀⢸⣿⣇⠀⡀⠀⢀⣠⣤⠀⠀                                  dM                                   	]],
			[[ ⠾⢀⣾⣿⠁⠀⣿⣿⢻⠀⠀⠀⠀⣿⡏⠉⣿⣿⠉⢹⣿⡏⠈⣿⣿⠀⢰⣾⡏⠙⣿⣿⠀⠀⠀⠀⣀⣼⣿⡇⡇⠀⠀⠀⠀⠉⣿⣿⠙⠻⣿⡟⠛⠃⢸⣿⡟⣿⣧⡀                                  MMr                                  	]],
			[[ ⠀⢸⣿⣟⠀⠀⣿⣿⣸⠀⠀⠀⠀⣿⡇⠀⣿⣿⠀⢸⣿⡇⠀⣿⣷⠀⢸⣿⡇⠀⣿⣿⠀⠀⠀⢰⠿⢻⣿⡇⡇⠀⠀⠀⠀⠀⣿⣿⠀⠰⣿⡇⠀⠀⢸⣿⣇⡼⠛⠁                                 4MMML                  .              	]],
			[[ ⠀⠸⣿⣿⡀⢀⡿⠛⢻⠀⠀⠀⢠⣿⡇⠀⣿⣿⠀⢸⣿⡇⠀⣿⣿⠀⢸⣿⡇⠀⣿⣿⠀⠀⠀⠀⠀⢸⣿⠇⡇⠀⠀⠀⠀⠀⣿⣿⠀⢸⣿⡇⠀⠀⢸⣿⡇⠀⠀⠀                                 MMMMM.                xf              	]],
			[[ ⠀⠀⢻⣿⣿⣏⡀⠀⣹⠀⢀⣠⢼⣿⣇⠀⣿⣿⠀⢸⣿⣇⢀⣿⣿⠀⢸⣿⣇⠀⣿⣿⠀⠀⠀⠀⣠⣿⣧⣶⣷⣤⣀⣀⡤⢀⣿⣿⠀⢸⣿⣇⢀⠀⣸⣿⣧⣀⣀⠀                 .              "MMMMM               .MM-              	]],
			[[ ⠀⠀⠀⠙⠻⠿⣿⣿⣿⠿⠛⠁⠈⠻⠟⠁⣿⡿⠀⠈⠛⠿⠋⠛⠿⠋⠈⠙⣿⠟⢿⣿⡆⠀⠠⠞⠋⠉⠛⠛⠛⠿⠿⠏⠀⠈⠻⠿⠃⠈⠛⠿⠋⠀⠀⠙⠻⠟⠁⠀                  Mh..          +MMMMMM            .MMMM               	]],
			[[ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡼⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⣶⣮⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀                  .MMM.         .MMMMML.          MMMMMh               	]],
			[[         _          __________                                                  )MMMh.        MMMMMM         MMMMMMM                	]],
			[[     _.-(_)._     ."          ".      .--""--.          _.-{__}-._               3MMMMx.     'MMMMMMf      xnMMMMMM"                	]],
			[[   .'________'.   | .--------. |    .'        '.      .:-'`____`'-:.             '*MMMMM      MMMMMM.     nMMMMMMP"                 	]],
			[[  [____________] /` |________| `\  /   .'``'.   \    /_.-"`_  _`"-._\              *MMMMMx    "MMMMM\    .MMMMMMM=                   ]],
			[[  /  / .\/. \  \|  / / .\/. \ \  ||  .'/.\/.\'.  |  /`   / .\/. \   `\              *MMMMMh   "MMMMM"   JMMMMMMP                     ]],
			[[  |  \__/\__/  |\_/  \__/\__/  \_/|  : |_/\_| ;  |  |    \__/\__/    |                MMMMMM   3MMMM.  dMMMMMM            .          ]],
			[[  \            /  \            /   \ '.\    /.' / .-\                >/.               MMMMMM  "MMMM  .MMMMM(        .nnMP"          ]],
			[[  /'._  --  _.'\  /'._  --  _.'\   /'. `'--'` .'\/   '._-.__--__.-_.'   \  =..          *MMMMx  MMM"  dMMMM"    .nnMMMMM*            ]],
			[[ /_   `""""`   _\/_   `""""`   _\ /_  `-./\.-'  _\'.    `""""""""`'`\    \   "MMn...     'MMMMr 'MM   MMM"   .nMMMMMMM*"             ]],
			[[(__/    '|    \ _)_|           |_)_/            \__)|        '           |    "4MMMMnn..   *MMM  MM  MMP"  .dMMMMMMM""               ]],
			[[  |_____'|_____|   \__________/|;                  `_________'________`;-'      ^MMMMMMMMx.  *ML "M .M*  .MMMMMM**"                  ]],
			[[   '----------'    '----------'   '--------------'`--------------------`           *PMMMMMMhn. *x > M  .MMMM**""                      ]],
			[[                                                                                      ""**MMMMhx/.h/ .=*"                             ]],
			[[                                                                                               .3P"%....                             ]],
			[[                                                                                             nP"     "*MMnx                 ]],
		}

		--dashboard.section.header.val = {
		-- [[		                                                                                ]],
		-- [[		                                                                                                .                                ]],
		-- [[		                                                                                                M                                ]],
		-- [[		                                                                                               dM                                ]],
		-- [[		                                                                                             MMr                               ]],
		-- [[		       ████ ██████           █████      ██                                            4MMML                  .           ]],
		-- [[		      ███████████             █████                                                    MMMMM.                xf           ]],
		-- [[		      █████████ ███████████████████ ███   ███████████          .              "MMMMM               .MM-           ]],
		-- [[		     █████████  ███    █████████████ █████ ██████████████           Mh..          +MMMMMM            .MMMM            ]],
		-- [[		    █████████ ██████████ █████████ █████ █████ ████ █████           .MMM.         .MMMMML.          MMMMMh            ]],
		-- [[		  ███████████ ███    ███ █████████ █████ █████ ████ █████           )MMMh.        MMMMMM         MMMMMMM             ]],
		-- [[		 ██████  █████████████████████ ████ █████ █████ ████ ██████           3MMMMx.     'MMMMMMf      xnMMMMMM"             ]],
		-- [[         _          __________                                                                 '*MMMMM      MMMMMM.     nMMMMMMP"               ]],
		-- [[     _.-(_)._     ."          ".      .--""--.          _.-{__}-._                               *MMMMMx    "MMMMM\    .MMMMMMM=                ]],
		-- [[   .'________'.   | .--------. |    .'        '.      .:-'`____`'-:.                              *MMMMMh   "MMMMM"   JMMMMMMP                  ]],
		-- [[  [____________] /` |________| `\  /   .'``'.   \    /_.-"`_  _`"-._\                               MMMMMM   3MMMM.  dMMMMMM            .       ]],
		-- [[  /  / .\/. \  \|  / / .\/. \ \  ||  .'/.\/.\'.  |  /`   / .\/. \   `\                               MMMMMM  "MMMM  .MMMMM(        .nnMP"       ]],
		-- [[  |  \__/\__/  |\_/  \__/\__/  \_/|  : |_/\_| ;  |  |    \__/\__/    |                   =..          *MMMMx  MMM"  dMMMM"    .nnMMMMM*         ]],
		-- [[  \            /  \            /   \ '.\    /.' / .-\                >/.                   "MMn...     'MMMMr 'MM   MMM"   .nMMMMMMM*"          ]],
		-- [[  /'._  --  _.'\  /'._  --  _.'\   /'. `'--'` .'\/   '._-.__--__.-_.'   \                   "4MMMMnn..   *MMM  MM  MMP"  .dMMMMMMM""            ]],
		-- [[ /_   `""""`   _\/_   `""""`   _\ /_  `-./\.-'  _\'.    `""""""""`'`\                         ^MMMMMMMMx.  *ML "M .M*  .MMMMMM**"               ]],
		-- [[(__/    '|    \ _)_|           |_)_/            \__)|        '                                   *PMMMMMMhn. *x > M  .MMMM**""                  ]],
		-- [[  |_____'|_____|   \__________/|;                  `_________'________`;-                           ""**MMMMhx/.h/ .=*"                         ]],
		-- [[   '----------'    '----------'   '--------------'`--------------------`                                     .3P"%....                          ]],}         --    button("u", "  > Update plugins", ":PackerSync<CR>"),
		--    button("q", "  > Quit Neovim", ":qa<CR>"),
		--}
		dashboard.section.header.opts.hl = "AlphaHeader"

		--dashboard.section.header.opts.hl = "AlphaFooter"
		dashboard.section.buttons = nil
		alpha.setup(dashboard.opts)
		vim.api.nvim_set_hl(0, "AlphaHeader", { fg = "#09ea10" })
		vim.api.nvim_set_hl(0, "AlphaFooter", { fg = "#0ff707" })
		vim.api.nvim_set_hl(0, "AlphaHeaderLabel", { fg = "#d13223" })
		vim.api.nvim_set_hl(0, "AlphaHeaderShortcut", { fg = "#d13223" })
		vim.api.nvim_set_hl(0, "AlphaButtons", { fg = "#870000", bg = "#d13223" })
	end,
}

--vim.api.nvim_set_hl(0, "AlphaHeaderFG", { fg = "#ffffff" })
--vim.api.nvim_set_hl(0, "AlphaHeaderBG", { bg = "#ffffff" })
