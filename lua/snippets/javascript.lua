local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local js_ts_snippets = {
    -- Imports/Exports
    s("imp", {
        t("import "),
        c(1, {
            fmt("{} from '{}'", {i(1, "module"), i(2, "package")}),
            fmt("{{ {} }} from '{}'", {i(1, "Component"), i(2, "package")}),
            fmt("* as {} from '{}'", {i(1, "name"), i(2, "package")}),
        }),
    }),
    
    s("impt", {
        t("import type { "),
        i(1, "Type"),
        t(" } from '"),
        i(2, "package"),
        t("'"),
    }),
    
    s("exp", {
        t("export "),
        c(1, {
            fmt("default {}", i(1)),
            fmt("{{ {} }}", i(1)),
            fmt("const {} = {}", {i(1, "name"), i(2, "value")}),
            fmt("function {}({}) {{\n\t{}\n}}", {i(1, "name"), i(2), i(3)}),
        }),
    }),
    
    s("expd", {
        t("export default "),
        i(1),
    }),
    
    s("expt", {
        t("export type { "),
        i(1, "Type"),
        t(" }"),
    }),
    
    -- Variables
    s("co", {
        t("const "),
        i(1, "name"),
        t(" = "),
        i(2, "value"),
    }),
    
    s("le", {
        t("let "),
        i(1, "name"),
        t(" = "),
        i(2, "value"),
    }),
    
    s("des", {
        t("const { "),
        i(1, "prop"),
        t(" } = "),
        i(2, "object"),
    }),
    
    s("desa", {
        t("const [ "),
        i(1, "item"),
        t(" ] = "),
        i(2, "array"),
    }),
    
    -- Functions
    s("fn", {
        t("function "),
        i(1, "name"),
        t("("),
        i(2),
        t({") {", "\t"}),
        i(3),
        t({"", "}"}),
    }),
    
    s("af", {
        t("const "),
        i(1, "name"),
        t(" = ("),
        i(2),
        t(") => "),
        c(3, {
            i(1),
            fmt("{{\n\t{}\n}}", i(1)),
        }),
    }),
    
    s("aaf", {
        t("async ("),
        i(1),
        t(") => "),
        c(2, {
            i(1),
            fmt("{{\n\t{}\n}}", i(1)),
        }),
    }),
    
    s("afn", {
        t("async function "),
        i(1, "name"),
        t("("),
        i(2),
        t({") {", "\t"}),
        i(3),
        t({"", "}"}),
    }),
    
    s("iife", {
        t({"(", "  ("}),
        i(1),
        t({") => {", "\t"}),
        i(2),
        t({"", "  }"}),
        t({"", ")("}),
        i(3),
        t(")"),
    }),
    
    -- Classes
    s("cls", {
        t("class "),
        i(1, "ClassName"),
        c(2, {
            t(""),
            fmt(" extends {}", i(1, "BaseClass")),
            fmt(" implements {}", i(1, "Interface")),
        }),
        t({" {", "\t"}),
        i(3),
        t({"", "}"}),
    }),
    
    s("ctor", {
        t("constructor("),
        i(1),
        t({") {", "\t"}),
        c(2, {
            t(""),
            t("super()"),
        }),
        i(3),
        t({"", "}"}),
    }),
    
    s("met", {
        c(1, {
            t(""),
            t("public "),
            t("private "),
            t("protected "),
            t("static "),
        }),
        i(2, "method"),
        t("("),
        i(3),
        t(")"),
        c(4, {
            t(""),
            fmt(": {}", i(1, "void")),
        }),
        t({" {", "\t"}),
        i(5),
        t({"", "}"}),
    }),
    
    s("get", {
        t("get "),
        i(1, "property"),
        t({"() {", "\t"}),
        t("return "),
        i(2, "this._property"),
        t({"", "}"}),
    }),
    
    s("set", {
        t("set "),
        i(1, "property"),
        t("("),
        i(2, "value"),
        t({") {", "\t"}),
        t("this._"),
        rep(1),
        t(" = "),
        rep(2),
        t({"", "}"}),
    }),
    
    -- TypeScript Types
    s("int", {
        t("interface "),
        i(1, "IName"),
        c(2, {
            t(""),
            fmt(" extends {}", i(1, "IBase")),
        }),
        t({" {", "\t"}),
        i(3, "prop: string"),
        t({"", "}"}),
    }),
    
    s("typ", {
        t("type "),
        i(1, "Name"),
        t(" = "),
        c(2, {
            i(1, "string"),
            fmt("{{\n\t{}\n}}", i(1, "prop: string")),
            fmt("{} | {}", {i(1, "Type1"), i(2, "Type2")}),
        }),
    }),
    
    s("enu", {
        t("enum "),
        i(1, "Name"),
        t({" {", "\t"}),
        i(2, "VALUE"),
        t(" = "),
        i(3, "0"),
        t({",", "}"}),
    }),
    
    -- Control Flow
    s("if", {
        t("if ("),
        i(1, "condition"),
        t({") {", "\t"}),
        i(2),
        t({"", "}"}),
    }),
    
    s("ife", {
        t("if ("),
        i(1, "condition"),
        t({") {", "\t"}),
        i(2),
        t({"", "} else {", "\t"}),
        i(3),
        t({"", "}"}),
    }),
    
    s("elif", {
        t("else if ("),
        i(1, "condition"),
        t({") {", "\t"}),
        i(2),
        t({"", "}"}),
    }),
    
    s("ter", {
        i(1, "condition"),
        t(" ? "),
        i(2, "true"),
        t(" : "),
        i(3, "false"),
    }),
    
    s("sw", {
        t("switch ("),
        i(1, "expression"),
        t({") {", "\tcase "}),
        i(2, "value"),
        t({":","    \t"}),
        i(3),
        t({"", "    \tbreak", "\tdefault:", "    \t"}),
        i(4),
        t({"", "}"}),
    }),
    
    -- Loops
    s("for", {
        t("for ("),
        c(1, {
            fmt("let {} = 0; {} < {}; {}++", {
                i(1, "i"),
                rep(1),
                i(2, "length"),
                rep(1)
            }),
            fmt("const {} of {}", {i(1, "item"), i(2, "array")}),
            fmt("const {} in {}", {i(1, "key"), i(2, "object")}),
            fmt("const [{}, {}] of {}.entries()", {i(1, "index"), i(2, "item"), i(3, "array")}),
        }),
        t({") {", "\t"}),
        i(2),
        t({"", "}"}),
    }),
    
    s("forof", {
        t("for (const "),
        i(1, "item"),
        t(" of "),
        i(2, "array"),
        t({") {", "\t"}),
        i(3),
        t({"", "}"}),
    }),
    
    s("forin", {
        t("for (const "),
        i(1, "key"),
        t(" in "),
        i(2, "object"),
        t({") {", "\t"}),
        i(3),
        t({"", "}"}),
    }),
    
    s("foreach", {
        i(1, "array"),
        t(".forEach(("),
        i(2, "item"),
        t({") => {", "\t"}),
        i(3),
        t({"", "})"}),
    }),
    
    s("while", {
        t("while ("),
        i(1, "condition"),
        t({") {", "\t"}),
        i(2),
        t({"", "}"}),
    }),
    
    -- Array Methods
    s("map", {
        i(1, "array"),
        t(".map(("),
        i(2, "item"),
        t(") => "),
        c(3, {
            i(1),
            fmt("{{\n\t{}\n}}", i(1)),
        }),
        t(")"),
    }),
    
    s("filter", {
        i(1, "array"),
        t(".filter(("),
        i(2, "item"),
        t(") => "),
        i(3, "condition"),
        t(")"),
    }),
    
    s("reduce", {
        i(1, "array"),
        t(".reduce(("),
        i(2, "acc"),
        t(", "),
        i(3, "item"),
        t({") => {", "\t"}),
        i(4, "return acc"),
        t({"", "}, "}),
        i(5, "initialValue"),
        t(")"),
    }),
    
    s("find", {
        i(1, "array"),
        t(".find(("),
        i(2, "item"),
        t(") => "),
        i(3, "condition"),
        t(")"),
    }),
    
    s("some", {
        i(1, "array"),
        t(".some(("),
        i(2, "item"),
        t(") => "),
        i(3, "condition"),
        t(")"),
    }),
    
    s("every", {
        i(1, "array"),
        t(".every(("),
        i(2, "item"),
        t(") => "),
        i(3, "condition"),
        t(")"),
    }),
    
    -- Promises & Async
    s("prom", {
        t("new Promise((resolve, reject) => {"),
        t({"\n\t"}),
        i(1),
        t({"", "})"}),
    }),
    
    s("then", {
        t(".then(("),
        i(1, "result"),
        t({") => {", "\t"}),
        i(2),
        t({"", "})"}),
    }),
    
    s("catch", {
        t(".catch(("),
        i(1, "error"),
        t({") => {", "\t"}),
        i(2),
        t({"", "})"}),
    }),
    
    s("awa", {
        t("await "),
        i(1, "promise"),
    }),
    
    s("asyncf", {
        t("async function "),
        i(1, "name"),
        t("("),
        i(2),
        t({") {", "\t"}),
        i(3),
        t({"", "}"}),
    }),
    
    -- Try-Catch
    s("try", {
        t({"try {", "\t"}),
        i(1),
        t({"", "} catch ("}),
        i(2, "error"),
        t({") {", "\t"}),
        i(3),
        t({"", "}"}),
    }),
    
    s("tryf", {
        t({"try {", "\t"}),
        i(1),
        t({"", "} catch ("}),
        i(2, "error"),
        t({") {", "\t"}),
        i(3),
        t({"", "} finally {", "\t"}),
        i(4),
        t({"", "}"}),
    }),
    
    -- Console
    s("cl", {
        t("console.log("),
        i(1),
        t(")"),
    }),
    
    s("ce", {
        t("console.error("),
        i(1),
        t(")"),
    }),
    
    s("cw", {
        t("console.warn("),
        i(1),
        t(")"),
    }),
    
    s("ct", {
        t("console.table("),
        i(1),
        t(")"),
    }),
    
    s("cd", {
        t("console.dir("),
        i(1),
        t(", { depth: null })"),
    }),
    
    -- DOM
    s("qs", {
        t("document.querySelector('"),
        i(1, ".class"),
        t("')"),
    }),
    
    s("qsa", {
        t("document.querySelectorAll('"),
        i(1, ".class"),
        t("')"),
    }),
    
    s("gid", {
        t("document.getElementById('"),
        i(1, "id"),
        t("')"),
    }),
    
    s("ael", {
        i(1, "element"),
        t(".addEventListener('"),
        i(2, "click"),
        t("', ("),
        i(3, "e"),
        t({") => {", "\t"}),
        i(4),
        t({"", "})"}),
    }),
    
    -- React/JSX
    s("rfc", {
        t("const "),
        i(1, "Component"),
        t(" = ("),
        c(2, {
            t(""),
            t("props"),
            fmt("{{ {} }}", i(1)),
        }),
        t({") => {", "\t"}),
        t("return ("),
        t({"\n\t\t<div>", "\t\t\t"}),
        i(3),
        t({"", "\t\t</div>", "\t)", "}", "", "export default "}),
        rep(1),
    }),
    
    s("rafce", {
        t("const "),
        i(1, "Component"),
        t(" = ("),
        c(2, {
            t(""),
            t("props"),
            fmt("{{ {} }}", i(1)),
        }),
        t({") => {", "\t"}),
        t("return ("),
        t({"\n\t\t<>", "\t\t\t"}),
        i(3),
        t({"", "\t\t</>", "\t)", "}", "", "export default "}),
        rep(1),
    }),
    
    s("us", {
        t("const ["),
        i(1, "state"),
        t(", set"),
        f(function(args)
            return args[1][1]:gsub("^%l", string.upper)
        end, {1}),
        t("] = useState("),
        i(2, "initialState"),
        t(")"),
    }),
    
    s("ue", {
        t({"useEffect(() => {", "\t"}),
        i(1),
        t({"", "}, ["}),
        i(2),
        t("])"),
    }),
    
    s("uef", {
        t({"useEffect(() => {", "\t"}),
        i(1),
        t({"", "\treturn () => {", "\t\t"}),
        i(2),
        t({"", "\t}", "}, ["}),
        i(3),
        t("])"),
    }),
    
    s("uc", {
        t("const "),
        i(1, "value"),
        t(" = useContext("),
        i(2, "Context"),
        t(")"),
    }),
    
    s("ur", {
        t("const "),
        i(1, "ref"),
        t(" = useRef("),
        i(2, "null"),
        t(")"),
    }),
    
    s("um", {
        t("const "),
        i(1, "memoized"),
        t(" = useMemo(() => "),
        c(2, {
            i(1),
            fmt("{{\n\t{}\n}}", i(1)),
        }),
        t(", ["),
        i(3),
        t("])"),
    }),
    
    s("ucb", {
        t("const "),
        i(1, "callback"),
        t(" = useCallback(("),
        i(2),
        t({") => {", "\t"}),
        i(3),
        t({"", "}, ["}),
        i(4),
        t("])"),
    }),
    
    -- Testing
    s("desc", {
        t("describe('"),
        i(1, "Component"),
        t({"', () => {", "\t"}),
        i(2),
        t({"", "})"}),
    }),
    
    s("it", {
        t("it('"),
        i(1, "should"),
        t({"', () => {", "\t"}),
        i(2),
        t({"", "})"}),
    }),
    
    s("ita", {
        t("it('"),
        i(1, "should"),
        t({"', async () => {", "\t"}),
        i(2),
        t({"", "})"}),
    }),
    
    s("bef", {
        t({"beforeEach(() => {", "\t"}),
        i(1),
        t({"", "})"}),
    }),
    
    s("aft", {
        t({"afterEach(() => {", "\t"}),
        i(1),
        t({"", "})"}),
    }),
    
    -- Miscellaneous
    s("ret", {
        t("return "),
        i(1),
    }),
    
    s("todo", {
        t("// TODO: "),
        i(1, "implement"),
    }),
    
    s("fixme", {
        t("// FIXME: "),
        i(1, "fix this"),
    }),
    
    s("timeout", {
        t("setTimeout(() => {"),
        t({"\n\t"}),
        i(1),
        t({"", "}, "}),
        i(2, "1000"),
        t(")"),
    }),
    
    s("interval", {
        t("setInterval(() => {"),
        t({"\n\t"}),
        i(1),
        t({"", "}, "}),
        i(2, "1000"),
        t(")"),
    }),
    
    s("fetch", {
        t("fetch('"),
        i(1, "url"),
        t({"')", "\t.then(response => response.json())", "\t.then(data => "}),
        c(2, {
            i(1),
            fmt("{{\n\t\t{}\n\t}}", i(1)),
        }),
        t(")"),
        t({"\n\t.catch(error => console.error(error))"}),
    }),
    
    s("fetcha", {
        t({"try {", "\tconst response = await fetch('"}),
        i(1, "url"),
        t({"')", "\tconst data = await response.json()", "\t"}),
        i(2),
        t({"", "} catch (error) {", "\t"}),
        i(3, "console.error(error)"),
        t({"", "}"}),
    }),
}

return js_ts_snippets
