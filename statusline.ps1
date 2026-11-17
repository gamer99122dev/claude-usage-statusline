[Console]::OutputEncoding = [Text.Encoding]::UTF8
$reader = New-Object IO.StreamReader([Console]::OpenStandardInput(), (New-Object Text.UTF8Encoding $false))
$j = $reader.ReadToEnd() | ConvertFrom-Json
$sep = " $([char]0x2502) "
$out = $j.model.display_name
$r = $j.rate_limits
if ($r.five_hour) { $out += $sep + "5h $([math]::Round(100 - $r.five_hour.used_percentage))%" }
if ($r.seven_day) { $out += $sep + "Week $([math]::Round(100 - $r.seven_day.used_percentage))%" }
$out
