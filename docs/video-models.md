# Higgsfield video models — cost and strengths

Measured with free `get_cost` preflights (July 2026) at a standard scene:
**~10s, 720p, 9:16, audio on** where the model supports it. Prices move —
re-preflight before relying on a number. Full details per model:
`higgsfield model get <id>` / `models_explore(action:'get')`.

## The talking-presenter tier (no substitute)

| Model | Credits | Why it exists |
|---|---|---|
| `marketing_studio_video` | 60 (12s) / 75 (15s max) | The ONLY package with speech + lipsync + product angle-lock in one generation. Presenter ads, UGC talking heads, unboxings. Registered products render faithfully; avatars are pinned by ID. Not exposed to Higgsfield apps — first-party only. |

## Scene generation ladder (silent or ambient-audio clips)

| Tier | Model | Credits | Strengths | Watch out |
|---|---|---|---|---|
| Premium cinematic | `cinematic_studio_3_0` | 50 | Cinema-grade look, genre control, up to 4K | Audio OFF by default |
| Premium reference | `seedance_2_0` (std) | 45 | The continuity workhorse: image/video/audio references, consistent identity across scenes, start+end frames, native audio, up to 4K | Highest per-scene cost |
| Premium-fast | `seedance_2_0` (fast) | 35 | Same reference system, faster | 480/720p only |
| Mid | `seedance_2_0_mini` | 25 | Keeps the full reference system at half the price | 480/720p only |
| Mid cinematic | `veo3_1` (8s, fast) | 22 | Ultra-realistic look | 4/6/8s only |
| Standard | `kling3_0` (std, sound on) | 20 | Multi-shot support, audio sync, motion transfer | `sound: off` lowers cost |
| Budget | `kling3_0_turbo` | 15 | Fast start-frame animation | No audio |
| Budget long | `seedance1_5` | 14.39 for **12s** | Cheapest per second on the ladder | Fixed 4/8/12s durations |
| Budget batch | `veo3_1_lite` (8s + audio) | 12 | Volume b-roll | Audio costs extra; 4/6/8s |
| Cheapest | `minimax_hailuo` (10s) | 11 | Good physics and facial emotion | No audio at 768p |

## Specialists

| Model | Use when |
|---|---|
| `wan2_7` | Character-consistent stylized video with synced audio references |
| `gemini_omni` | Up to 7 image refs or a video ref drive the output; native audio; 4–10s |
| `grok_video_v15` | Bold image-to-video from one start frame with audio direction; 2–15s |
| `kling2_6` | Cinematic motion physics at 5/10s |
| `higgsfield_preset` | Preset-routed viral templates (image-to-video) |

## Post tools (transform, don't regenerate)

| Tool | Job |
|---|---|
| `bytedance_video_upscale` | 720p → 1080p/2K/4K; upscale ONLY the winning cut |
| `sync_so` (Lipsync 3) | Add lipsync to a scene from a VO segment |
| `voice_change` | Swap the voice on a finished video, visuals/timing intact |
| `reframe` | Change aspect ratio of an existing video |
| `explainer_video` | Server-side assembly of narrated 10s blocks |
| `brain_activity` (Virality Predictor) | Attention/hook scoring of a finished cut |

## Picking rules that survived real production

1. **Talking on camera → Marketing Studio.** Nothing else lipsyncs speech
   it generates. Everything else is b-roll/scene work.
2. **Multi-scene continuity → Seedance 2.0 family.** Same character/product
   reference images on every scene; chain last frame → next start frame.
3. **Generate at 720p, upscale winners.** Resolution multiplies cost at
   generation time; upscaling one final cut is cheaper than 4K takes.
4. **Audio flags move price.** Kling sound-off and Veo Lite audio-extra are
   real savings on silent b-roll that gets a VO anyway.
5. **Preflight everything** — `get_cost: true` is free and exact.
