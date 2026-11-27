import io, os

def rd(p):
    with io.open(p, encoding="utf-8") as f:
        return f.read()

def wr(p, s):
    with io.open(p, "w", encoding="utf-8", newline="\n") as f:
        f.write(s)

F = r"src/data/kitpvp/functions"

# 1) 删除读书相关的全部文件名（书不再发放）
for n in ("book_hold", "book_passive", "book_fx", "book_page", "book_gain"):
    p = os.path.join(F, "skill", "enchanter", n + ".mcfunction")
    if os.path.exists(p):
        os.remove(p)

# 2) tick/earth：去掉 book_passive 调用
p = os.path.join(F, "tick", "earth.mcfunction")
s = rd(p)
s = "\n".join(ln for ln in s.split("\n") if "book_passive" not in ln)
wr(p, s)

# 3) 职业发放：把《神学大全》换成「坐杀博徒·入场券」刷怪蛋
p = os.path.join(F, "kit", "enchanter.mcfunction")
s = rd(p)
lines = []
for ln in s.split("\n"):
    if "minecraft:book{KitBook" in ln:
        lines.append('item replace entity @s hotbar.2 with minecraft:bat_spawn_egg{KitDomain:1b,Enchantments:[{id:"minecraft:unbreaking",lvl:1s}],display:{Name:\'{"text":"坐杀博徒·入场券","color":"light_purple","italic":false}\',Lore:[\'{"text":"右键使用：展开领域「坐杀博徒」","color":"gray","italic":false}\',\'{"text":"20 秒赌场时间，每次命中抽一张卡","color":"dark_gray","italic":false}\',\'{"text":"常态不能蓄力——赌场之外不会有任何进度","color":"dark_gray","italic":false}\']}}')
        continue
    lines.append(ln)
s = "\n".join(lines)
# 去掉读书计时相关的清零
s = "\n".join(ln for ln in s.split("\n") if "ench_book_t" not in ln and "ench_book_cd" not in ln)
wr(p, s)

# 4) 入场券：用掉 bat 蛋 → 判冷却 → 展开
wr(os.path.join(F, "skill", "enchanter", "domain_cast.mcfunction"), """# 右键「坐杀博徒·入场券」（蝙蝠蛋）：推进快照、清掉刷出来的蝙蝠，再判冷却开赌场
scoreboard players operation @s kitpvp.ench_domain_last = @s kitpvp.ench_domain_used
execute at @s run kill @e[type=minecraft:bat,distance=..8]
execute if entity @s[tag=kitpvp.ench_domain] run title @s actionbar {"text":"赌场已经开着了","color":"gray"}
execute unless entity @s[tag=kitpvp.ench_domain] if score @s kitpvp.ench_domain_cd matches ..0 run function kitpvp:skill/enchanter/domain_start
execute unless entity @s[tag=kitpvp.ench_domain] if score @s kitpvp.ench_domain_cd matches 1.. run title @s actionbar [{"text":"坐杀博徒冷却中：","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.ench_domain_cd"},"color":"white"},{"text":" 刻","color":"gray"}]
""")

# 5) tick：加入场券派发
p = os.path.join(F, "skill", "enchanter", "tick.mcfunction")
s = rd(p)
if "ench_domain_used" not in s:
    s = s.rstrip("\n") + """
# 坐杀博徒·入场券：用掉一次就展开（同魂石的写法）
execute if score @s kitpvp.ench_domain_used > @s kitpvp.ench_domain_last run function kitpvp:skill/enchanter/domain_cast
"""
wr(p, s)

# 6) load：补入场券的统计项
p = os.path.join(F, "load.mcfunction")
s = rd(p)
add = """scoreboard objectives add kitpvp.ench_domain_used minecraft.used:minecraft.bat_spawn_egg
scoreboard objectives add kitpvp.ench_domain_last dummy "上一刻的坐杀博徒入场券使用次数"
"""
if "ench_domain_used" not in s:
    s = s.rstrip("\n") + "\n" + add
wr(p, s)

# 7) 职业卡文案：书 → 入场券
p = os.path.join(F, "kit", "info", "enchanter.mcfunction")
s = rd(p)
s = s.replace('、《神学大全》', '、「坐杀博徒·入场券」')
s = s.replace(
    '{"text":"《神学大全》","color":"gold"},{"text":"（主手）：移速 -30%、每 2 秒闪一次；右键方块展开「坐杀博徒」","color":"white"}',
    '{"text":"坐杀博徒·入场券","color":"gold"},{"text":"：右键使用，展开 20 秒赌场（冷却 50 秒）","color":"white"}')
s = s.replace(
    '{"text":"常态不涨进度；只有「坐杀博徒」领域里，打人抽剑卡、被打涨护甲进度（3 点升 1 级，各 11 级封顶）","color":"white"}',
    '{"text":"常态不涨进度；只有赌场里，打人抽卡、被打涨护甲进度（3 点升 1 级，各 11 级封顶）","color":"white"}')
wr(p, s)

# 8) ench_hit 提示文案
p = os.path.join(F, "skill", "enchanter", "ench_hit.mcfunction")
s = rd(p)
s = s.replace('{"text":"常态不能蓄力：右键方块展开坐杀博徒","color":"gray"}',
              '{"text":"常态不能蓄力：用「坐杀博徒·入场券」开赌场","color":"gray"}')
wr(p, s)

print("egg version ready")
