# UGC Clip Factory — agent guide

This repo turns briefs into short vertical UGC clips using the Higgsfield
skills in `.claude/skills/` plus local ffmpeg post-production.

## Pipeline

1. Read the brief in `briefs/` (format: `briefs/TEMPLATE.md`). If key fields
   are missing (product, audience, CTA), ask once — don't guess offers.
2. Open `playbooks/production.md` — the gated pipeline every video follows
   (script → cast → previz → take → QC). Then the lane playbook:
   - product ads → `playbooks/product-ads.md`
   - faceless/narrated → `playbooks/faceless.md`
   - user's avatar → `playbooks/avatar.md`
3. Write scripts/hooks first and show them to the user before spending
   credits on video generation, unless the user said "just go".
4. **Casting is per-brief and is a user decision — there are NO default
   presenters, and the backend must never auto-pick one.** If the brief's
   Cast field doesn't pin an avatar ID, show a contact sheet of previews
   (free) and wait for an explicit pick BEFORE any video generation.
   "Male"/"female" alone is NOT a cast. This applies even when the user
   said "just go" — "just go" covers spend, not casting.
5. **Previz before video credits** (unless the brief says `Previz: skip`):
   1-credit key-frame stills per storyboard beat (cast + wardrobe + setting +
   product), user approves the look, then pass the approved frame as
   `start_image` to the video model. A wasted 60-credit take costs more than
   20 previz frames.
6. Generate via the Higgsfield skills (they wrap the `higgsfield` CLI).
   Always pass `--wait`. Default aspect 9:16 unless the brief says otherwise.
   (If CLI auth is impossible — remote/headless container, browser OAuth can't
   complete — the Higgsfield MCP server in the session is the same account.)
7. QC every take (ffprobe + silence/beat check + frame extraction — see
   `playbooks/production.md`), then post-process with `tools/` into
   `output/<brief-name>/`.

## Environment facts

- `higgsfield auth login` is interactive — if `higgsfield account status`
  fails, ask the user to authenticate; don't retry in a loop.
- Generation costs Higgsfield credits. Batch-confirm scope with the user
  before generating more than ~5 clips in one go.
- This container's network policy blocks `github.com` downloads; the CLI is
  installed from npm (`npm install -g @higgsfield/cli`) if missing.
- ffmpeg is installed via apt; if missing: `apt-get update && apt-get install -y ffmpeg`.
- Skills were installed with `npx skills add higgsfield-ai/skills` and are
  committed to the repo — no reinstall needed in fresh sessions.

## Conventions

- Output naming: `output/<brief>/<lane>-<variant>-<duration>s.mp4`
  (e.g. `output/glow-serum/ad-hook3-15s.mp4`).
- Keep scripts (the text) next to outputs as `.md` files so winning
  hooks can be reused and iterated.
- Soul character reference IDs and other reusable Higgsfield IDs go in
  `assets/higgsfield-ids.md` so future sessions can reuse them.
