---
name: bkppt
description: Create polished editable teaching and lesson-preparation PowerPoint decks with learning objectives, learner analysis, knowledge-point sequencing, examples, practice, summaries, mandatory image2/image_gen use for new GPT-generated teaching illustrations, sampled/feathered image-background blending, click-to-reveal elements, Office validation, and optional blank-to-finished demonstrations. Use for classroom .pptx creation or redesign, courseware, trial lessons, dynamic board-writing effects, officecli workflows, CLI Anything WPS platform routing, PowerPoint AppleScript on macOS, or WPS/PowerPoint COM automation on Windows.
---

# PowerPoint Live Builder

Create the finished `.pptx` first, validate it, and add native PowerPoint animation. Treat the live build as a separate optional presentation mode.

This skill is subject-agnostic but teaching-centered. Apply it to mathematics, engineering, language, vocational education, science, humanities, software, professional training, and other lessons. Never reuse the bundled example's subject, school, palette, page count, or chalkboard style unless the user explicitly requests them.

## Non-negotiable behavior

- Ask about subject/topic, learner level, lesson duration, teaching context, learning objectives, difficult points, page count, visual style, brand, and animation behavior when missing and materially consequential. Do not invent school facts or teaching requirements.
- At the beginning of every invocation, present the concise second-chance reminder in `references/intake-prompt.md`. Explicitly summarize visual style, output format/aspect ratio, fonts, color palette/brand, and animation behavior. For each unresolved consequential field, offer 2–3 concrete choices, mark one as recommended, and explain the visible tradeoff in one short phrase. Do not silently choose for the user.
- Do not repeat questions already answered by the prompt or supplied files. Summarize extracted choices and ask only for missing mandatory fields.
- Keep working in the same task while the user can add or override constraints. Continue reversible work such as reading sources, lesson outlining, asset inventory, and draft planning instead of asking the user to start a new conversation. Do not begin visual authoring, illustration generation, animation authoring, or export until the user has received the choice panel and has had an opportunity to answer in the same task. Incorporate steered input before final authoring/export.
- Default to output only. Do not open applications or demonstrate the build unless the user explicitly asks to see it.
- When the user explicitly requests a demonstration, show the real Microsoft PowerPoint front end and build every requested page from a blank canvas by revealing or creating elements in layer order.
- Preserve the normal deliverable while using a separate `-现场搭建演示.pptx` copy for demonstrations.
- Prefer Microsoft PowerPoint. WPS macOS lacks a dependable external animation/document object model; do not promise equivalent automation.
- Preserve editable text, shapes, formulas, and images. Avoid flattening whole slides into screenshots.
- When running on a GPT model and the lesson needs a newly generated raster illustration, call the image-generation capability exposed as `image2` or `image_gen`. Do not substitute a low-quality placeholder, screenshot, unrelated stock image, or manually faked raster. Use native PowerPoint vectors only when the visual is genuinely better represented as editable axes, geometry, labels, tables, or diagrams. If image2/image generation is unavailable, state the limitation and ask whether to proceed with user-provided assets or native vectors.

## Workflow

1. Load the available presentation skill and use its required artifact creation and render/verify workflow.
2. Run the choice-based intake reminder from `references/intake-prompt.md`, then read the source material completely and plan the lesson while waiting for same-task guidance. Read `references/teaching-workflow.md`. Pass the confirmation checkpoint before visual authoring.
3. Generate original raster illustrations with image2/image generation when custom teaching visuals improve comprehension. This is mandatory for GPT-based runs that require newly generated raster illustrations.
4. Build the deck as a distinct output file. Use consistent slide size, visual hierarchy, margins, and brand accents.
5. Blend illustrations using the exact procedure in `references/visual-quality.md`; do not eyeball a color from a screenshot.
6. Render every slide, inspect all pages, run the slide-overflow test, and validate the `.pptx` with `officecli validate` and `officecli view ... issues` when officecli is available.
7. Add native click-to-reveal animation with the platform script in `scripts/`.
8. Confirm all slide XML files contain animation timing before delivery.
9. If the user explicitly requests a live demonstration, read `references/live-demonstration.md` and run the platform-specific reveal workflow.

## Animation defaults

- Keep full-slide background, persistent header chrome, page number, and footer visible when the deck structure makes those elements identifiable. Otherwise animate all shapes rather than assuming template-specific shape indexes.
- Animate meaningful content in pedagogical order: problem/context, prior knowledge, diagram or evidence, labels, derivation or reasoning, conclusion, then practice prompt.
- Use a restrained fade entrance, `0.35–0.5 s`, triggered on page click.
- Do not animate decorative borders separately when they logically belong to a label; group them when supported or reveal them consecutively.
- If the user asks for automatic playback, change triggers to `after previous` and set deliberate delays. Do not silently switch click animations to automatic.

## Platform routing

- **macOS + Microsoft PowerPoint:** use `scripts/add-animations-macos.applescript`; use `scripts/live-reveal-macos.sh` only after an explicit demonstration request.
- **macOS + CLI Anything WPS:** `cli-anything-wps` can author its Impress project JSON, but its `export render` path uses Windows WPS COM/pywin32 and cannot directly emit PPTX on macOS. Produce the final `.pptx` with the presentation artifact workflow or `officecli`; never claim that CLI Anything WPS exported it.
- **Windows + WPS:** CLI Anything WPS may create and render through WPS COM when WPS and pywin32 are installed. `officecli` is optional for output but recommended as an independent validator.
- **Windows + Microsoft PowerPoint:** use `scripts/powerpoint-windows.ps1`, which calls the PowerPoint COM object model.
- **WPS:** deliver the `.pptx`, but explain that native PowerPoint animation/live automation may not be fully compatible.
- **No desktop automation capability:** still produce and validate the `.pptx`; explain that the live UI demonstration is unavailable in that environment.

## Resources

- `references/visual-quality.md`: exact image-background sampling, feathering, layout, and QA rules.
- `references/intake-prompt.md`: mandatory invocation reminder and reusable user prompt template.
- `references/teaching-workflow.md`: general lesson-preparation structure and classroom quality checks.
- `references/live-demonstration.md`: safe output-only versus live-show behavior and presentation sequence.
- `references/platform-automation.md`: macOS AppleScript and Windows COM mapping.
- `scripts/sample-and-feather.sh`: sample image pixels and create an edge-feathered transparent PNG without recoloring it.
- `scripts/add-animations-macos.applescript`: add click-fade effects to an unanimated deck on macOS.
- `scripts/live-reveal-macos.sh`: create a separate live copy, hide shapes, then reveal all pages in PowerPoint.
- `scripts/powerpoint-windows.ps1`: add animations or run the live reveal on Windows.
