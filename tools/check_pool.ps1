# 池子体检：summon 目录里每个 earth_*.mcfunction 是否被 skill/earth/random.mcfunction 引用；池号是否连续唯一
# 用法：powershell.exe -NoProfile -ExecutionPolicy Bypass -File tools\check_pool.ps1
$root = Split-Path -Parent $PSScriptRoot
$fn = Join-Path $root "src\data\kitpvp\functions"
$rnd = [IO.File]::ReadAllText((Join-Path $fn "skill\earth\random.mcfunction"))
$pool = [regex]::Match($rnd, "#pool_size kitpvp.game (\d+)").Groups[1].Value
$ms = @([regex]::Matches($rnd, "matches (\d+) run function kitpvp:summon/(\w+)"))
"pool_size = $pool，matches 条数 = $($ms.Count)"
$nums = @($ms | ForEach-Object { [int]$_.Groups[1].Value } | Sort-Object)
"编号唯一 = $((($nums | Sort-Object -Unique).Count) -eq $nums.Count)"
$gap = @(0..([int]$pool - 1) | Where-Object { $nums -notcontains $_ })
"缺号 = [" + ($gap -join ",") + "]"
# 辅助文件（子部件/收尾函数）不要求进池，这里只列出可疑的
$helpers = @("earth_twinstar_a","earth_twinstar_b","earth_minecart","earth_minecart_plain","earth_gentleman_rain_end","earth_grass_pop", "earth_ascend_pick", "earth_ascend", "earth_ascend2", "earth_cop_pick", "earth_cop_pick_b", "earth_cop", "earth_cop_cleaner", "earth_cop_blink","earth_hacker_death","earth_flyer_a", "earth_flyer_b", "earth_lowflyer_a", "earth_lowflyer_b", "earth_polypeptide", "earth_polypeptide_betaturn","earth_phoenix_pair")
Get-ChildItem (Join-Path $fn "summon") -Filter "earth_*.mcfunction" | ForEach-Object {
  $n = $_.BaseName
  if ($helpers -notcontains $n -and $rnd -notmatch [regex]::Escape($n)) { "未入池（且不在白名单）: $n" }
}
"体检结束"
