require("luasnip.session.snippet_collection").clear_snippets("tex")

local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local c = ls.choice_node
local t = ls.text_node
local rep = require("luasnip.extras").rep

local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("tex", {
	--s section
	--fr fraction
	--sum sum
	s("f", fmt("\\frac{{{}}}{{{}}}{}", { i(1), i(2), i(3) })),
	s("e", fmt("\\exp^{{{}}}", { i(1) })),
	s("e", fmt("\\exp^{{{}}}", { i(1) })),
	s("k", fmt("^{{{}}}{}", { i(1), i(2) })),

	s("d", fmt("\\frac{{\\partial}}{{\\partial {}}}", { i(1) })),
	s("d2", fmt("\\frac{{\\partial^{{2}}}}{{\\partial {}^{{2}}}}{}", { i(1), i(2) })),
	s("dx", fmt("\\frac{{\\partial}}{{\\partial {}}}{}", { t("x"), i(1) })),
	s("dy", fmt("\\frac{{\\partial}}{{\\partial {}}}{}", { t("y"), i(1) })),
	s("K", fmt("_{{{}}}{}", { i(1), i(2) })),
	s("p", fmt("{}", { t("\\pi") })),
	s("P", fmt("{}", { t("\\phi") })),
	s("l", fmt("{}", { t("\\lambda") })),
	s("ha", fmt("\\mathcal{{{}}}{}", { i(1), i(2) })),
	s("n", fmt("\\|{}\\|{}", { i(1), i(2) })),
	s("E", fmt("\\sum_{{{}}}^{{{}}} {}", { c(1, { t(""), t("n = 0") }), c(2, { t(""), t("\\infy") }), i(3) })),
	s("*", fmt("{}", { t("\\cdot") })),
	s(
		"b",
		fmt("\\begin{{{}}}\n {} \n \\end{{{}}}\n {}", { c(1, { t(""), t("cases"), t("aligned") }), i(2), rep(1), i(3) })
	),
	s("(", fmt("\\left({}\\right){}", { i(1), i(2) })),
	s("[", fmt("\\left[{}\\right]{}", { i(1), i(2) })),

	-- st is int main include iostream
})
