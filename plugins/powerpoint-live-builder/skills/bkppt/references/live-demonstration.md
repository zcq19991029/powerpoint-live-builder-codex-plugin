# Live blank-to-finished demonstration

Only run this workflow when the user explicitly asks to watch the build. Apply it to any subject, style, slide count, and source format; do not inherit requirements from the bundled test fixture.

## Before starting

1. Finish and validate the normal deck.
2. Save it normally.
3. Create a distinct copy ending in `-现场搭建演示.pptx`.
4. Close or protect the normal deliverable.
5. Tell the user that PowerPoint will be controlled visibly.

## Demonstration sequence

1. Open the live copy in Microsoft PowerPoint.
2. Hide all shapes on all requested slides while keeping the slide background as the blank canvas.
3. Go to slide 1.
4. For each slide, reveal shapes in their z-order with a visible pause between elements.
5. Pause briefly after each completed slide, then advance to the next blank slide.
6. Save the live copy only after every element is visible again.

Use approximately `0.20–0.35 s` per element and `0.7–1.0 s` between slides. Slow down only when the user asks.

## Corrections during a demonstration

- Stop immediately when the user reports an overlap, cropping, color mismatch, or wrong order.
- Correct the normal source deck first.
- Render and validate again.
- Recreate the live copy and restart from slide 1 if the user still wants the demonstration.

## Important distinction

- **Native deck animation:** effects seen in Slide Show mode after clicks.
- **Live build demonstration:** visible PowerPoint editing process from blank canvas to finished pages.

Do not describe one as the other.
