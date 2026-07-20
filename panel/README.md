# UGC Studio panel (Claude-connected control panel)

`studio.html` is a single-file control panel designed to be published as a
**Claude artifact** with the MCP runtime capability, so it can call your
claude.ai Higgsfield connector live (credit balance, avatar roster, voice
list) while staying a private page.

## Publish it

Ask Claude Code (with this repo open and your Higgsfield connector active):

> Publish panel/studio.html as a private artifact with
> capabilities `{"mcp": {"servers": [{"server": "higgsfield",
> "tools": ["show_marketing_studio", "balance", "list_voices"]}]},
> "downloads": true}`.

Notes:
- The page's CSP blocks external images, so the avatar thumbnails are
  embedded as data URIs — regenerate them from your own account's roster
  (ask Claude to rebuild the contact sheet) or use it as shipped.
- Voice preview links open in a new tab; audio can't be embedded.
- Accent tags (US?/UK?) are stored in your browser's localStorage.
