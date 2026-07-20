# Reusable Higgsfield IDs

Record IDs here so future sessions can reuse them without regenerating.
This file is account-specific — it starts empty in a fresh clone.

## Soul characters

| Name | reference_id | Trained | Notes |
|------|--------------|---------|-------|
| _(none yet — see playbooks/avatar.md)_ | | | |

## Uploaded media (Higgsfield media library)

| media_id | File | What it is |
|----------|------|------------|
| | | |

## Marketing Studio entities

| id | Type | What it is |
|----|------|------------|
| | | |

**There are NO default presenters — casting is per-brief, always.** If a
brief's Cast field doesn't pin an avatar, the session shows a contact sheet
and waits. Preset previews are free:
`show_marketing_studio(action='list', type='avatar')`.

All ~40 preset avatars read ~18–35 apparent age. Older presenters are
minted as custom avatars: 1-credit character reference → user approves the
face → `avatars create` → record the ID here.

## Voices (presets via `list_voices`)

Higgsfield publishes NO accent metadata. Record confirmed accent tags here
as you identify them by listening.

| Voice | voice_id | Gender | Accent (confirmed) |
|-------|----------|--------|--------------------|
| | | | |

Marketing Studio has no voice param: pinned voices are applied with
`voice_change` (revoice pass on the finished take). Described accents go
into the prompt's Audio direction and MUST be verified at QC.

## Winning prompt recipes / style keys

_(add prompt recipes that performed well — this library compounds)_
