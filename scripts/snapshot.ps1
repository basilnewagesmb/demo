# Takes a 1440x900 screenshot of every site in ../sites with headless Chrome.
# Output: ../snapshots/<id>.png, where <id> is the file name before the first "-" (e.g. v4).
# Usage:  powershell -ExecutionPolicy Bypass -File scripts\snapshot.ps1 [-Only v5]

param([string]$Only = "")

$root  = Split-Path -Parent $PSScriptRoot
$sites = Join-Path $root "sites"
$out   = Join-Path $root "snapshots"
New-Item -ItemType Directory -Force $out | Out-Null

$chrome = @(
  "C:\Program Files\Google\Chrome\Application\chrome.exe",
  "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
) | Where-Object { Test-Path $_ } | Select-Object -First 1
if (-not $chrome) { throw "Chrome or Edge not found." }

Get-ChildItem $sites -Filter *.html | ForEach-Object {
  $id = ($_.BaseName -split "-")[0]
  if ($Only -and $id -ne $Only) { return }
  $png = Join-Path $out "$id.png"
  $url = "file:///" + ($_.FullName -replace "\\", "/")
  & $chrome --headless=new --disable-gpu --hide-scrollbars --window-size=1440,900 `
    --virtual-time-budget=5000 "--screenshot=$png" $url 2>$null | Out-Null
  Write-Host "$id <- $($_.Name)"
}
