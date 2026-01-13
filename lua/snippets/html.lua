local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local html_css_snippets = {
    -- HTML Document Structure
    s("!", {
        t({"<!DOCTYPE html>",
           "<html lang=\""}),
        i(1, "en"),
        t({"\">",
           "<head>",
           "  <meta charset=\"UTF-8\">",
           "  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">",
           "  <title>"}),
        i(2, "Document"),
        t({"</title>",
           "</head>",
           "<body>",
           "  "}),
        i(0),
        t({"",
           "</body>",
           "</html>"}),
    }),
    
    s("html5", {
        t({"<!DOCTYPE html>",
           "<html lang=\""}),
        i(1, "en"),
        t({"\">",
           "<head>",
           "  <meta charset=\"UTF-8\">",
           "  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">",
           "  <meta name=\"description\" content=\""}),
        i(2, "Description"),
        t({"\">",
           "  <title>"}),
        i(3, "Title"),
        t({"</title>",
           "  <link rel=\"stylesheet\" href=\""}),
        i(4, "styles.css"),
        t({"\">",
           "</head>",
           "<body>",
           "  "}),
        i(0),
        t({"",
           "  <script src=\""}),
        i(5, "script.js"),
        t({"\"></script>",
           "</body>",
           "</html>"}),
    }),
    
    -- Head Elements
    s("meta", {
        t("<meta "),
        c(1, {
            fmt('charset="{}"', i(1, "UTF-8")),
            fmt('name="{}" content="{}"', {i(1, "description"), i(2, "content")}),
            fmt('property="{}" content="{}"', {i(1, "og:title"), i(2, "content")}),
            fmt('http-equiv="{}" content="{}"', {i(1, "X-UA-Compatible"), i(2, "IE=edge")}),
        }),
        t(">"),
    }),
    
    s("link", {
        t("<link rel=\""),
        c(1, {
            t("stylesheet"),
            t("icon"),
            t("preconnect"),
            t("manifest"),
        }),
        t("\" "),
        c(2, {
            fmt('href="{}"', i(1, "styles.css")),
            fmt('href="{}" type="{}"', {i(1, "favicon.ico"), i(2, "image/x-icon")}),
        }),
        t(">"),
    }),
    
    -- Common HTML Elements
    s("div", {
        t("<div"),
        c(1, {
            t(""),
            fmt(' class="{}"', i(1, "class")),
            fmt(' id="{}"', i(1, "id")),
            fmt(' class="{}" id="{}"', {i(1, "class"), i(2, "id")}),
        }),
        t({">", "  "}),
        i(2),
        t({"", "</div>"}),
    }),
    
    s("sec", {
        t("<section"),
        c(1, {
            t(""),
            fmt(' class="{}"', i(1, "class")),
            fmt(' id="{}"', i(1, "id")),
        }),
        t({">", "  "}),
        i(2),
        t({"", "</section>"}),
    }),
    
    s("art", {
        t("<article"),
        c(1, {
            t(""),
            fmt(' class="{}"', i(1, "class")),
        }),
        t({">", "  "}),
        i(2),
        t({"", "</article>"}),
    }),
    
    s("nav", {
        t("<nav"),
        c(1, {
            t(""),
            fmt(' class="{}"', i(1, "navbar")),
        }),
        t({">", "  <ul>", "    <li><a href=\"#\">"}),
        i(2, "Home"),
        t({"</a></li>", "    <li><a href=\"#\">"}),
        i(3, "About"),
        t({"</a></li>", "    <li><a href=\"#\">"}),
        i(4, "Contact"),
        t({"</a></li>", "  </ul>", "</nav>"}),
    }),
    
    -- Text Elements
    s("h", {
        t("<h"),
        c(1, {t("1"), t("2"), t("3"), t("4"), t("5"), t("6")}),
        c(2, {
            t(""),
            fmt(' class="{}"', i(1, "class")),
            fmt(' id="{}"', i(1, "id")),
        }),
        t(">"),
        i(3),
        t("</h"),
        rep(1),
        t(">"),
    }),
    
    s("p", {
        t("<p"),
        c(1, {
            t(""),
            fmt(' class="{}"', i(1, "class")),
        }),
        t(">"),
        i(2),
        t("</p>"),
    }),
    
    s("span", {
        t("<span"),
        c(1, {
            t(""),
            fmt(' class="{}"', i(1, "class")),
        }),
        t(">"),
        i(2),
        t("</span>"),
    }),
    
    -- Lists
    s("ul", {
        t("<ul"),
        c(1, {
            t(""),
            fmt(' class="{}"', i(1, "class")),
        }),
        t({">", "  <li>"}),
        i(2, "Item 1"),
        t({"</li>", "  <li>"}),
        i(3, "Item 2"),
        t({"</li>", "  <li>"}),
        i(4, "Item 3"),
        t({"</li>", "</ul>"}),
    }),
    
    s("ol", {
        t("<ol"),
        c(1, {
            t(""),
            fmt(' class="{}"', i(1, "class")),
            fmt(' type="{}"', c(1, {t("1"), t("A"), t("a"), t("I"), t("i")})),
        }),
        t({">", "  <li>"}),
        i(2, "Item 1"),
        t({"</li>", "  <li>"}),
        i(3, "Item 2"),
        t({"</li>", "  <li>"}),
        i(4, "Item 3"),
        t({"</li>", "</ol>"}),
    }),
    
    s("li", {
        t("<li"),
        c(1, {
            t(""),
            fmt(' class="{}"', i(1, "class")),
        }),
        t(">"),
        i(2),
        t("</li>"),
    }),
    
    -- Links and Media
    s("a", {
        t("<a href=\""),
        i(1, "#"),
        t("\""),
        c(2, {
            t(""),
            t(' target="_blank"'),
            fmt(' class="{}"', i(1, "class")),
            t(' target="_blank" rel="noopener noreferrer"'),
        }),
        t(">"),
        i(3, "Link text"),
        t("</a>"),
    }),
    
    s("img", {
        t("<img src=\""),
        i(1, "image.jpg"),
        t("\" alt=\""),
        i(2, "description"),
        t("\""),
        c(3, {
            t(""),
            fmt(' class="{}"', i(1, "class")),
            fmt(' width="{}" height="{}"', {i(1, "300"), i(2, "200")}),
            t(' loading="lazy"'),
        }),
        t(">"),
    }),
    
    s("picture", {
        t({"<picture>", "  <source srcset=\""}),
        i(1, "image.webp"),
        t("\" type=\"image/webp\">"),
        t({"", "  <source srcset=\""}),
        i(2, "image.jpg"),
        t("\" type=\"image/jpeg\">"),
        t({"", "  <img src=\""}),
        rep(2),
        t("\" alt=\""),
        i(3, "description"),
        t({"\">", "</picture>"}),
    }),
    
    s("video", {
        t("<video"),
        c(1, {
            t(" controls"),
            t(" controls autoplay"),
            t(" controls loop muted"),
        }),
        t({">", "  <source src=\""}),
        i(2, "video.mp4"),
        t("\" type=\"video/mp4\">"),
        t({"", "  <source src=\""}),
        i(3, "video.webm"),
        t("\" type=\"video/webm\">"),
        t({"", "  Your browser does not support the video tag.", "</video>"}),
    }),
    
    -- Forms
    s("form", {
        t("<form"),
        c(1, {
            fmt(' action="{}" method="{}"', {i(1, "/submit"), c(2, {t("POST"), t("GET")})}),
            fmt(' id="{}" class="{}"', {i(1, "form"), i(2, "form-class")}),
        }),
        t({">", "  "}),
        i(2),
        t({"", "</form>"}),
    }),
    
    s("input", {
        t("<input type=\""),
        c(1, {
            t("text"),
            t("email"),
            t("password"),
            t("number"),
            t("tel"),
            t("date"),
            t("checkbox"),
            t("radio"),
            t("submit"),
            t("button"),
        }),
        t("\""),
        c(2, {
            fmt(' name="{}" id="{}"', {i(1, "name"), rep(1)}),
            fmt(' name="{}" placeholder="{}"', {i(1, "name"), i(2, "Enter...")}),
            fmt(' name="{}" value="{}"', {i(1, "name"), i(2, "value")}),
        }),
        c(3, {
            t(""),
            t(" required"),
            fmt(' class="{}"', i(1, "class")),
        }),
        t(">"),
    }),
    
    s("label", {
        t("<label for=\""),
        i(1, "input-id"),
        t("\">"),
        i(2, "Label text"),
        t("</label>"),
    }),
    
    s("textarea", {
        t("<textarea name=\""),
        i(1, "message"),
        t("\" id=\""),
        rep(1),
        t("\""),
        c(2, {
            t(""),
            fmt(' rows="{}" cols="{}"', {i(1, "4"), i(2, "50")}),
            fmt(' placeholder="{}"', i(1, "Enter text...")),
        }),
        t(">"),
        i(3),
        t("</textarea>"),
    }),
    
    s("select", {
        t("<select name=\""),
        i(1, "options"),
        t("\" id=\""),
        rep(1),
        t({"\">", "  <option value=\""}),
        i(2, "value1"),
        t("\">"),
        i(3, "Option 1"),
        t({"</option>", "  <option value=\""}),
        i(4, "value2"),
        t("\">"),
        i(5, "Option 2"),
        t({"</option>", "</select>"}),
    }),
    
    s("button", {
        t("<button type=\""),
        c(1, {t("button"), t("submit"), t("reset")}),
        t("\""),
        c(2, {
            t(""),
            fmt(' class="{}"', i(1, "btn")),
            fmt(' onclick="{}"', i(1, "handleClick()")),
        }),
        t(">"),
        i(3, "Click me"),
        t("</button>"),
    }),
    
    -- Tables
    s("table", {
        t({"<table>", "  <thead>", "    <tr>", "      <th>"}),
        i(1, "Header 1"),
        t({"</th>", "      <th>"}),
        i(2, "Header 2"),
        t({"</th>", "    </tr>", "  </thead>", "  <tbody>", "    <tr>", "      <td>"}),
        i(3, "Data 1"),
        t({"</td>", "      <td>"}),
        i(4, "Data 2"),
        t({"</td>", "    </tr>", "  </tbody>", "</table>"}),
    }),
    
    -- Semantic HTML5
    s("header", {
        t("<header"),
        c(1, {
            t(""),
            fmt(' class="{}"', i(1, "header")),
        }),
        t({">", "  "}),
        i(2),
        t({"", "</header>"}),
    }),
    
    s("footer", {
        t("<footer"),
        c(1, {
            t(""),
            fmt(' class="{}"', i(1, "footer")),
        }),
        t({">", "  "}),
        i(2),
        t({"", "</footer>"}),
    }),
    
    s("main", {
        t("<main"),
        c(1, {
            t(""),
            fmt(' class="{}"', i(1, "main")),
        }),
        t({">", "  "}),
        i(2),
        t({"", "</main>"}),
    }),
    
    s("aside", {
        t("<aside"),
        c(1, {
            t(""),
            fmt(' class="{}"', i(1, "sidebar")),
        }),
        t({">", "  "}),
        i(2),
        t({"", "</aside>"}),
    }),
    
    s("figure", {
        t({"<figure>", "  <img src=\""}),
        i(1, "image.jpg"),
        t("\" alt=\""),
        i(2, "description"),
        t({"\">", "  <figcaption>"}),
        i(3, "Caption"),
        t({"</figcaption>", "</figure>"}),
    }),
    
    -- CSS Snippets
    s("css", {
        t({"<style>", "  "}),
        i(1),
        t({"", "</style>"}),
    }),
    
    s("class", {
        t("."),
        i(1, "class-name"),
        t({" {", "  "}),
        i(2),
        t({"", "}"}),
    }),
    
    s("id", {
        t("#"),
        i(1, "id-name"),
        t({" {", "  "}),
        i(2),
        t({"", "}"}),
    }),
    
    s("flex", {
        t({"display: flex;", ""}),
        c(1, {
            t(""),
            t("flex-direction: column;"),
            t("flex-direction: row;"),
        }),
        t({"", "justify-content: "}),
        c(2, {
            t("center"),
            t("space-between"),
            t("space-around"),
            t("flex-start"),
            t("flex-end"),
        }),
        t({";", "align-items: "}),
        c(3, {
            t("center"),
            t("flex-start"),
            t("flex-end"),
            t("stretch"),
        }),
        t(";"),
    }),
    
    s("grid", {
        t({"display: grid;", "grid-template-columns: "}),
        c(1, {
            t("repeat(auto-fit, minmax(250px, 1fr))"),
            t("1fr 1fr 1fr"),
            fmt("repeat({}, 1fr)", i(1, "3")),
        }),
        t({";", "gap: "}),
        i(2, "1rem"),
        t(";"),
    }),
    
    s("media", {
        t("@media "),
        c(1, {
            t("(max-width: 768px)"),
            t("(min-width: 768px)"),
            fmt("(max-width: {}px)", i(1, "1024")),
            t("(prefers-color-scheme: dark)"),
        }),
        t({" {", "  "}),
        i(2),
        t({"", "}"}),
    }),
    
    s("animation", {
        t("animation: "),
        i(1, "name"),
        t(" "),
        i(2, "1s"),
        t(" "),
        c(3, {
            t("ease"),
            t("ease-in"),
            t("ease-out"),
            t("ease-in-out"),
            t("linear"),
        }),
        t(" "),
        c(4, {
            t(""),
            t("infinite"),
            t("alternate"),
            t("both"),
        }),
        t(";"),
    }),
    
    s("keyframes", {
        t("@keyframes "),
        i(1, "animation-name"),
        t({" {", "  0% {", "    "}),
        i(2, "opacity: 0"),
        t({";", "  }", "  100% {", "    "}),
        i(3, "opacity: 1"),
        t({";", "  }", "}"}),
    }),
    
    s("var", {
        t("var(--"),
        i(1, "variable-name"),
        c(2, {
            t(""),
            fmt(", {})", i(1, "fallback")),
        }),
        t(")"),
    }),
    
    -- Modern CSS
    s("container", {
        t("."),
        i(1, "container"),
        t({" {", "  width: 100%;", "  max-width: "}),
        c(2, {
            t("1200px"),
            t("1400px"),
            t("980px"),
        }),
        t({";", "  margin: 0 auto;", "  padding: 0 "}),
        i(3, "1rem"),
        t({";", "}"}),
    }),
    
    s("btn", {
        t("."),
        i(1, "btn"),
        t({" {", "  display: inline-block;", "  padding: "}),
        i(2, "0.5rem 1rem"),
        t({";", "  background-color: "}),
        i(3, "#007bff"),
        t({";", "  color: white;", "  text-decoration: none;", "  border: none;", "  border-radius: "}),
        i(4, "4px"),
        t({";", "  cursor: pointer;", "  transition: background-color 0.3s ease;", "}", "", "."}),
        rep(1),
        t({":hover {", "  background-color: "}),
        i(5, "#0056b3"),
        t({";", "}"}),
    }),
    
    s("card", {
        t("."),
        i(1, "card"),
        t({" {", "  background: white;", "  border-radius: "}),
        i(2, "8px"),
        t({";", "  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);", "  padding: "}),
        i(3, "1.5rem"),
        t({";", "  margin-bottom: "}),
        i(4, "1rem"),
        t({";", "}"}),
    }),
    
    -- Comments
    s("com", {
        t("<!-- "),
        i(1, "Comment"),
        t(" -->"),
    }),
    
    s("ccom", {
        t("/* "),
        i(1, "CSS Comment"),
        t(" */"),
    }),
}

return html_css_snippets
