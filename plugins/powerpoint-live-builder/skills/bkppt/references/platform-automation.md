# Platform automation mapping

## macOS PowerPoint

Use PowerPoint's AppleScript dictionary:

- `timeline of slide`
- `main sequence of timeline`
- `add effect ... fx animation type fade trigger on page click`
- `visible of shape`
- `slide of view of document window`

macOS has no Windows COM/VBS server. Accessibility, Automation, and Screen Recording permissions may be required for visible operation.

## macOS CLI output

`cli-anything-wps` can create and edit an Impress project JSON on macOS, but its `export render` command is implemented with WPS COM and pywin32. It cannot directly render a `.pptx` on macOS. Use the Codex presentation artifact workflow or `officecli` for the final PPTX, then run:

```bash
officecli validate output.pptx
officecli view output.pptx issues
```

If following a CLI-only authoring path on macOS, prefer `officecli create/add/set` over claiming WPS COM output.

## Windows PowerPoint

Use PowerPoint COM/VBA:

- `PowerPoint.Application`
- `Slide.TimeLine.MainSequence.AddEffect(...)`
- `Shape.Visible`
- `ActiveWindow.View.GotoSlide(...)`

Relevant Office constants:

- `msoAnimEffectFade = 10`
- `msoAnimTriggerOnPageClick = 1`
- `msoTrue = -1`
- `msoFalse = 0`

## Windows WPS and CLI Anything

When WPS Office and pywin32 are installed, `cli-anything-wps export render` can use WPS COM to produce the final document. In this case `officecli` is not required for output, although using it for `validate` and `view issues` remains recommended.

## WPS

WPS may open and play many `.pptx` files. On macOS it does not expose the Windows COM path required by CLI Anything WPS export. Use Microsoft PowerPoint for deterministic animation authoring and live demonstrations.
