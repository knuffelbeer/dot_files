require("luasnip.session.snippet_collection").clear_snippets("cpp")

local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local c = ls.choice_node
local t = ls.text_node
local rep = require("luasnip.extras").rep

local fmt = require("luasnip.extras.fmt").fmt
local function type_node(idx)
	return c(idx, { t(""), t("int"), t("float"), t("bool") })
end

ls.add_snippets("cpp", {
	s("pr", fmt("std::cout << {} << '\\n';\n{}", { i(1), i(2) })),
	s("sp", fmt("std::unique_ptr<{}> {} = str::make_unique<{}>({});\n{}", { type_node(1), i(2), rep(1), i(3), i(4) })),
	s("sv", fmt("std::vector<{}> {};\n{}", { type_node(1), i(2, "vec"), i(3) })),
	s("sa", fmt("std::array<{}> {};\n{}", { type_node(1), i(2, "arr"), i(3) })),
	s("df", fmt("#define {}", { i(1) })),
	s("im", fmt("int main {{\n {}\n return 0;\n }}", { i(1) })),
	-- st is int main include iostream
})
