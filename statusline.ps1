$Version = 'v1.0.0'  # bump together with the GitHub release tag
[Console]::OutputEncoding = [Text.Encoding]::UTF8
$reader = New-Object IO.StreamReader([Console]::OpenStandardInput(), (New-Object Text.UTF8Encoding $false))
$j = $reader.ReadToEnd() | ConvertFrom-Json
$sep = " $([char]0x2502) "
$out = $j.model.display_name
$r = $j.rate_limits
if ($r.five_hour) { $out += $sep + "5h $([math]::Round(100 - $r.five_hour.used_percentage))%" }
if ($r.seven_day) { $out += $sep + "Week $([math]::Round(100 - $r.seven_day.used_percentage))%" }

# Update check: at most once a day, in a hidden background process so the status line never waits on the network.
$cache = Join-Path $HOME '.claude\statusline-latest.txt'
$f = Get-Item $cache -ErrorAction SilentlyContinue
if (-not $f -or $f.LastWriteTime -lt (Get-Date).AddDays(-1)) {
    if ($f) { $f.LastWriteTime = Get-Date } else { New-Item $cache -Force | Out-Null }  # claim today's check before spawning
    $api = 'https://api.github.com/repos/gamer99122dev/claude-usage-statusline/releases/latest'
    $p = $cache -replace "'", "''"
    Start-Process powershell -WindowStyle Hidden -ArgumentList '-NoProfile', '-Command',
        "[Net.ServicePointManager]::SecurityProtocol = 'Tls12'; try { (Invoke-RestMethod '$api' -TimeoutSec 10).tag_name | Set-Content -NoNewline '$p' } catch {}"
}
$latest = if ($f) { (Get-Content $cache -Raw) } else { '' }
try {
    if ($latest -and [version]$latest.Trim().TrimStart('v') -gt [version]$Version.TrimStart('v')) {
        $out += $sep + "$([char]0x2191) $($latest.Trim())"
    }
} catch {}  # malformed cache: ignore
$out
