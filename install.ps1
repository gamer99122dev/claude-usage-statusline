# Copies statusline.ps1 to ~/.claude and points settings.json's statusLine at it.
$ErrorActionPreference = 'Stop'
$dir = Join-Path $HOME '.claude'
New-Item -ItemType Directory -Force $dir | Out-Null
Copy-Item (Join-Path $PSScriptRoot 'statusline.ps1') $dir -Force

$settings = Join-Path $dir 'settings.json'
$cfg = $null
if (Test-Path $settings) {
    Copy-Item $settings "$settings.bak" -Force
    $cfg = Get-Content $settings -Raw | ConvertFrom-Json
}
if (-not $cfg) { $cfg = [pscustomobject]@{} }

$script = (Join-Path $dir 'statusline.ps1') -replace '\\', '/'
$cfg | Add-Member -Force -NotePropertyName statusLine -NotePropertyValue ([ordered]@{
    type    = 'command'
    command = "powershell -NoProfile -ExecutionPolicy Bypass -File `"$script`""
})
# WriteAllText = UTF-8 without BOM; PS 5.1's Set-Content -Encoding utf8 adds a BOM.
[IO.File]::WriteAllText($settings, ($cfg | ConvertTo-Json -Depth 32))
Write-Host "Installed. Restart Claude Code to see the status line."
