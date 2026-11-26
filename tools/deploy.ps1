param(
  [string]$SavePath,          # 直接指到存档目录（…\saves\新的世界）
  [string]$GameDir,           # 或者只给游戏目录，脚本自己找唯一的存档
  [string]$World = ""         # 存档里有多份 pack 时按名字挑
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$repo = Split-Path -Parent $PSScriptRoot
$src  = Join-Path $repo "src"
if (-not (Test-Path $src)) { throw "找不到 $src" }

function Find-Saves([string]$dir) {
  if ([string]::IsNullOrWhiteSpace($dir)) { return @() }
  $p = Join-Path $dir "saves"
  if (-not (Test-Path $p)) { return @() }
  return @(Get-ChildItem $p -Directory | Select-Object -ExpandProperty FullName)
}

$candidates = @()
if ($SavePath) { $candidates = @($SavePath) }
else {
  $roots = @()
  if ($GameDir) { $roots += $GameDir }
  $roots += (Join-Path $env:APPDATA ".minecraft")
  $roots += "E:\Games\mc启动器\.minecraft"
  $pclRoot = "E:\Games\mc启动器\PCL 正式版 2.10.3\.minecraft"
  if (Test-Path $pclRoot) {
    $roots += $pclRoot
    Get-ChildItem (Join-Path $pclRoot "versions") -Directory -ErrorAction SilentlyContinue | ForEach-Object {
      $c = Join-Path $_.FullName ".minecraft"
      if (Test-Path $c) { $roots += $c }
    }
  }
  foreach ($r in $roots) { $candidates += (Find-Saves $r) }
}

$candidates = @($candidates | Where-Object { (Test-Path (Join-Path $_ "level.dat")) } | Select-Object -Unique)
if ($candidates.Count -eq 0) { throw "没找到存档：请用 -SavePath 直接指定存档目录" }
if ($candidates.Count -gt 1) {
  if ($World) {
    $hit = $candidates | Where-Object { (Split-Path $_ -Leaf) -eq $World }
    if (-not $hit) { throw ("没有叫 " + $World + " 的存档；现有：" + (($candidates | ForEach-Object { Split-Path $_ -Leaf }) -join ", ")) }
    $candidates = @($hit)
  } else {
    throw ("找到多个存档，请用 -SavePath 或 -World 指定：" + (($candidates | ForEach-Object { Split-Path $_ -Leaf }) -join ", "))
  }
}
$worldPath = $candidates[0]

$root    = Split-Path -Parent (Split-Path -Parent $worldPath)  # …\versions\1.20.1-Forge\\.minecraft
$dpRoot  = Join-Path $worldPath "datapacks"
$dest    = Join-Path $dpRoot "kitpvp"
New-Item -ItemType Directory -Force -Path $dest | Out-Null

Copy-Item (Join-Path $src "pack.mcmeta") $dest -Force
Copy-Item (Join-Path $src "data")       $dest -Recurse -Force

# ★ 剪掉"仓库里已经没有"的旧函数：只覆盖不删除的话，改名/删掉的生灵会一直留在存档里
$srcFiles  = Get-ChildItem (Join-Path $src "data") -Recurse -File | ForEach-Object { $_.FullName.Substring((Join-Path $src "data").Length) }
$destFiles = Get-ChildItem (Join-Path $dest "data") -Recurse -File | ForEach-Object { $_.FullName.Substring((Join-Path $dest "data").Length) }
$stale = @($destFiles | Where-Object { $srcFiles -notcontains $_ })
foreach ($s in $stale) { Remove-Item ((Join-Path $dest "data") + $s) -Force }

$n = (Get-ChildItem (Join-Path $dest "data") -Recurse -File | Measure-Object).Count
"已同步 $n 个文件 -> $dest"
if ($stale.Count -gt 0) { "已清理 " + $stale.Count + " 个仓库里已不存在的旧文件：" + (($stale | ForEach-Object { Split-Path $_ -Leaf }) -join ", ") }

# 同名的 zip 会让文件夹失效（同名只会读一个），自动改名停用
$zip = Join-Path $dpRoot "kitpvp.zip"
if (Test-Path $zip) {
  try { Move-Item $zip ($zip + ".off") -Force; "已停用同名的 kitpvp.zip（改成 .off）" }
  catch { "！kitpvp.zip 正被游戏占用：先退出游戏再跑一次本脚本" }
}
"下一步：进游戏 /reload，看到 Kitpvp loaded 就成了"
