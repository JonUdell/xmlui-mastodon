We are working on ~/xmlui-hub. Relevant resources you can access:

{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-filesystem",
        "/Users/jonudell/remote-xmlui-hn",
        "/Users/jonudell/remote-xmlui-cms",
        "/Users/jonudell/xmlui-github",
        "/Users/jonudell/xmlui",
        "/Users/jonudell/sqlite-server",
        "/Users/jonudell/xmlui-mastodon"
        "/Users/jonudell/steampipe-mod-mastodon-insights"
      ]
    },
    "steampipe": {
      "command": "npx",
      "args": [
        "-y",
        "@turbot/steampipe-mcp"
      ]
    }
  }
}

Rules:

1 use the filesystem to read and write repos.

2 xmlui-mastodon is our project. remote-xmlui-cms, remote-xmlui-hn, and remote-xmlui-invoice, and xmlui-github are reference project, use them to find xmlui patterns. xmlui is the xmlui project, use it to scan documentation and understand component implementations. component docs are in ~/xmlui/docs/pages/components, implementations in ~/xmlui/xmlui/components. packages like charts and spreadsheets are in ~/xmlui/packages.

3 use steampipe to explore tables and columns available via the mastodon plugin.

4 don't write any code without my permission

5 don't add any xmlui styling, let the theme and layout engine do its job

6 proceed in small increments, write the absolute minimum amount of xmlui markup necessary and no script if possible

7 do not invent any xmlui syntax. only use constructs for which you can find examples in the docs and sample apps

8 never touch the dom. we only within xmlui abstractions inside the <App> realm, with help from vars and functions defined on the window variable in index.html

9 keep complex functions and expressions out of xmlui, then can live in index.html

This project:

steampipe-mod-mastodon-insights is a steampipe mod that uses the mastodon plugin to visualize social media activity. We will port it to XMLUI and improve it.

xmlui-mastodon is the seed of our port. initially it has a table of recent toots in Home.xmlui.

Ready to go?

