import io, os

F = r"src/data/kitpvp/functions"

def rd(p):
    with io.open(p, encoding="utf-8") as f:
        return f.read()

def wr(p, s):
    with io.open(p, "w", encoding="utf-8", newline="\n") as f:
        f.write(s)

# 1) 里·附魔师（kit 99）
wr(os.path.join(F, "kit", "tainted_enchanter.mcfunction"), """# 里·附魔师（kit = 99）：金套 + 金剑 + 坐杀博徒入场券；常态不能蓄力，全靠赌场抽卡
function kitpvp:util/clear_player
scoreboard players set @s kitpvp.kit 99
tag @s add kitpvp.selected

attribute @s minecraft:generic.max_health base set 20
attribute @s minecraft:generic.movement_speed base set 0.1

item replace entity @s armor.head with minecraft:golden_helmet{Unbreakable:1b,KitEnch:1b}
item replace entity @s armor.chest with minecraft:golden_chestplate{Unbreakable:1b,KitEnch:1b}
item replace entity @s armor.legs with minecraft:golden_leggings{Unbreakable:1b,KitEnch:1b}
item replace entity @s armor.feet with minecraft:golden_boots{Unbreakable:1b,KitEnch:1b}
item replace entity @s hotbar.0 with minecraft:golden_sword{Unbreakable:1b,KitEnch:1b}
item replace entity @s hotbar.1 with minecraft:cooked_beef 24
item replace entity @s hotbar.2 with minecraft:bat_spawn_egg{KitDomain:1b,Enchantments:[{id:"minecraft:unbreaking",lvl:1s}],display:{Name:'{"text":"坐杀博徒·入场券","color":"light_purple","italic":false}',Lore:['{"text":"右键使用：展开领域「坐杀博徒」","color":"gray","italic":false}','{"text":"60 秒赌场时间，每次命中抽一张卡","color":"dark_gray","italic":false}','{"text":"常态不能蓄力——赌场之外不会有任何进度","color":"dark_gray","italic":false}']}}

scoreboard players set @s kitpvp.ench_sw 0
scoreboard players set @s kitpvp.ench_ap 0
scoreboard players set @s kitpvp.ench_sword 0
scoreboard players set @s kitpvp.ench_armor 0
scoreboard players set @s kitpvp.ench_sw_fill 0
scoreboard players set @s kitpvp.ench_ap_fill 0
scoreboard players set @s kitpvp.ench_pity 0
scoreboard players set @s kitpvp.ench_hint 0
scoreboard players set @s kitpvp.ench_fx 0
scoreboard players set @s kitpvp.ench_domain_t 0
scoreboard players set @s kitpvp.ench_domain_cd 0
scoreboard players set @s kitpvp.ench_domain_ready 0
scoreboard players set @s kitpvp.ench_tmp 0
scoreboard players set @s kitpvp.ench_tmp_kind 0
tag @s remove kitpvp.ench_domain
tag @s remove kitpvp.ench_wait
execute as @e[tag=kitpvp.ench_bench] run kill @s
scoreboard players set @s kitpvp.ench_slot 0
function kitpvp:skill/li_ench/assign_slot
function kitpvp:skill/li_ench/name_refresh

tellraw @s [{"text":"已选择 ","color":"gray"},{"text":"里·附魔师","color":"dark_red","bold":true}]
tellraw @s [{"text":"常态不能蓄力：用「坐杀博徒·入场券」开场，60 秒内每次命中抽一张卡","color":"dark_gray"}]
tellraw @s [{"text":"抽卡涨剑/甲进度，3 点升 1 级，各 11 级封顶；冷却 60 秒","color":"dark_gray"}]
""")

# 2) 职业卡
wr(os.path.join(F, "kit", "info", "tainted_enchanter.mcfunction"), """tellraw @s [{"text":"┌──────────────────────────────","color":"dark_gray"}]
tellraw @s [{"text":"│ 职业名：","color":"gray"},{"text":"里·附魔师","color":"dark_red","bold":true}]
tellraw @s [{"text":"│ 分类：","color":"gray"},{"text":"经典（里）","color":"white"}]
tellraw @s [{"text":"│ 简介：","color":"gray"},{"text":"常态不能蓄力；开局展开赌场，靠抽卡越打越强","color":"white"}]
tellraw @s [{"text":"│ 武器单次伤害：","color":"gray"},{"text":"4","color":"gold","hoverEvent":{"action":"show_item","contents":{"id":"minecraft:golden_sword","Count":1}}},{"text":"（开局，之后靠锋利成长）","color":"dark_gray"}]
tellraw @s [{"text":"│ 武器攻击速度：","color":"gray"},{"text":"1.6","color":"gold"}]
tellraw @s [{"text":"│ 总护甲值：","color":"gray"},{"text":"11","color":"gold"}]
tellraw @s [{"text":"│ 头盔：","color":"gray"},{"text":"金头盔","color":"white","hoverEvent":{"action":"show_item","contents":{"id":"minecraft:golden_helmet","Count":1}}}]
tellraw @s [{"text":"│ 胸甲：","color":"gray"},{"text":"金胸甲","color":"white","hoverEvent":{"action":"show_item","contents":{"id":"minecraft:golden_chestplate","Count":1}}}]
tellraw @s [{"text":"│ 护腿：","color":"gray"},{"text":"金护腿","color":"white","hoverEvent":{"action":"show_item","contents":{"id":"minecraft:golden_leggings","Count":1}}}]
tellraw @s [{"text":"│ 靴子：","color":"gray"},{"text":"金靴子","color":"white","hoverEvent":{"action":"show_item","contents":{"id":"minecraft:golden_boots","Count":1}}}]
tellraw @s [{"text":"│ 物品：","color":"gray"},{"text":"熟牛肉 x","color":"white"},{"text":"24","color":"gold"},{"text":"、「坐杀博徒·入场券」","color":"white"}]
tellraw @s [{"text":"│ 技能：","color":"gray"},{"text":"坐杀博徒","color":"gold"},{"text":"：右键入场券展开 60 秒赌场，冷却 60 秒；每次命中抽一张卡（普通 70% / 稀有 25% / 传说 5%）","color":"white"}]
tellraw @s [{"text":"│ 常态：","color":"gray"},{"text":"完全不能蓄力——赌场之外打人、挨打都不涨进度","color":"white"}]
tellraw @s [{"text":"│ 成长：","color":"gray"},{"text":"剑、护甲各 3 点升 1 级，各 11 级封顶；8~11 级每次只升两件","color":"white"}]
tellraw @s [{"text":"│ 命数：","color":"gray"},{"text":"3","color":"gold"}]
tellraw @s [{"text":"└──────────────────────────────","color":"dark_gray"}]
tellraw @s [{"text":"[ 确认选择 ]","color":"green","bold":true,"clickEvent":{"action":"run_command","value":"/function kitpvp:kit/tainted_enchanter"},"hoverEvent":{"action":"show_text","contents":[{"text":"以里·附魔师参战","color":"gray"}]}},{"text":"  "},{"text":"[ 返回 ]","color":"yellow","clickEvent":{"action":"run_command","value":"/function kitpvp:lobby/menu"},"hoverEvent":{"action":"show_text","contents":[{"text":"回到主大厅菜单","color":"gray"}]}}]
""")

# 3) 列表入口
p = os.path.join(F, "kit", "list", "classic_tainted.mcfunction")
s = rd(p)
entry = 'tellraw @s [{"text":"[里·附魔师] ","color":"dark_green","bold":true,"clickEvent":{"action":"run_command","value":"/function kitpvp:kit/info/tainted_enchanter"},"hoverEvent":{"action":"show_text","contents":[{"text":"开局赌场、抽卡变强的赌徒","color":"gray"}]}},{"text":"开局赌场、抽卡变强的赌徒","color":"dark_gray"}]'
if "tainted_enchanter" not in s:
    s = s.rstrip("\n") + "\n" + entry
wr(p, s)

# 4) 发装备路由
p = os.path.join(F, "util", "give_kit.mcfunction")
s = rd(p)
if "matches 99" not in s:
    s = s.rstrip("\n") + "\nexecute if score @s kitpvp.kit matches 99 run function kitpvp:kit/tainted_enchanter\n"
wr(p, s)

# 5) 玩家级 tick（冷却 / 领域 / 临时强化 / 重开蛋）
wr(os.path.join(F, "skill", "li_ench", "player_tick.mcfunction"), """# 里·附魔师每刻：冷却递减、领域 tick、临时强化计时、赌徒之蛋派发
execute if score @s kitpvp.ench_domain_cd matches 1.. run scoreboard players remove @s kitpvp.ench_domain_cd 1
execute if entity @s[tag=kitpvp.ench_domain] run function kitpvp:skill/li_ench/tick_domain
execute if score @s kitpvp.ench_tmp matches 1.. run scoreboard players remove @s kitpvp.ench_tmp 1
execute if score @s kitpvp.ench_tmp matches ..0 if score @s kitpvp.ench_tmp_kind matches 1.. run function kitpvp:skill/li_ench/tmp_expire
execute if score @s kitpvp.ench_egg_used > @s kitpvp.ench_egg_last run function kitpvp:skill/li_ench/redraw
execute if score @s kitpvp.ench_domain_used > @s kitpvp.ench_domain_last run function kitpvp:skill/li_ench/cast
""")

# 6) tick/earth 接线
p = os.path.join(F, "tick", "earth.mcfunction")
s = rd(p)
if "li_ench/player_tick" not in s:
    s = s.rstrip("\n") + """
# 里·附魔师（kit 99）：坐杀博徒与双进度条
execute if score #state kitpvp.game matches 1 as @a[tag=kitpvp.selected,scores={kitpvp.kit=99,kitpvp.alive=1},tag=!kitpvp.spectator] at @s run function kitpvp:skill/li_ench/player_tick
function kitpvp:skill/li_ench/hud
"""
wr(p, s)

# 7) 命中/挨打分支（共用 advancement，按 kit 分派）
p = os.path.join(F, "skill", "enchanter", "ench_hit.mcfunction")
s = rd(p)
if "li_ench/draw" not in s:
    s = s.rstrip("\n") + """
# 里·附魔师（kit 99）：领域内抽卡，领域外什么都不涨
execute if score @s kitpvp.kit matches 99 if score @s kitpvp.alive matches 1 if entity @s[tag=kitpvp.ench_domain] run function kitpvp:skill/li_ench/draw
execute if score @s kitpvp.kit matches 99 if score @s kitpvp.alive matches 1 unless entity @s[tag=kitpvp.ench_domain] run title @s actionbar {"text":"常态不能蓄力：用「坐杀博徒·入场券」开赌场","color":"gray"}
"""
wr(p, s)

p = os.path.join(F, "skill", "enchanter", "ench_hurt.mcfunction")
s = rd(p)
if "li_ench" not in s:
    s = s.rstrip("\n") + """
# 里·附魔师（kit 99）：只有领域里挨打才加护甲进度
execute if score @s kitpvp.kit matches 99 if score @s kitpvp.alive matches 1 if entity @s[tag=kitpvp.ench_domain] if score @s kitpvp.ench_armor matches ..10 if score @s kitpvp.ench_ap matches ..2 run scoreboard players add @s kitpvp.ench_ap_fill 60
execute if score @s kitpvp.kit matches 99 if score @s kitpvp.alive matches 1 if entity @s[tag=kitpvp.ench_domain] if score @s kitpvp.ench_ap matches ..2 if score @s kitpvp.ench_ap_fill matches 300.. run function kitpvp:skill/enchanter/fill_ap
"""
wr(p, s)

# 8) load：补领域计分项 + 16 条进度条
p = os.path.join(F, "load.mcfunction")
s = rd(p)
add = """
# ===== 里·附魔师·坐杀博徒（2026-11-28）=====
scoreboard objectives add kitpvp.ench_domain_t dummy "坐杀博徒剩余刻数（1200 = 60 秒）"
scoreboard objectives add kitpvp.ench_domain_cd dummy "坐杀博徒冷却刻数（1200 = 60 秒）"
scoreboard objectives add kitpvp.ench_domain_ready dummy "赌徒之蛋：1 = 下一次领域不吃冷却"
scoreboard objectives add kitpvp.ench_domain_used minecraft.used:minecraft.bat_spawn_egg
scoreboard objectives add kitpvp.ench_domain_last dummy "上一刻的坐杀博徒入场券使用次数"
scoreboard objectives add kitpvp.ench_egg_used minecraft.used:minecraft.turtle_spawn_egg
scoreboard objectives add kitpvp.ench_egg_last dummy "上一刻的赌徒之蛋使用次数"
scoreboard objectives add kitpvp.ench_tmp dummy "临时强化剩余刻数（利刃 240 / 锋锐 400）"
scoreboard objectives add kitpvp.ench_tmp_kind dummy "临时强化类型（3 = 攻击力修饰符）"
"""
if "kitpvp.ench_domain_t" not in s:
    s = s.rstrip("\n") + "\n" + add
bars = []
for i in range(1, 9):
    bars.append('bossbar add kitpvp:ench_s%d {"text":"剑 · 附魔等级 0","color":"purple"}' % i)
    bars.append('bossbar set kitpvp:ench_s%d style progress' % i)
    bars.append('bossbar set kitpvp:ench_s%d max 900' % i)
    bars.append('bossbar set kitpvp:ench_s%d value 0' % i)
    bars.append('bossbar add kitpvp:ench_a%d {"text":"护甲 · 附魔等级 0","color":"blue"}' % i)
    bars.append('bossbar set kitpvp:ench_a%d style progress' % i)
    bars.append('bossbar set kitpvp:ench_a%d max 900' % i)
    bars.append('bossbar set kitpvp:ench_a%d value 0' % i)
if "bossbar add kitpvp:ench_s1" not in s:
    s = s.rstrip("\n") + "\n# 里·附魔师的双进度条（8 条槽 × 2）\n" + "\n".join(bars) + "\n"
wr(p, s)
print("li enchanter built")
