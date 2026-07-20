# Brief: <name>

- **Lane**: product-ad | faceless | avatar | longform (scene pipeline, see
  `playbooks/longform.md`)
- **Tier**: <for longform/scene work: premium | fast | standard | budget per
  scene, or one default — measured credit ladder in `playbooks/production.md`>
- **Scenes**: <longform only: numbered scene table — beat text, visual,
  duration (5–15s), tier — or "session drafts it for approval">
- **Product / topic**: <name, and URL if it exists — Higgsfield can import products from a URL>
- **Audience**: <who is this for — be specific: "new moms 25-35", not "everyone">
- **Pain point**: <the problem the viewer has>
- **Key benefit**: <the ONE thing to communicate — one per clip, make more clips for more benefits>
- **Offer / CTA**: <discount code, "link in bio", follow, etc.>
- **Tone**: <casual friend / excited discovery / calm expert / storytime>
- **Cast**: <who is on camera — REQUIRED for any presenter video. Either a
  preset avatar name/ID from `assets/higgsfield-ids.md`, or a description
  ("woman 40s, warm, southern-European look") to cast against with a free
  contact sheet, or "none" for faceless. There are NO standing defaults —
  every brief casts fresh, and if this field is empty the session MUST show
  options and ask before generating.>
- **Voice**: <REQUIRED for spoken video. Either a preset voice name/ID from
  `list_voices` (applied as a revoice pass after the take — Marketing Studio
  cannot take a voice at generation), or a description ("neutral American,
  warm, mid-30s") steered via the prompt's audio direction and VERIFIED at
  QC. Empty = the model invents a voice (accent lottery) — session must ask.>
- **Duration**: <8-15s for ads, 15-45s for faceless/avatar>
- **Aspect**: 9:16 (default) | 1:1 | 16:9
- **Variants**: <how many hook variations to produce, default 3>
- **Assets**: <paths in assets/ — product photos, logo, reference clips>
- **Previz**: <approve | skip — default approve: 1-credit key-frame stills of
  cast + wardrobe + setting + product before any video credits. Say "skip"
  only when reusing an already-approved look.>
- **Notes**: <anything else — banned claims, competitors not to mention, language>
