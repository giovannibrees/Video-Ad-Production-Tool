# Playbook: faceless content

Goal: narrated vertical clips with no on-camera person — explainer,
listicle, storytime, or pure b-roll + captions. Cheapest lane to run at
volume; consistency beats any single viral hit.

## Formats

| Format | Length | Engine |
|--------|--------|--------|
| Narrated explainer / storytime | 30–60s | `higgsfield-video-explainer` skill (built for exactly this: 10s narrated blocks, faceless mode, optional burned subtitles) |
| Listicle ("5 things…") | 20–40s | explainer skill, one list item per 10s block |
| B-roll + captions (no voice) | 8–15s | `higgsfield-generate` text-to-video, captions via ffmpeg |
| Ambient/satisfying loops | 8–12s | `higgsfield-generate`, seamless-loop prompt |

## Script rules

- Narration ~2.5 words/second. A 10s block = ~25 words, one idea per block.
- Block 1 is the hook: open with the payoff or a question, never context.
  Bad: "Today we're going to talk about…" Good: "This mistake costs you
  \$400 a year, and you're probably making it right now."
- End with a loop-friendly or CTA line ("follow for part 2").

## Higgsfield workflow (explainer lane)

The `higgsfield-video-explainer` skill handles the whole chain — one visual
style key, per-block narration (Seed Audio) + visuals (Gemini Omni), then
server-side assembly. Key choices to make from the brief:

1. Pick a style preset (`higgsfield preset list video-explainer`) and stick
   with ONE style per channel — visual consistency builds recognition.
2. Faceless or mascot mode (a recurring mascot is a cheap brand asset).
3. Burned subtitles: yes by default.

## Higgsfield workflow (b-roll lane)

1. Script the caption text first (that IS the content).
2. Generate 9:16 clips with `higgsfield-generate`; prompt for macro detail,
   slow camera pushes, satisfying motion.
3. Burn styled captions with `tools/burn_captions.sh`, stitch multiple
   shots with `tools/stitch.sh`.

## Post-production

- Keep a channel style file per faceless channel in `assets/` (style key,
  voice ID, caption style) so every clip matches.
- Batch: generate a week of clips per session — faceless thrives on cadence.
