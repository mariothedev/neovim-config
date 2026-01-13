local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local go_snippets = {
    -- Package and Imports
    s("pkg", {
        t("package "),
        i(1, "main"),
    }),
    
    s("imp", {
        t("import \""),
        i(1, "fmt"),
        t("\""),
    }),
    
    s("imps", {
        t({"import (", "\t\""}),
        i(1, "fmt"),
        t({"\"", "\t\""}),
        i(2, "log"),
        t({"\"", "})"}),
    }),
    
    -- Main function
    s("main", {
        t({"func main() {", "\t"}),
        i(1),
        t({"", "}", ""}),
    }),
    
    -- Function declarations
    s("func", {
        t("func "),
        i(1, "name"),
        t("("),
        i(2),
        t(") "),
        c(3, {
            t(""),
            fmt("({})", i(1)),
            fmt("({}, {})", {i(1), i(2)}),
        }),
        t({" {", "\t"}),
        i(0),
        t({"", "}"}),
    }),
    
    s("meth", {
        t("func ("),
        i(1, "r"),
        t(" "),
        c(2, {t("*"), t("")}),
        i(3, "Receiver"),
        t(") "),
        i(4, "Method"),
        t("("),
        i(5),
        t(") "),
        c(6, {
            t(""),
            fmt("({})", i(1)),
            fmt("({}, {})", {i(1), i(2)}),
        }),
        t({" {", "\t"}),
        i(0),
        t({"", "}"}),
    }),
    
    -- Variables and Constants
    s("var", {
        t("var "),
        i(1, "name"),
        t(" "),
        i(2, "string"),
        t(" = "),
        i(3, "\"\""),
    }),
    
    s("vars", {
        t({"var (", "\t"}),
        i(1, "name"),
        t(" "),
        i(2, "string"),
        t(" = "),
        i(3, "\"\""),
        t({"", "\t"}),
        i(4),
        t({"", ")"}),
    }),
    
    s("const", {
        t("const "),
        i(1, "name"),
        t(" = "),
        i(2, "\"\""),
    }),
    
    s("consts", {
        t({"const (", "\t"}),
        i(1, "name"),
        t(" = "),
        i(2, "\"\""),
        t({"", "\t"}),
        i(3),
        t({"", ")"}),
    }),
    
    -- Error handling
    s("iferr", {
        t({"if err != nil {", "\t"}),
        c(1, {
            t("return err"),
            fmt("return {}", i(1, "nil, err")),
            fmt("log.Fatal(err)", {}),
            fmt("panic(err)", {}),
        }),
        t({"", "}"}),
    }),
    
    s("errn", {
        t("if err != nil {"),
        t({"", "\treturn "}),
        i(1, "nil, "),
        t("err"),
        t({"", "}"}),
    }),
    
    s("errw", {
        t("if err != nil {"),
        t({"", "\treturn "}),
        i(1, "nil, "),
        t("fmt.Errorf(\""),
        i(2, "failed to"),
        t(": %w\", err)"),
        t({"", "}"}),
    }),
    
    -- Structs and Interfaces
    s("struct", {
        t("type "),
        i(1, "Name"),
        t({" struct {", "\t"}),
        i(2, "field string"),
        t({"", "}"}),
    }),
    
    s("iface", {
        t("type "),
        i(1, "Name"),
        t({" interface {", "\t"}),
        i(2, "Method()"),
        t({"", "}"}),
    }),
    
    -- Control Flow
    s("if", {
        t("if "),
        i(1, "condition"),
        t({" {", "\t"}),
        i(2),
        t({"", "}"}),
    }),
    
    s("else", {
        t({" else {", "\t"}),
        i(1),
        t({"", "}"}),
    }),
    
    s("elif", {
        t(" else if "),
        i(1, "condition"),
        t({" {", "\t"}),
        i(2),
        t({"", "}"}),
    }),
    
    s("for", {
        t("for "),
        c(1, {
            fmt("{} := 0; {} < {}; {}++", {
                i(1, "i"),
                rep(1),
                i(2, "10"),
                rep(1)
            }),
            fmt("{} := range {}", {
                i(1, "i"),
                i(2, "slice")
            }),
            fmt("{}, {} := range {}", {
                i(1, "i"),
                i(2, "v"),
                i(3, "slice")
            }),
            fmt("{}", {
                i(1, "condition"),
            }),
        }),
        t({" {", "\t"}),
        i(0),
        t({"", "}"}),
    }),
    
    s("forr", {
        t("for "),
        i(1, "i"),
        t(", "),
        i(2, "v"),
        t(" := range "),
        i(3, "slice"),
        t({" {", "\t"}),
        i(0),
        t({"", "}"}),
    }),
    
    s("switch", {
        t("switch "),
        i(1, "expression"),
        t({" {", "case "}),
        i(2, "value"),
        t({":","    "}),
        i(3),
        t({"", "default:", "    "}),
        i(4),
        t({"", "}"}),
    }),
    
    s("select", {
        t({"select {", "case "}),
        i(1, "v := <-ch"),
        t({":","    "}),
        i(2),
        t({"", "default:", "    "}),
        i(3),
        t({"", "}"}),
    }),
    
    -- Goroutines and Channels
    s("go", {
        t("go func("),
        i(1),
        t({") {", "\t"}),
        i(2),
        t({"", "}("}),
        i(3),
        t(")"),
    }),
    
    s("gof", {
        t("go "),
        i(1, "funcName"),
        t("("),
        i(2),
        t(")"),
    }),
    
    s("ch", {
        t("make(chan "),
        i(1, "int"),
        c(2, {
            t(""),
            fmt(", {})", i(1, "0")),
        }),
        t(")"),
    }),
    
    -- Defer and Panic/Recover
    s("df", {
        t("defer "),
        i(1, "func()"),
    }),
    
    s("defr", {
        t({"defer func() {", "\t"}),
        i(1),
        t({"", "}()"}),
    }),
    
    s("recover", {
        t({"defer func() {", "\tif r := recover(); r != nil {", "\t\t"}),
        i(1, "log.Printf(\"Recovered: %v\", r)"),
        t({"", "\t}", "}()"}),
    }),
    
    -- Testing
    s("test", {
        t("func Test"),
        i(1, "Name"),
        t({"(t *testing.T) {", "\t"}),
        i(0),
        t({"", "}"}),
    }),
    
    s("bench", {
        t("func Benchmark"),
        i(1, "Name"),
        t({"(b *testing.B) {", "\tfor i := 0; i < b.N; i++ {", "\t\t"}),
        i(0),
        t({"", "\t}", "}"}),
    }),
    
    s("trun", {
        t("t.Run(\""),
        i(1, "name"),
        t({"\", func(t *testing.T) {", "\t"}),
        i(0),
        t({"", "})"}),
    }),
    
    s("tfatal", {
        t("t.Fatal("),
        i(1, "err"),
        t(")"),
    }),
    
    s("terr", {
        t("t.Errorf(\""),
        i(1, "got %v, want %v"),
        t("\", "),
        i(2, "got, want"),
        t(")"),
    }),
    
    -- Common patterns
    s("init", {
        t({"func init() {", "\t"}),
        i(0),
        t({"", "}"}),
    }),
    
    s("make", {
        t("make("),
        c(1, {
            fmt("[]{})", i(1, "int")),
            fmt("map[{}]{})", {i(1, "string"), i(2, "int")}),
            fmt("chan {})", i(1, "int")),
        }),
    }),
    
    s("append", {
        i(1, "slice"),
        t(" = append("),
        rep(1),
        t(", "),
        i(2, "element"),
        t(")"),
    }),
    
    -- Print statements
    s("fp", {
        t("fmt.Println("),
        i(1),
        t(")"),
    }),
    
    s("ff", {
        t("fmt.Printf(\""),
        i(1, "%v\\n"),
        t("\", "),
        i(2),
        t(")"),
    }),
    
    s("log", {
        t("log.Println("),
        i(1),
        t(")"),
    }),
    
    s("logf", {
        t("log.Printf(\""),
        i(1, "%v\\n"),
        t("\", "),
        i(2),
        t(")"),
    }),
    
    -- JSON tags
    s("json", {
        t("`json:\""),
        i(1, "fieldName"),
        c(2, {
            t("\""),
            t(",omitempty\""),
        }),
        t("`"),
    }),
    
    -- Context
    s("ctx", {
        t("ctx "),
        c(1, {
            t("context.Context"),
            t("= context.Background()"),
            t("= context.TODO()"),
            fmt("= context.WithValue({}, {}, {})", {i(1, "ctx"), i(2, "key"), i(3, "val")}),
        }),
    }),
    
    s("timeout", {
        t("ctx, cancel := context.WithTimeout("),
        i(1, "context.Background()"),
        t(", "),
        i(2, "5*time.Second"),
        t({")","defer cancel()"}),
    }),
    
    -- HTTP patterns
    s("hf", {
        t("func "),
        i(1, "handler"),
        t({"(w http.ResponseWriter, r *http.Request) {", "\t"}),
        i(0),
        t({"", "}"}),
    }),
    
    s("wr", {
        t("w.Write([]byte("),
        i(1, "\"response\""),
        t("))"),
    }),
    
    s("wjson", {
        t({"w.Header().Set(\"Content-Type\", \"application/json\")", "json.NewEncoder(w).Encode("}),
        i(1, "data"),
        t(")"),
    }),
    
    -- Mutex
    s("lock", {
        t({"mu.Lock()", "defer mu.Unlock()"}),
    }),
    
    s("rlock", {
        t({"mu.RLock()", "defer mu.RUnlock()"}),
    }),
    
    -- Type assertion
    s("ta", {
        i(1, "v"),
        t(", ok := "),
        i(2, "i"),
        t(".("),
        i(3, "Type"),
        t(")"),
    }),
    
    -- Build tags
    s("build", {
        t("//go:build "),
        i(1, "linux"),
    }),
    
    -- TODO comment
    s("todo", {
        t("// TODO: "),
        i(1, "implement this"),
    }),
}

return go_snippets
