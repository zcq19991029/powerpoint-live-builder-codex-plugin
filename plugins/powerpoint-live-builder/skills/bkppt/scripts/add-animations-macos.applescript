on run argv
  if (count of argv) < 1 then error "Usage: osascript add-animations-macos.applescript INPUT_PPTX [COVER_FIRST_SHAPE=1] [CONTENT_FIRST_SHAPE=1]"
  set pptxPath to item 1 of argv
  set coverFirst to 1
  set contentFirst to 1
  if (count of argv) > 1 then set coverFirst to (item 2 of argv) as integer
  if (count of argv) > 2 then set contentFirst to (item 3 of argv) as integer

  tell application "Microsoft PowerPoint"
    open POSIX file pptxPath
    set p to active presentation
    repeat with si from 1 to count of slides of p
      set s to slide si of p
      set seq to main sequence of timeline of s
      if (count of effects of seq) is 0 then
        if si is 1 then
          set firstAnimated to coverFirst
        else
          set firstAnimated to contentFirst
        end if
        repeat with j from firstAnimated to count of shapes of s
          set e to add effect seq for shape j of s fx animation type fade trigger on page click
          set duration of timing of e to 0.4
        end repeat
      end if
    end repeat
    save p
    close p saving yes
  end tell
end run
