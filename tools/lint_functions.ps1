param([string]$Root = (Join-Path $PSScriptRoot '..\src\data'))
$bad = 0
$files = Get-ChildItem -Path $Root -Recurse -Filter *.mcfunction -File
foreach ($f in $files) {
    $n = 0
    # ⓿ 文件头 BOM：开头是 U+FEFF 会让首行整条解析失败 ⇒ 整个 .mcfunction 不注册
    $hd = [IO.File]::ReadAllBytes($f.FullName)
    if ($hd.Length -ge 3 -and $hd[0] -eq 0xEF -and $hd[1] -eq 0xBB -and $hd[2] -eq 0xBF) { "BOM   $($f.Name):1"; $bad++ }
    foreach ($line in [IO.File]::ReadAllLines($f.FullName)) {
        $n++
        if ($line.TrimStart().StartsWith('#')) { continue }
        # ① 碎行：以 JSON/NBT 片段开头（多半是被换行切碎了）
        if ($line -match '^\s*[\[\{\}\,\"]') { "碎行  $($f.Name):$n  $($line.Substring(0,[Math]::Min(60,$line.Length)))"; $bad++ ; continue }
        # ② 裸 base64/超长无空格串
        if ($line -match '^\s*[A-Za-z0-9+/=]{40,}\s*$') { "裸串  $($f.Name):$n"; $bad++; continue }
        # ③ 单行引号数为奇数
        if ((([regex]::Matches($line,'"')).Count % 2) -ne 0) { "引号  $($f.Name):$n"; $bad++; continue }
        # ④ 单行花括号/方括号不平衡（会让整条命令解析失败、连累整个函数不被注册）
        $b = ([regex]::Matches($line,'\{')).Count - ([regex]::Matches($line,'\}')).Count
        $s = ([regex]::Matches($line,'\[')).Count - ([regex]::Matches($line,'\]')).Count
        if ($b -ne 0 -or $s -ne 0) { "括号  $($f.Name):$n  {}=$b  []=$s"; $bad++ }
    }
}
if ($bad -eq 0) { '函数体检通过：没有 BOM / 碎行 / 裸串 / 奇数引号 / 括号不平衡' } else { "共 $bad 处问题" }
