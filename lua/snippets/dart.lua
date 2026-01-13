local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local dart_snippets = {
  -- Basic Dart constructs
  s("main", fmt([[
void main() {{
  {}
}}
]], {i(1)})),

  s("class", fmt([[
class {} {{
  {}
}}
]], {i(1, "ClassName"), i(2)})),

  s("enum", fmt([[
enum {} {{
  {}
}}
]], {i(1, "EnumName"), i(2, "value1, value2")})),

  s("if", fmt([[
if ({}) {{
  {}
}}
]], {i(1, "condition"), i(2)})),

  s("ife", fmt([[
if ({}) {{
  {}
}} else {{
  {}
}}
]], {i(1, "condition"), i(2), i(3)})),

  s("for", fmt([[
for (int {} = 0; {} < {}; {}++) {{
  {}
}}
]], {i(1, "i"), rep(1), i(2, "length"), rep(1), i(3)})),

  s("fore", fmt([[
for (final {} in {}) {{
  {}
}}
]], {i(1, "item"), i(2, "list"), i(3)})),

  s("while", fmt([[
while ({}) {{
  {}
}}
]], {i(1, "condition"), i(2)})),

  s("switch", fmt([[
switch ({}) {{
  case {}:
    {}
    break;
  default:
    {}
}}
]], {i(1, "expression"), i(2, "value"), i(3), i(4)})), -- Dart switch statement

  s("try", fmt([[
try {{
  {}
}} catch (e) {{
  {}
}}
]], {i(1), i(2)})),

  s("tryf", fmt([[
try {{
  {}
}} catch (e) {{
  {}
}} finally {{
  {}
}}
]], {i(1), i(2), i(3)})),

  s("fn", fmt([[
{} {}({}) {{
  {}
}}
]], {i(1, "void"), i(2, "functionName"), i(3), i(4)})),

  s("afn", fmt([[
Future<{}> {}({}) async {{
  {}
}}
]], {i(1, "void"), i(2, "functionName"), i(3), i(4)})),

  s("get", fmt([[
{} get {} => {};
]], {i(1, "Type"), i(2, "propertyName"), i(3, "value")})),

  s("set", fmt(
    [[
set {}({} value) {{
  {} = value;
}}
]], {
      i(1, "propertyName"),
      i(2, "Type"),
      -- Creates _propertyName based on propertyName
      f(function(args) return "_" .. args[1][1] end, {1})
    }
  )),

  -- Flutter specific
  s("stl", fmt([[
class {} extends StatelessWidget {{
  const {}({{super.key}});

  @override
  Widget build(BuildContext context) {{
    return {};
  }}
}}
]], {i(1, "MyWidget"), rep(1), i(2, "Container()")})),

  s("stf", fmt([[
class {} extends StatefulWidget {{
  const {}({{super.key}});

  @override
  State<{}> createState() => _{}State();
}}

class _{}State extends State<{}> {{
  @override
  Widget build(BuildContext context) {{
    return {};
  }}
}}
]], {i(1, "MyWidget"), rep(1), rep(1), rep(1), rep(1), rep(1), i(2, "Container()")})),

  s("initS", fmt([[
@override
void initState() {{
  super.initState();
  {}
}}
]], {i(1)})),

  s("dispose", fmt([[
@override
void dispose() {{
  {}
  super.dispose();
}}
]], {i(1)})),

  s("didC", fmt([[
@override
void didChangeDependencies() {{
  super.didChangeDependencies();
  {}
}}
]], {i(1)})),

  s("didU", fmt([[
@override
void didUpdateWidget(covariant {} oldWidget) {{
  super.didUpdateWidget(oldWidget);
  {}
}}
]], {i(1, "MyWidget"), i(2)})),

  -- Material App
  s("mapp", fmt([[
MaterialApp(
  title: '{}',
  theme: ThemeData(
    primarySwatch: Colors.{},
  ),
  home: const {}(),
)
]], {i(1, "App Title"), i(2, "blue"), i(3, "HomePage")})),

  -- Scaffold
  s("scaf", fmt([[
Scaffold(
  appBar: AppBar(
    title: const Text('{}'),
  ),
  body: {},
)
]], {i(1, "Title"), i(2, "Container()")})),

  -- Container
  s("cont", fmt([[
Container(
  {}
  child: {},
)
]], {i(1, "/* properties */"), i(2, "/* child widget */")})),

  s("contd", fmt([[
Container(
  padding: const EdgeInsets.all({}),
  margin: const EdgeInsets.all({}),
  decoration: BoxDecoration(
    color: Colors.{},
    borderRadius: BorderRadius.circular({}),
  ),
  child: {},
)
]], {i(1, "8.0"), i(2, "8.0"), i(3, "blue"), i(4, "8.0"), i(5)})),

  -- Column
  s("col", fmt([[
Column(
  {}
  children: [
    {},
  ],
)
]], {i(1, "/* properties */"), i(2, "/* children widgets */")})),

  s("colm", fmt([[
Column(
  mainAxisAlignment: MainAxisAlignment.{},
  crossAxisAlignment: CrossAxisAlignment.{},
  children: [
    {},
  ],
)
]], {i(1, "center"), i(2, "center"), i(3)})),

  -- Row
  s("row", fmt([[
Row(
  {}
  children: [
    {},
  ],
)
]], {i(1, "/* properties */"), i(2, "/* children widgets */")})),

  s("rowm", fmt([[
Row(
  mainAxisAlignment: MainAxisAlignment.{},
  crossAxisAlignment: CrossAxisAlignment.{},
  children: [
    {},
  ],
)
]], {i(1, "center"), i(2, "center"), i(3)})),

  -- Stack
  s("stack", fmt([[
Stack(
  children: [
    {},
  ],
)
]], {i(1)})),

  -- Expanded
  s("exp", fmt([[
Expanded(
  child: {},
)
]], {i(1)})),

  s("expf", fmt([[
Expanded(
  flex: {},
  child: {},
)
]], {i(1, "1"), i(2)})),

  -- SizedBox
  s("sbox", fmt([[
SizedBox(
  width: {},
  height: {},
  child: {},
)
]], {i(1), i(2), i(3)})), -- Renamed from sb

  s("sbh", fmt([[
const SizedBox(height: {}),
]], {i(1, "8.0")})),

  s("sbw", fmt([[
const SizedBox(width: {}),
]], {i(1, "8.0")})),

  -- Padding
  s("pad", fmt([[
Padding(
  padding: const EdgeInsets.all({}),
  child: {},
)
]], {i(1, "8.0"), i(2)})),

  s("pads", fmt([[
Padding(
  padding: const EdgeInsets.symmetric(
    horizontal: {},
    vertical: {},
  ),
  child: {},
)
]], {i(1, "8.0"), i(2, "8.0"), i(3)})),

  -- Center
  s("center", fmt([[
Center(
  child: {},
)
]], {i(1)})),

  -- Text
  s("text", fmt([[
Text(
  '{}',
  style: TextStyle(
    fontSize: {},
    fontWeight: FontWeight.{},
  ),
)
]], {i(1, "text"), i(2, "16"), i(3, "normal")})),

  s("texts", fmt([[
const Text('{}'),
]], {i(1, "text")})),

  -- TextField
  s("tf", fmt([[
TextField(
  controller: {},
  decoration: const InputDecoration(
    labelText: '{}',
    hintText: '{}',
  ),
  onChanged: (value) {{
    {}
  }},
)
]], {i(1, "_controller"), i(2, "Label"), i(3, "Hint"), i(4)})),

  -- TextFormField
  s("tff", fmt([[
TextFormField(
  controller: {},
  decoration: const InputDecoration(
    labelText: '{}',
  ),
  validator: (value) {{
    if (value == null || value.isEmpty) {{
      return '{}';
    }}
    return null;
  }},
)
]], {i(1, "_controller"), i(2, "Label"), i(3, "Please enter some text")})),

  -- ElevatedButton
  s("ebtn", fmt([[
ElevatedButton(
  onPressed: () {{
    {}
  }},
  child: const Text('{}'),
)
]], {i(1), i(2, "Button")})),

  -- TextButton
  s("tbtn", fmt([[
TextButton(
  onPressed: () {{
    {}
  }},
  child: const Text('{}'),
)
]], {i(1), i(2, "Button")})),

  -- IconButton
  s("ibtn", fmt([[
IconButton(
  icon: const Icon(Icons.{}),
  onPressed: () {{
    {}
  }},
)
]], {i(1, "add"), i(2)})),

  -- ListView
  s("lv", fmt([[
ListView(
  children: [
    {},
  ],
)
]], {i(1)})),

  s("lvb", fmt([[
ListView.builder(
  itemCount: {}.length,
  itemBuilder: (context, index) {{
    return {};
  }},
)
]], {i(1, "items"), i(2, "ListTile()")})),

  s("lvs", fmt([[
ListView.separated(
  itemCount: {}.length,
  separatorBuilder: (context, index) => const Divider(),
  itemBuilder: (context, index) {{
    return {};
  }},
)
]], {i(1, "items"), i(2, "ListTile()")})), -- Added comma after Divider()

  -- ListTile
  s("lt", fmt([[
ListTile(
  title: Text('{}'),
  subtitle: Text('{}'),
  onTap: () {{
    {}
  }},
)
]], {i(1, "Title"), i(2, "Subtitle"), i(3)})),

  -- GridView
  s("gv", fmt([[
GridView.count(
  crossAxisCount: {},
  children: [
    {},
  ],
)
]], {i(1, "2"), i(2)})),

  s("gvb", fmt([[
GridView.builder(
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: {},
  ),
  itemCount: {}.length,
  itemBuilder: (context, index) {{
    return {};
  }},
)
]], {i(1, "2"), i(2, "items"), i(3, "Container()")})),

  -- Card
  s("card", fmt([[
Card(
  child: {},
)
]], {i(1)})),

  s("carde", fmt([[
Card(
  elevation: {},
  child: Padding(
    padding: const EdgeInsets.all({}),
    child: {},
  ),
)
]], {i(1, "4.0"), i(2, "8.0"), i(3)})),

  -- Dialog
  s("dialog", fmt([[
showDialog(
  context: context,
  builder: (context) => AlertDialog(
    title: const Text('{}'),
    content: const Text('{}'),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('{}'),
      ),
    ],
  ),
);
]], {i(1, "Title"), i(2, "Content"), i(3, "OK")})),

  -- SnackBar
  s("snack", fmt([[
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: const Text('{}'),
    duration: const Duration(seconds: {}),
  ),
);
]], {i(1, "Message"), i(2, "2")})),

  -- Navigator
  s("nav", fmt([[
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const {}(),
  ),
);
]], {i(1, "NextPage")})),

  s("navp", t("Navigator.pop(context);")), -- Changed to t() for simplicity

  s("navrepl", fmt([[
Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (context) => const {}(),
  ),
);
]], {i(1, "NextPage")})), -- Renamed from navr

  -- FutureBuilder
  s("fb", fmt([[
FutureBuilder<{}>(
  future: {},
  builder: (context, snapshot) {{
    if (snapshot.connectionState == ConnectionState.waiting) {{
      return const Center(child: CircularProgressIndicator());
    }}
    if (snapshot.hasError) {{
      return Center(child: Text('Error: ${{snapshot.error}}'));
    }}
    if (!snapshot.hasData || snapshot.data == null) {{ // Optional: Handle no data explicitly
      return Center(child: Text('No data'));
    }}
    // final data = snapshot.data!; // Use data safely
    return {};
  }},
)
]], {i(1, "Type"), i(2, "future"), i(3, "Container(/* Use snapshot.data */)")})),

  -- StreamBuilder
  s("stb", fmt([[
StreamBuilder<{}>(
  stream: {},
  builder: (context, snapshot) {{
    if (snapshot.connectionState == ConnectionState.waiting) {{
      return const Center(child: CircularProgressIndicator());
    }}
    if (snapshot.hasError) {{
      return Center(child: Text('Error: ${{snapshot.error}}'));
    }}
    if (!snapshot.hasData || snapshot.data == null) {{ // Optional: Handle no data explicitly
      return Center(child: Text('No data'));
    }}
    // final data = snapshot.data!; // Use data safely
    return {};
  }},
)
]], {i(1, "Type"), i(2, "stream"), i(3, "Container(/* Use snapshot.data */)")})), -- Renamed from sb

  -- Form
  s("form", fmt([[
Form(
  key: {}, // e.g. _formKey
  child: Column(
    children: [
      {},
    ],
  ),
)
]], {i(1, "_formKey"), i(2)})),

  -- Wrap
  s("wrap", fmt([[
Wrap(
  spacing: {},
  runSpacing: {},
  children: [
    {},
  ],
)
]], {i(1, "8.0"), i(2, "8.0"), i(3)})),

  -- Flexible
  s("flex", fmt([[
Flexible(
  child: {},
)
]], {i(1)})),

  -- AspectRatio
  s("ar", fmt([[
AspectRatio(
  aspectRatio: {},
  child: {},
)
]], {i(1, "16 / 9"), i(2)})),

  -- ClipRRect
  s("clip", fmt([[
ClipRRect(
  borderRadius: BorderRadius.circular({}),
  child: {},
)
]], {i(1, "8.0"), i(2)})),

  -- Divider
  s("div", t("const Divider(),")),

  -- CircularProgressIndicator
  s("cpi", t("const Center(child: CircularProgressIndicator()),")), -- Often used with Center

  -- LinearProgressIndicator
  s("lpi", t("const LinearProgressIndicator(),")),

  -- RefreshIndicator
  s("ri", fmt([[
RefreshIndicator(
  onRefresh: () async {{
    {}
  }},
  child: {},
)
]], {i(1), i(2)})),

  -- Drawer
  s("drawer", fmt([[
Drawer(
  child: ListView(
    padding: EdgeInsets.zero,
    children: [
      DrawerHeader(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        child: Text('{}', style: TextStyle(color: Colors.white)),
      ),
      ListTile(
        leading: const Icon(Icons.home),
        title: const Text('{}'),
        onTap: () {{
          {}
          Navigator.pop(context); // Close drawer
        }},
      ),
      // Add more ListTiles here
    ],
  ),
)
]], {i(1, "Header Title"), i(2, "Menu Item 1"), i(3)})),

  -- AppBar
  s("appbar", fmt([[
AppBar(
  title: const Text('{}'),
  actions: [
    IconButton(
      icon: const Icon(Icons.{}),
      onPressed: () {{
        {}
      }},
    ),
  ],
)
]], {i(1, "Title"), i(2, "settings"), i(3)})),

  -- FloatingActionButton
  s("fab", fmt([[
FloatingActionButton(
  onPressed: () {{
    {}
  }},
  child: const Icon(Icons.{}),
)
]], {i(1), i(2, "add")})),

  -- BottomNavigationBar
  s("bnb", fmt([[
BottomNavigationBar(
  currentIndex: {}, // e.g. _selectedIndex
  onTap: (index) {{
    {} // e.g. setState(() => _selectedIndex = index);
  }},
  items: const [
    BottomNavigationBarItem(
      icon: Icon(Icons.{}),
      label: '{}',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.{}),
      label: '{}',
    ),
  ],
)
]], {i(1, "_selectedIndex"), i(2), i(3, "home"), i(4, "Home"), i(5, "settings"), i(6, "Settings")})),

  -- TabBar
  s("tabbar", fmt([[
DefaultTabController(
  length: {},
  child: Scaffold(
    appBar: AppBar(
      title: const Text('{}'), // Optional: Add a title to AppBar
      bottom: const TabBar(
        tabs: [
          Tab(text: '{}'),
          Tab(text: '{}'),
        ],
      ),
    ),
    body: TabBarView(
      children: [
        {}, // Content for Tab 1
        {}, // Content for Tab 2
      ],
    ),
  ),
)
]], {i(1, "2"), i(2, "Page Title"), i(3, "Tab 1"), i(4, "Tab 2"), i(5, "Center(child: Text('Content for Tab 1'))"), i(6, "Center(child: Text('Content for Tab 2'))")})),

  -- Theme
  s("theme", fmt([[
Theme.of(context).{}
]], {i(1, "textTheme.headlineSmall")})),

  -- MediaQuery
  s("mq", fmt([[
MediaQuery.of(context).{}
]], {i(1, "size.width")})),

  -- setState
  s("sst", fmt([[
setState(() {{
  {}
}});
]], {i(1)})),

  -- GestureDetector
  s("gd", fmt([[
GestureDetector(
  onTap: () {{
    {}
  }},
  child: {},
)
]], {i(1), i(2)})),

  -- InkWell
  s("inkw", fmt([[
InkWell(
  onTap: () {{
    {}
  }},
  child: {},
)
]], {i(1), i(2)})),

  -- Hero
  s("hero", fmt([[
Hero(
  tag: '{}',
  child: {},
)
]], {i(1, "hero-tag"), i(2)})),

  -- AnimatedContainer
  s("acont", fmt([[
AnimatedContainer(
  duration: const Duration(milliseconds: {}),
  {} // properties to animate
  child: {},
)
]], {i(1, "300"), i(2), i(3)})),

  -- Provider
  s("prov", fmt([[
Provider.of<{}>(context)
]], {i(1, "MyNotifier")})),

  s("provl", fmt([[
Provider.of<{}>(context, listen: false)
]], {i(1, "MyNotifier")})),

  -- Consumer
  s("cons", fmt([[
Consumer<{}>(
  builder: (context, {}, child) {{ // e.g. MyNotifier, myNotifierValue
    return {};
  }},
)
]], {i(1, "MyNotifier"), i(2, "value"), i(3)})),

  -- API call
  s("api", fmt([[
Future<{}> {}() async {{
  // Ensure http package is imported: import 'package:http/http.dart' as http;
  // Ensure dart:convert is imported: import 'dart:convert';
  final response = await http.get(Uri.parse('{}'));

  if (response.statusCode == 200) {{
    return {}.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }} else {{
    throw Exception('Failed to load {}');
  }}
}}
]], {i(1, "MyModel"), i(2, "fetchData"), i(3, "your_api_url_here"), rep(1), i(4, "data")})),

}

return dart_snippets
