
require("luasnip.session.snippet_collection").clear_snippets "python"

local ls = require "luasnip"

local s = ls.snippet
local i = ls.insert_node

local fmt = require("luasnip.extras.fmt").fmt
ls.add_snippets("python", {
  s("pr", fmt("print({})", { i(1) })),
  s("im", fmt("if __name__ == '__main__': \n\t{} ", { i(1)})),

	s("ip", fmt("import numpy as np\nimport pandas as pd\nimport matplotlib.pyplot as plt\n{}", {i(1)}))
-- 	"",
-- 	'if __name__ == "__main__":',
-- 	"  ",
-- 
})
