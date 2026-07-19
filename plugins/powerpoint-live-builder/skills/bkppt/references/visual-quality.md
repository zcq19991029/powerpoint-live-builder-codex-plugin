# Visual quality and image fusion

## Illustration rules

- On GPT-based runs, use `image2`/`image_gen` for every requested newly generated raster teaching illustration.
- Do not treat native PowerPoint vectors as a substitute for image2 when the user explicitly asks for a generated illustration. Native vectors remain appropriate for editable coordinate systems, formulas, process diagrams, and simple geometric constructions.
- Generate illustrations at a slide-friendly aspect ratio with no embedded labels when editable PowerPoint labels are preferable.
- Keep scientific diagrams accurate. Verify axes, rotation direction, radii, and relative geometry.
- Preserve generated illustration colors unless the user asks for recoloring.

## Exact background matching

1. Sample actual pixels from visually blank regions of the source image using ImageMagick or an equivalent pixel inspector.
2. Sample more than one location: top-left blank area, top-center blank area, and another clean corner.
3. Recognize that a textured or vignetted illustration has no single perfect solid background color.
4. Select the color nearest the image edge that will touch the slide background, not a visually guessed screenshot color.
5. Run `scripts/sample-and-feather.sh` when texture or vignetting still exposes the rectangular image boundary.
6. Use the resulting transparent PNG with `fit: contain`; do not crop educational content merely to fill a frame.
7. Remove rounded image masks and visible image borders when the intended look is one continuous chalkboard.

The feather script changes edge opacity only. It does not recolor the illustration.

## Text and image separation

- Never place a formula strip or explanatory text over an instructional illustration unless the user explicitly requests an overlay.
- Reserve a separate text band above, below, or beside the image.
- Maintain at least 16–24 px between the image area and the text band.
- Check slides at full resolution, not only in a montage.

## Validation checklist

- Render every slide to PNG.
- Inspect all image-heavy slides full size.
- Run the presentation overflow test.
- Validate the exported Office file.
- Confirm the source image is fully visible where the user requested no cropping.
- Confirm text boxes do not overlap image frames.
- Confirm the image/background transition is not visibly rectangular.
- Confirm all slide XML files contain `<p:timing>` when animation is required.
