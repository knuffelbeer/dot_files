local home = os.getenv("HOME")
local nl = xplr.util.paint("\\n", { add_modifiers = { "Italic", "Dim" } })
local xpm_path = home .. "/.local/share/xplr/dtomvan/xpm.xplr"
local xpm_url = "https://github.com/dtomvan/xpm.xplr"
version = "0.21.5"
package.path = package.path .. ";" .. xpm_path .. "/?.lua;" .. xpm_path .. "/?/init.lua"

os.execute(string.format("[ -e '%s' ] || git clone '%s' '%s'", xpm_path, xpm_url, xpm_path))
--require("xpm").setup({
--
--    -- This works
--    'dtomvan/xpm.xplr',
--
--    -- Or this
--    'github:dtomvan/xpm.xplr',
--
--    -- Or this
--    'https://github.com/dtomvan/xpm.xplr',
--
--    -- You can also use a field
--    { name = "dtomvan/xpm.xplr" },
--})

-- Or

require("xpm").setup({
	plugins = {
		-- Let xpm manage itself
		"dtomvan/xpm.xplr",
		{ name = "sayanarijit/fzf.xplr" },
		"prncss-xyz/icons.xplr",
		"sayanarijit/zoxide.xplr",
		{
			"dtomvan/extra-icons.xplr",
			after = function()
				require("extra-icons").setup()
				xplr.config.general.table.row.cols[2] = { format = "custom.icons_dtomvan_col_1" }
			end,
		},
		"sayanarijit/xclip.xplr",
		"sayanarijit/zentable.xplr",
	},
	auto_install = true,
	auto_cleanup = true,
})
require("zentable").setup()
require("fzf").setup({
	mode = "default",
	key = "ctrl-f",
	bin = "fzf",
	args = "--preview 'pistol {}'",
	recursive = true, -- If true, search all files under $PWD
	enter_dir = true, -- Enter if the result is directory
})

require("icons").setup()

require("xclip").setup({
	copy_command = "xclip-copyfile",
	copy_paths_command = "xclip -sel clip",
	paste_command = "xclip-pastefile",
	keep_selection = false,
})

require("zoxide").setup({
	bin = "zoxide",
	mode = "default",
	key = "Z",
})

-- BINGINGS
xplr.config.modes.builtin.default.key_bindings.on_key.P = {
	help = "preview",
	messages = {
		{
			BashExecSilently0 = [===[
        FIFO_PATH="/tmp/xplr.fifo"

        if [ -e "$FIFO_PATH" ]; then
          "$XPLR" -m StopFifo
          rm -f -- "$FIFO_PATH"
        else
          mkfifo "$FIFO_PATH"
          "$HOME/.local/bin/imv-open.sh" "$FIFO_PATH" "$XPLR_FOCUS_PATH" &
          "$XPLR" -m 'StartFifo: %q' "$FIFO_PATH"
        fi
      ]===],
		},
	},
}

xplr.config.modes.builtin.go_to.key_bindings.on_key.h = {
	help = "history",
	messages = {
		"PopMode",
		{
			BashExec0 = [===[
        PTH=$(cat "${XPLR_PIPE_HISTORY_OUT:?}" | sort -z -u | fzf --read0)
        if [ "$PTH" ]; then
          "$XPLR" -m 'ChangeDirectory: %q' "$PTH"
        fi
      ]===],
		},
	},
}
-- SELECTION PANEL
local function stat(node)
	return xplr.util.to_yaml(xplr.util.node(node.absolute_path))
end

local function read(path, height)
	local p = io.open(path)

	if p == nil then
		return nil
	end

	local i = 0
	local res = ""
	for line in p:lines() do
		if line:match("[^ -~\n\t]") then
			p:close()
			return
		end

		res = res .. line .. "\n"
		if i == height then
			break
		end
		i = i + 1
	end
	p:close()

	return res
end

xplr.fn.custom.preview_pane = {}
xplr.fn.custom.preview_pane.render = function(ctx)
	local title = nil
	local body = ""
	local n = ctx.app.focused_node
	if n and n.canonical then
		n = n.canonical
	end

	if n then
		--title = { format = n.absolute_path, style = xplr.util.lscolor(n.absolute_path) }
		title = { format = n.absolute_path, style = { fg = { Rgb = { 170, 0, 0 } } } }
		if n.is_file then
			body = read(n.absolute_path, ctx.layout_size.height) or stat(n)
		else
			--body = stat(n)

			body = ""
		end
	end

	return { CustomParagraph = { ui = { title = title }, body = body } }
end

local preview_pane = { Dynamic = "custom.preview_pane.render" }
local split_preview = {
	Horizontal = {
		config = {
			constraints = {
				{ Percentage = 60 },
				{ Percentage = 40 },
			},
		},
		splits = {
			{
				Vertical = {
					config = {
						constraints = {
							--{ Length = 3 },
							{ Min = 1 },
							{ Length = 3 },
						},
					},
					splits = {
						--"SortAndFilter",
						"Table",
						"InputAndLogs",
					},
				},
			},
			preview_pane,
		},
	},
}

--require("icons").setup()
xplr.config.layouts.builtin.default = split_preview
--	xplr.util.layout_replace(xplr.config.layouts.builtin.default, "Table", split_preview)
xplr.config.modes.builtin.default.key_bindings.on_key.M = {
	help = "bookmark",
	messages = {
		{
			BashExecSilently0 = [===[
        PTH="${XPLR_FOCUS_PATH:?}"
        PTH_ESC=$(printf %q "$PTH")
        if echo "${PTH:?}" >> "${XPLR_SESSION_PATH:?}/bookmarks"; then
          "$XPLR" -m 'LogSuccess: %q' "$PTH_ESC added to bookmarks"
        else
          "$XPLR" -m 'LogError: %q' "Failed to bookmark $PTH_ESC"
        fi
      ]===],
		},
	},
}

xplr.config.modes.builtin.default.key_bindings.on_key["`"] = {
	help = "go to bookmark",
	messages = {
		{
			BashExec0 = [===[
        PTH=$(cat "${XPLR_SESSION_PATH:?}/bookmarks" | fzf --no-sort)
        PTH_ESC=$(printf %q "$PTH")
        if [ "$PTH" ]; then
          "$XPLR" -m 'FocusPath: %q' "$PTH"
        fi
      ]===],
		},
	},
}
xplr.config.modes.builtin.number = {
  name = "number",
  prompt = ":",
  key_bindings = {
    on_key = {
      ["down"] = {
        help = "to down",
        messages = {
          "FocusNextByRelativeIndexFromInput",
          "PopMode",
        },
      },
      ["enter"] = {
        help = "to index",
        messages = {
          "FocusByIndexFromInput",
          "PopMode",
        },
      },
      ["up"] = {
        help = "to up",
        messages = {
          "FocusPreviousByRelativeIndexFromInput",
          "PopMode",
        },
      },
    },
    on_navigation = {
      messages = {
        "UpdateInputBufferFromKey",
      },
    },
    on_number = {
      help = "input",
      messages = {
        "UpdateInputBufferFromKey",
      },
    },
  },
}
xplr.config.modes.builtin.default.key_bindings.on_key["v"] =
    xplr.config.modes.builtin.default.key_bindings.on_key["space"]
xplr.config.modes.builtin.default.key_bindings.on_key["V"] =
    xplr.config.modes.builtin.default.key_bindings.on_key["ctrl-a"]
--xplr.config.modes.builtin.default.key_bindings.on_key["/"] =
--	xplr.config.modes.builtin.default.key_bindings.on_key["ctrl-f"]
xplr.config.modes.builtin.default.key_bindings.on_key["h"] =
    xplr.config.modes.builtin.default.key_bindings.on_key["left"]
xplr.config.modes.builtin.default.key_bindings.on_key["H"] =
    xplr.config.modes.builtin.default.key_bindings.on_key["left"]
xplr.config.modes.builtin.default.key_bindings.on_key["J"] =
    xplr.config.modes.builtin.default.key_bindings.on_key["down"]
xplr.config.modes.builtin.default.key_bindings.on_key["K"] = xplr.config.modes.builtin.default.key_bindings.on_key["up"]
xplr.config.modes.builtin.default.key_bindings.on_key["l"] =
    xplr.config.modes.builtin.default.key_bindings.on_key["right"]
xplr.config.modes.builtin.default.key_bindings.on_key["L"] =
    xplr.config.modes.builtin.default.key_bindings.on_key["right"]
xplr.config.modes.builtin.default.key_bindings.on_key["tab"] =
    xplr.config.modes.builtin.default.key_bindings.on_key["ctrl-i"] -- compatibility workaround
xplr.config.modes.builtin.default.key_bindings.on_key["?"] = xplr.config.general.global_key_bindings.on_key["f1"]
xplr.config.modes.builtin.default.key_bindings.on_key.enter = {
	help = "open in editor",
	messages = {
		{
			BashExec0 = [===[
              ${EDITOR:-vi} "${XPLR_FOCUS_PATH:?}"
            ]===],
		},
		"PopMode",
	},
}
xplr.config.modes.builtin.default.key_bindings.on_key["j"] = 
    xplr.config.modes.builtin.default.key_bindings.on_key["down"]

    --xplr.config.modes.builtin.default.key_bindings.on_key["down"]
xplr.config.modes.builtin.default.key_bindings.on_key["k"] = xplr.config.modes.builtin.default.key_bindings.on_key["up"]

--STYLE --GENERAL{ Rgb = { 170, 0, 0 } }
--xplr.config.general.focus_ui.style.bg =  "LightRed"
xplr.config.general.focus_ui.style.fg = { Rgb = { 170, 0, 0 } }
xplr.config.general.selection_ui.style.fg = { Rgb = { 170, 0, 0 } }
xplr.config.general.panel_ui.default.title.style.fg = { Rgb = { 170, 0, 0 } }
xplr.config.general.panel_ui.default.borders = {}
--xplr.config.general.panel_ui.default.style.fg = "LightRed"
xplr.config.general.panel_ui.default.style.fg = { Rgb = { 103, 103, 103 } }
xplr.config.general.show_hidden = true
xplr.config.general.enforce_bounded_index_navigation = true
xplr.config.general.focus_selection_ui.style = {
	add_modifiers = { "Bold", "CrossedOut" },
}
xplr.config.general.table.row.style = { fg = { Rgb = { 243, 99, 49 } } }
xplr.config.general.selection_ui.style = {
	fg = "Black",
	bg = { Rgb = { 170, 0, 0 } },
	add_modifiers = { "CrossedOut" },
}
