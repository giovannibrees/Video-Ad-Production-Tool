#!/usr/bin/env bash
# Convert any clip to 1080x1920 vertical (9:16): center-crop if too wide,
# scale+pad (blurred background) if too tall/narrow content should be kept.
# Usage: to_vertical.sh input.mp4 output.mp4 [crop|blurpad]
set -euo pipefail

in="$1"; out="$2"; mode="${3:-crop}"

if [ "$mode" = "blurpad" ]; then
  # Keep full frame, fill 9:16 canvas with a blurred copy behind it
  ffmpeg -y -i "$in" -filter_complex \
    "[0:v]scale=1080:1920:force_original_aspect_ratio=increase,crop=1080:1920,boxblur=20:5[bg];\
     [0:v]scale=1080:1920:force_original_aspect_ratio=decrease[fg];\
     [bg][fg]overlay=(W-w)/2:(H-h)/2" \
    -r 30 -c:v libx264 -preset medium -crf 20 -pix_fmt yuv420p \
    -c:a aac -b:a 128k -movflags +faststart "$out"
else
  ffmpeg -y -i "$in" -vf \
    "scale=1080:1920:force_original_aspect_ratio=increase,crop=1080:1920" \
    -r 30 -c:v libx264 -preset medium -crf 20 -pix_fmt yuv420p \
    -c:a aac -b:a 128k -movflags +faststart "$out"
fi
echo "wrote $out"
