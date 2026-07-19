#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 2 || $# -gt 4 ]]; then
  echo "Usage: $0 SOURCE_PPTX LIVE_COPY_PPTX [ELEMENT_DELAY=0.26] [SLIDE_DELAY=0.8]" >&2
  exit 2
fi

source_pptx=$1
live_pptx=$2
element_delay=${3:-0.26}
slide_delay=${4:-0.8}
cp "$source_pptx" "$live_pptx"

osascript - "$live_pptx" "$element_delay" "$slide_delay" <<'APPLESCRIPT'
on run argv
  set livePath to item 1 of argv
  set elementDelay to (item 2 of argv) as real
  set slideDelay to (item 3 of argv) as real
  tell application "Microsoft PowerPoint"
    open POSIX file livePath
    activate
    set p to active presentation
    repeat with si from 1 to count of slides of p
      set s to slide si of p
      repeat with j from 1 to count of shapes of s
        set visible of shape j of s to false
      end repeat
    end repeat
    set slide of view of document window 1 to slide 1 of p
    delay slideDelay
    repeat with si from 1 to count of slides of p
      set s to slide si of p
      set slide of view of document window 1 to s
      delay slideDelay
      repeat with j from 1 to count of shapes of s
        set visible of shape j of s to true
        delay elementDelay
      end repeat
      delay slideDelay
    end repeat
    save p
  end tell
end run
APPLESCRIPT
