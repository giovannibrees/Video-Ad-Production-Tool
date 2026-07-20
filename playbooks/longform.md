# Playbook: longform lane (30s–3min, scene pipeline)

For content longer than one take: every video model caps at ~15s, so
longform is a SCENE PIPELINE — never one generation. Same five gates as
`production.md`; this file adds the scene mechanics.

## Pipeline

1. **Script → scene list.** Break the script into 5–15s scenes. Each scene
   row: beat text (what's said/heard), visual description, duration, tier
   (from the measured ladder in `production.md`), continuity refs.
2. **Narration first (VO-first).** Generate the voiceover yourself
   (`seed_audio` / TTS with a PINNED voice — full US/UK accent control,
   no lottery). Scene durations then follow the VO timing, not vice versa.
3. **Previz stills** per scene (1 credit each, `nano_banana_2_lite` with
   product/character refs). User approves the storyboard as a contact
   sheet BEFORE any video credits.
4. **Generate scenes at their tier.** Hero scenes premium (Seedance 2.0),
   b-roll budget (Kling Turbo / Veo Lite / Hailuo). Generate at 720p.
5. **Continuity**: same character/product reference images on every scene
   (Seedance 2.0 `image_references`); chain each scene's LAST frame as the
   next scene's `start_image` when scenes connect physically. Keep
   wardrobe/setting phrases identical across scene prompts.
6. **Lipsync only where a face talks on-screen** (`sync_so` with the VO
   segment). B-roll scenes carry the VO directly.
7. **Assemble locally**: `tools/stitch.sh` (re-encodes to a common format),
   VO laid over the cut, captions via `tools/burn_captions.sh`, cards via
   ffmpeg. Upscale ONLY the final winning cut (`bytedance_video_upscale`).

## Budgeting a 60s piece (5–6 scenes, from the measured ladder)

| Mix | Approx credits |
|-----|----------------|
| All premium (Seedance 2.0 std) | ~225–270 |
| All standard (Kling 3.0) | ~100–120 |
| Hero premium + b-roll budget (recommended) | ~120–150 |
| All budget + VO | ~55–70 |

Plus previz (1/scene) and VO (preflight `seed_audio`). Always
`get_cost: true` before a non-standard combination.

## QC per scene (before assembly)

- Character/product consistency vs the previous scene (frame extraction).
- VO timing fits the scene duration (silencedetect vs scene bounds).
- No on-screen text/watermarks; first frame of scene 1 works as thumbnail.
- Regenerate ONLY failing scenes — that's the point of the pipeline.

## Clip Factory app

A companion Clip Factory app (built with Higgsfield Websites, `app` type) runs this lane
interactively: Scene/Previz modes, tier pill (Premium/Fast/Standard/
Budget), product + start-frame references, per-generation cost preview,
projects as campaigns. Marketing Studio (talking presenter with lipsync +
product lock) is NOT available to apps — talking takes stay in the
Claude-session pipeline (`product-ads.md`).
