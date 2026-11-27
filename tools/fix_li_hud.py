import io, os, glob

D = r"src/data/kitpvp/functions/skill/li_ench"

for p in glob.glob(os.path.join(D, "**", "*.mcfunction"), recursive=True):
    with io.open(p, encoding="utf-8") as f:
        s = f.read()
    o = s
    s = s.replace("scores={kitpvp.kit=15", "scores={kitpvp.kit=99")
    s = s.replace("kitpvp.kit matches 15", "kitpvp.kit matches 99")
    s = s.replace("kitpvp:ench_s", "kitpvp:li_s").replace("kitpvp:ench_a", "kitpvp:li_a")
    if s != o:
        with io.open(p, "w", encoding="utf-8", newline="\n") as f:
            f.write(s)

# load：给里·附魔师建 16 条独立进度条
p = r"src/data/kitpvp/functions/load.mcfunction"
with io.open(p, encoding="utf-8") as f:
    s = f.read()
if "bossbar add kitpvp:li_s1" not in s:
    bars = []
    for i in range(1, 9):
        bars.append('bossbar add kitpvp:li_s%d {"text":"剑 · 附魔等级 0","color":"purple"}' % i)
        bars.append('bossbar set kitpvp:li_s%d style progress' % i)
        bars.append('bossbar set kitpvp:li_s%d max 900' % i)
        bars.append('bossbar set kitpvp:li_s%d value 0' % i)
        bars.append('bossbar add kitpvp:li_a%d {"text":"护甲 · 附魔等级 0","color":"blue"}' % i)
        bars.append('bossbar set kitpvp:li_a%d style progress' % i)
        bars.append('bossbar set kitpvp:li_a%d max 900' % i)
        bars.append('bossbar set kitpvp:li_a%d value 0' % i)
    s = s.rstrip("\n") + "\n# 里·附魔师专属进度条（与表附魔师分开，避免互清）\n" + "\n".join(bars) + "\n"
    with io.open(p, "w", encoding="utf-8", newline="\n") as f:
        f.write(s)
print("li hud isolated")
