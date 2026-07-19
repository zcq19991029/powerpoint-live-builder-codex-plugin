#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 2 || $# -gt 4 ]]; then
  echo "Usage: $0 INPUT_IMAGE OUTPUT_PNG [INSET_PX=70] [BLUR_SIGMA=45]" >&2
  exit 2
fi

input=$1
output=$2
inset=${3:-70}
blur=${4:-45}

command -v magick >/dev/null || { echo "ImageMagick 'magick' is required." >&2; exit 1; }
read -r width height < <(magick identify -format '%w %h' "$input")
x2=$((width - inset))
y2=$((height - inset))

echo "Pixel samples:"
magick "$input" -format \
  "top-left=%[hex:p{80,80}] top-center=%[hex:p{$((width/2)),80}] bottom-right=%[hex:p{$((width-80)),$((height-80))}]\n" info:

magick "$input" \
  \( -size "${width}x${height}" xc:black \
     -fill white -draw "rectangle ${inset},${inset} ${x2},${y2}" \
     -blur "0x${blur}" \) \
  -alpha off -compose CopyOpacity -composite "$output"

echo "Wrote feathered PNG without recoloring: $output"
