#!/usr/bin/env bash
# Burn styled captions into a clip — big bold white text with black outline,
# centered in the lower third (the standard UGC caption look).
# Usage: burn_captions.sh input.mp4 subs.srt output.mp4
set -euo pipefail

in="$1"; srt="$2"; out="$3"

ffmpeg -y -i "$in" -vf \
  "subtitles='${srt}':force_style='FontName=Arial,FontSize=15,Bold=1,\
PrimaryColour=&H00FFFFFF,OutlineColour=&H00000000,Outline=2,Shadow=0,\
BorderStyle=1,Alignment=2,MarginV=60'" \
  -c:v libx264 -preset medium -crf 20 -pix_fmt yuv420p \
  -c:a copy -movflags +faststart "$out"
echo "wrote $out"
