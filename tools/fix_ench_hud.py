import io, os
ROOT = r"E:\Projects\mc-kitpvp"
FN = os.path.join(ROOT, "src", "data", "kitpvp", "functions")

def read(p):
    with io.open(p, "r", encoding="utf-8") as f:
        return f.read()

def write(p, s):
    with io.open(p, "w", encoding="utf-8", newline="\n") as f:
        f.write(s)

# 1) clear_player：收条后把槽位清零，避免旧槽残留
p = os.path.join(FN, "util", "clear_player.mcfunction")
t = read(p)
line = "execute if score @s kitpvp.ench_slot matches 8 run bossbar set kitpvp:ench_hud_8 players\n"
assert line in t
if "kitpvp.ench_slot 0" not in t:
    t = t.replace(line, line + "scoreboard players set @s kitpvp.ench_slot 0\n")
write(p, t)

# 2) hud：每刻无条件清空 8 条观众，再按槽位重挂（人走了不会留条）
p = os.path.join(FN, "skill", "enchanter", "hud.mcfunction")
t = read(p)
for i in range(1, 9):
    old = "execute unless score #state kitpvp.game matches 1 run bossbar set kitpvp:ench_hud_%d players" % i
    assert old in t, old
    t = t.replace(old, "bossbar set kitpvp:ench_hud_%d players" % i)
write(p, t)
print("ok")