#!/usr/bin/env bash
# Stitch clips into one video. Re-encodes everything to a common format
# (1080x1920/30fps/aac) so mismatched sources concat cleanly.
# Usage: stitch.sh output.mp4 clip1.mp4 clip2.mp4 [...]
set -euo pipefail

out="$1"; shift
[ "$#" -ge 2 ] || { echo "need at least 2 input clips" >&2; exit 1; }

inputs=(); filter=""; i=0
for clip in "$@"; do
  inputs+=(-i "$clip")
  filter+="[$i:v]scale=1080:1920:force_original_aspect_ratio=increase,crop=1080:1920,fps=30,setsar=1[v$i];"
  filter+="[$i:a]aresample=48000[a$i];"
  i=$((i+1))
done
for ((j=0; j<i; j++)); do filter+="[v$j][a$j]"; done
filter+="concat=n=$i:v=1:a=1[v][a]"

ffmpeg -y "${inputs[@]}" -filter_complex "$filter" -map "[v]" -map "[a]" \
  -c:v libx264 -preset medium -crf 20 -pix_fmt yuv420p \
  -c:a aac -b:a 128k -movflags +faststart "$out"
echo "wrote $out"
