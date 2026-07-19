param(
  [Parameter(Mandatory=$true)][ValidateSet('Animate','Reveal')][string]$Mode,
  [Parameter(Mandatory=$true)][string]$InputPath,
  [string]$OutputPath,
  [double]$ElementDelaySeconds = 0.26,
  [double]$SlideDelaySeconds = 0.8,
  [int]$CoverFirstShape = 1,
  [int]$ContentFirstShape = 1
)

$msoTrue = -1
$msoFalse = 0
$msoAnimEffectFade = 10
$msoAnimTriggerOnPageClick = 1
$ppt = New-Object -ComObject PowerPoint.Application
$ppt.Visible = $msoTrue

if ($Mode -eq 'Reveal') {
  if (-not $OutputPath) { throw 'Reveal mode requires -OutputPath.' }
  Copy-Item -LiteralPath $InputPath -Destination $OutputPath -Force
  $path = (Resolve-Path $OutputPath).Path
} else {
  $path = (Resolve-Path $InputPath).Path
}

$pres = $ppt.Presentations.Open($path, $msoFalse, $msoFalse, $msoTrue)

if ($Mode -eq 'Animate') {
  for ($si = 1; $si -le $pres.Slides.Count; $si++) {
    $slide = $pres.Slides.Item($si)
    $seq = $slide.TimeLine.MainSequence
    if ($seq.Count -eq 0) {
      $first = if ($si -eq 1) { $CoverFirstShape } else { $ContentFirstShape }
      for ($j = $first; $j -le $slide.Shapes.Count; $j++) {
        $effect = $seq.AddEffect($slide.Shapes.Item($j), $msoAnimEffectFade, 0, $msoAnimTriggerOnPageClick)
        $effect.Timing.Duration = 0.4
      }
    }
  }
} else {
  foreach ($slide in $pres.Slides) {
    foreach ($shape in $slide.Shapes) { $shape.Visible = $msoFalse }
  }
  for ($si = 1; $si -le $pres.Slides.Count; $si++) {
    $ppt.ActiveWindow.View.GotoSlide($si)
    Start-Sleep -Milliseconds ([int]($SlideDelaySeconds * 1000))
    $slide = $pres.Slides.Item($si)
    for ($j = 1; $j -le $slide.Shapes.Count; $j++) {
      $slide.Shapes.Item($j).Visible = $msoTrue
      Start-Sleep -Milliseconds ([int]($ElementDelaySeconds * 1000))
    }
    Start-Sleep -Milliseconds ([int]($SlideDelaySeconds * 1000))
  }
}

$pres.Save()
if ($Mode -eq 'Animate') { $pres.Close(); $ppt.Quit() }
