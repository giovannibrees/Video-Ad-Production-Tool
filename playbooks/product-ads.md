# Playbook: UGC product ads

Goal: ads that look like a real customer filmed them on a phone — not a
polished commercial. Authenticity outperforms production value.

## Script structure (15–30s)

| Beat | Time | Job |
|------|------|-----|
| Hook | 0–2s | Stop the scroll. Visual + spoken line together. |
| Problem | 2–6s | Name the viewer's pain in their words. |
| Product | 6–15s | Show it being used. Demo > description. |
| Proof | 15–22s | Result, before/after, or one concrete number. |
| CTA | last 3s | One action. Say it and show it on screen. |

## Hook formulas (rotate across variants)

1. "I was today years old when I found out…"
2. "Stop doing X — this is why your Y isn't working."
3. "3 reasons I returned everything else and kept this."
4. "POV: you finally found a <category> that actually works."
5. "Nobody talks about this, but…"
6. "I didn't believe the reviews. I owe everyone an apology."
7. Negative open: "Don't buy <product> until you watch this."
8. Result-first: show the after, then "here's how."
9. Price anchor: "This costs less than your daily coffee and it replaced <expensive thing>."
10. Unboxing tease: "It finally came — let's see if it's worth the hype."

## Higgsfield workflow

1. **Product import**: if the brief has a URL, use the `higgsfield-generate`
   skill's Marketing Studio — "import product from URL" — to pull product
   visuals automatically.
2. **Casting (0 credits, BLOCKING)**: per brief, no standing defaults — see
   `production.md` gate G2. If the brief's Cast field doesn't pin an avatar
   ID, build a contact sheet from free previews and wait for the user's
   pick. Never submit a video without an avatar ID — the backend silently
   auto-picks one.
3. **Storyboard previz (1-credit stills, BLOCKING for new looks)**: generate
   one key-frame still per storyboard beat — chosen presenter holding the
   product in the setting, wardrobe visible, end-card frame. Iterate cheaply
   until the user approves the look. Skip only when the brief says
   `Previz: skip` or a beat reuses an already-approved look.
4. **Stills**: `higgsfield-product-photoshoot` for hero shots, hands-holding
   closeups (`closeup_product_with_person`), lifestyle scenes. Generate stills
   first — they're cheap to iterate on.
5. **Video**: `higgsfield-generate` Marketing Studio for the TALKING take only
   (speech + lipsync + product angle-lock is what the 60 credits buy). Pass
   the approved previz frame as `start_image` so the take opens on the
   approved look. For non-speaking b-roll beats (pour shots, steam, pack
   close-ups), animate approved stills with image-to-video instead —
   Seedance 2.0 (quality) or Kling 3.0 Turbo (budget) — it's cheaper than a
   second Marketing Studio take and you control the exact source frame.
6. **Score before finalizing**: run the Virality Predictor (`brain_activity`)
   on candidates; regenerate weak hooks.

## Prompt patterns for the "real UGC" look

Append to visual prompts:
- "shot on a phone, handheld, slight camera shake, vertical 9:16"
- "natural window light, lived-in bedroom/kitchen/car interior"
- "casual clothing, no makeup-artist polish, real skin texture"
- "talking directly to camera like a facetime call"

Avoid: "cinematic", "studio lighting", "8k", "professional" — those produce
the glossy AI-ad look that audiences scroll past.

## Post-production

- Captions on by default (most viewers watch muted): `tools/burn_captions.sh`
- First frame must work as a thumbnail — no black lead-in.
- Deliver 3+ hook variants per brief; same body, different first 2 seconds.
