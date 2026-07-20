# Playbook: your avatar (Soul character)

Goal: clips featuring YOUR consistent likeness without filming yourself —
talking-head takes, lifestyle shots, presenter-style product content.

## One-time setup: train your Soul

Done once via the `higgsfield-soul-id` skill; produces a `reference_id`
reused forever after. **Requires a paid Higgsfield plan (Basic+).**

Photo set to drop in `assets/soul/` (10–20 photos):
- Mix of angles: front, 3/4 left, 3/4 right, a couple full-body
- Mix of lighting: daylight, indoor, at least one flash/hard light
- Neutral AND expressive faces; hair as you usually wear it
- No sunglasses, no heavy filters, no other people in frame, sharp focus
- Recent photos only — the model learns exactly what it sees

After training, record the reference_id in `assets/higgsfield-ids.md`.

## What to generate with it

| Output | How |
|--------|-----|
| Identity-faithful stills (thumbnails, lifestyle "photos") | `higgsfield-generate` with `--soul-id <id>`, model `text2image_soul_v2` |
| Cinematic video of you | `soul_cinema_studio` via `higgsfield-generate` |
| Talking-head / presenter clips (you speaking a script) | `higgsfield-generate` Marketing Studio presenter/avatar format, chained with your Soul |
| You + product ads | Combine with `playbooks/product-ads.md` — you become the "creator" in the ad |

## Script structure for talking-head clips (15–40s)

1. **Hook (0–3s)**: a claim, question, or contrarian take — first-person.
   "I posted every day for 90 days. Here's what nobody tells you."
2. **Body (3–25s)**: one story or one lesson. Spoken language — read it
   aloud; if a sentence doesn't survive being said, rewrite it.
3. **CTA (last 3–5s)**: follow / comment-bait / link in bio. One only.

## Consistency & authenticity rules

- Same Soul + same wardrobe/setting prompts across a series = a recognizable
  "channel look". Keep the winning prompt recipe in `assets/` next to the ID.
- Phone-camera prompt patterns from `playbooks/product-ads.md` apply here too.
- **Disclosure**: platforms (TikTok, YouTube, Meta) require AI-generated
  content to be labeled — use the platform's AI toggle when publishing. Your
  likeness, your call, but label it.

## Post-production

- Captions always (`tools/burn_captions.sh`).
- For multi-scene clips: generate scenes separately, stitch with
  `tools/stitch.sh` — cuts every 3–5s hold attention better than one take.
