# Playbook: production pipeline (all lanes)

The gated pipeline every video goes through. Gates exist so credits are only
spent on things the user has already seen and approved. Nothing here is
brand-specific — any product, any script, any cast, any style, per brief.

## The five gates

| Gate | What's approved | Cost to reach it |
|------|-----------------|------------------|
| G1 Script | Hook/script text, beat timing | 0 credits |
| G2 Cast | Who is on camera (per brief — NO standing defaults) | 0 credits (previews are free) |
| G3 Previz | Key-frame stills: cast + wardrobe + setting + product framing | ~1 credit per beat |
| G4 Take | The generated video take(s) | 60 cr (≤12s) / 75 cr (15s, platform max) per Marketing Studio take |
| G5 Final | Stitched, captioned, QC'd deliverable | 0 credits (local ffmpeg) |

A gate only opens with explicit user approval, except where the brief
pre-approves it in writing (e.g. `Previz: skip`). "Just go" opens G1 and
G4 spend — it never skips G2 (casting) for a presenter video.

## G2 — Casting (0 credits, blocking for presenter videos)

- Every brief casts fresh. There are no default presenters by design —
  the tool must be able to make any video with any actor.
- If the brief pins an avatar name/ID → use it, done.
- If the brief describes a person ("man 30s, stylish") or says nothing →
  build a contact sheet from preset avatar previews (free downloads via
  `show_marketing_studio(action='list', type='avatar')` / CLI
  `marketing-studio avatars list`), send it, and wait for a pick.
- Custom faces: create a custom avatar from user-supplied photos
  (`marketing-studio avatars create`), or train a Soul (see
  `playbooks/avatar.md`) for a reusable identity.
- **Ages outside ~18–35**: the entire preset roster reads young (verified
  2026-07-19 — all 40 presets, no age metadata in the API). For older
  presenters, mint a custom avatar: generate a 1-credit character
  reference matching the brief's description ("man, 60s, silver hair…"),
  get the user's approval on the face, then register it with
  `avatars create` (image_job input works). It becomes reusable like any
  preset — record the ID in `assets/higgsfield-ids.md`.
- NEVER submit a presenter video without an avatar ID: the backend silently
  auto-picks one, which is how casting surprises happen.

## G2b — Voice (0 credits to decide, blocking for spoken video)

Marketing Studio has NO voice parameter — left alone, it invents a voice
(accent lottery — an unwanted accent is a real failure mode). Every spoken
brief needs its Voice field resolved before the take:

- **Pinned preset voice** (from `list_voices` — 40 presets with preview
  URLs): full control. Applied as a `voice_change` revoice pass on the
  completed take (accepts the video job_id; keeps visuals + timing).
- **Described voice** ("neutral American, warm, mid-30s"): write it into
  the enhanced prompt's Audio direction, then VERIFY the accent at QC —
  description steers but does not guarantee.
- Empty Voice field → ask the user, same as casting. QC checklist includes
  an accent/voice check against the brief.

## G3 — Previz (~1 credit per beat)

One key-frame still per storyboard beat: the chosen cast holding the product
in the setting, wardrobe visible, plus the end-card frame. Cheap model
(`nano_banana_2_lite` + product photo reference) is enough — the goal is
look-approval, not final pixels.

- Default ON for any new look (new cast, setting, wardrobe, or product).
- Skip when the brief says `Previz: skip` or a beat reuses an
  already-approved look from a previous ad.
- Approved frames aren't just insurance — pass the opening frame as
  `start_image` to the video model so the take opens on exactly the
  approved look.

## G4 — Takes: split talking from non-talking

- **Talking beats** → Marketing Studio video (60 credits). That price buys
  speech + lipsync + product angle-lock as one package; nothing cheaper
  matches it for on-camera dialogue.
- **Non-talking b-roll** (pour shots, steam, pack close-ups, hands) →
  animate the approved previz still with image-to-video: Seedance 2.0
  (quality) or Kling 3.0 Turbo (budget). Cheaper than a second Marketing
  Studio take and the source frame is fully controlled.
- **QC every take before showing it** (see below). Regenerate only the
  takes that fail, not the whole ad.

## Model tier ladder (measured via get_cost, 2026-07-19; ~10s 720p 9:16)

| Tier | Model | Credits | Notes |
|------|-------|---------|-------|
| Talking presenter | `marketing_studio_video` | 60 (12s) / 75 (15s) | Only option with speech+lipsync+product lock; 15s max |
| Premium cinematic | `cinematic_studio_3_0` | 50 | Audio OFF by default |
| Premium reference | `seedance_2_0` (std) | 45 | Identity-consistent, image/video/audio refs, up to 4K |
| Premium-fast | `seedance_2_0` (fast) | 35 | 480/720p only |
| Mid | `seedance_2_0_mini` | 25 | Keeps reference inputs |
| Mid cinematic | `veo3_1` (8s, fast) | 22 | |
| Standard | `kling3_0` (std, sound) | 20 | Multi-shot support |
| Budget | `kling3_0_turbo` | 15 | Start-frame animation |
| Budget long | `seedance1_5` (12s!) | 14.39 | Cheapest per second |
| Budget batch | `veo3_1_lite` (8s + audio) | 12 | |
| Cheapest | `minimax_hailuo` (10s) | 11 | Good physics, no audio |

Preflight (`get_cost: true`, free) before any non-listed combination —
resolution/duration/audio all move the price. Strategy: generate at 720p,
upscale only winners (`bytedance_video_upscale`).

## G5 — QC + post (0 credits)

Machine checks first, then eyes:

- `ffprobe`: duration, resolution, fps, audio stream present.
- `silencedetect`: verify scripted pauses/beats actually landed (e.g. the
  comedic beat before a punchline — takes that rush it get regenerated).
- Frame extraction at each storyboard beat: label fidelity, cast match,
  wardrobe continuity, no unwanted text/watermarks.
- Trim to where the performance actually ends — never blind-cut at the
  storyboard timestamp if speech runs long.
- End cards, captions, stitching: local ffmpeg (`tools/`), never video
  credits.

## Getting to "best possible", honestly

No pipeline guarantees a best-ever take from one generation — these models
are stochastic. What the pipeline guarantees is that credits are never
wasted on known failure modes (casting surprise, wrong look, rushed beat,
label drift), which makes iteration cheap enough to afford the thing that
DOES produce best-possible results: **variants + selection**.

- Same body, 3+ hooks (see `product-ads.md`) — the winner is found by
  comparison, not predicted.
- Score candidates with the Virality Predictor (`brain_activity`) before
  finalizing; regenerate weak hooks.
- Keep winning prompts/recipes in `assets/higgsfield-ids.md` and next to
  outputs as `.md` files — the library compounds across briefs.

## Feedback loop (closes the pipeline)

Structured human feedback per take lives in
`output/<brief>/feedback-<take>.md` (format: `briefs/FEEDBACK-TEMPLATE.md`;
the UGC Studio panel generates it scene-by-scene). When a session receives
one:

1. Regenerate ONLY scenes flagged `tweak`/`reshoot` — never the whole take
   unless the overall verdict says `full-reshoot`.
2. Fold every "Keep (library)" item into `assets/higgsfield-ids.md` under
   winning recipes, so the next brief starts from it.
3. Published-performance numbers (hook hold, completion, CTR) outrank the
   Virality Predictor: when a recipe has real numbers, cite them when
   proposing it again; when two recipes conflict, the one with better real
   numbers wins.
