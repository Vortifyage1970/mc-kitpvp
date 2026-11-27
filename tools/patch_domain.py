import io, os, re

BASE = r"src/data/kitpvp/functions/skill/enchanter"

def read(p):
    with io.open(p, encoding="utf-8") as f:
        return f.read()

def write(p, s):
    with io.open(p, "w", encoding="utf-8", newline="\n") as f:
        f.write(s)

# 1. domain_cast：改成 advancement 驱动（书本没有可用的 "used" 统计，只能靠右键方块）
write(os.path.join(BASE, "domain_cast.mcfunction"), """# 右键方块时手持《神学大全》：领域展开·坐杀博徒（书本没有可检测的"使用"事件，只能走 item_used_on_block）
advancement revoke @s only kitpvp:player/ench_domain_cast
execute if entity @s[tag=kitpvp.ench_domain] run title @s actionbar {"text":"赌场已经开着了","color":"gray"}
execute unless entity @s[tag=kitpvp.ench_domain] if score @s kitpvp.ench_domain_ready matches 1.. run function kitpvp:skill/enchanter/domain_start
execute unless entity @s[tag=kitpvp.ench_domain] if score @s kitpvp.ench_domain_ready matches ..0 unless score @s kitpvp.ench_domain_cd matches 1.. run function kitpvp:skill/enchanter/domain_start
execute unless entity @s[tag=kitpvp.ench_domain] if score @s kitpvp.ench_domain_ready matches ..0 if score @s kitpvp.ench_domain_cd matches 1.. run title @s actionbar [{"text":"坐杀博徒冷却中：","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.ench_domain_cd"},"color":"white"},{"text":" 刻","color":"gray"}]
""")

# 2. 命中：常态不给蓄力，只有领域里抽卡
write(os.path.join(BASE, "ench_hit.mcfunction"), """# advancement：附魔师打中玩家。常态完全不能蓄力，只有坐杀博徒领域里才抽卡
advancement revoke @s only kitpvp:player/ench_hit
execute if score @s kitpvp.kit matches 15 if score @s kitpvp.alive matches 1 if entity @s[tag=kitpvp.ench_domain] run function kitpvp:skill/enchanter/domain_draw
execute if score @s kitpvp.kit matches 15 if score @s kitpvp.alive matches 1 unless entity @s[tag=kitpvp.ench_domain] run title @s actionbar {"text":"常态不能蓄力：右键方块展开坐杀博徒","color":"gray"}
""")

# 3. 挨打：领域内护甲进度 +0.2，领域外什么都不给
write(os.path.join(BASE, "ench_hurt.mcfunction"), """# advancement：附魔师被玩家打中。只有领域里才加护甲进度（+0.2 点）
advancement revoke @s only kitpvp:player/ench_hurt
execute if score @s kitpvp.kit matches 15 if score @s kitpvp.alive matches 1 if entity @s[tag=kitpvp.ench_domain] if score @s kitpvp.ench_armor matches ..10 if score @s kitpvp.ench_ap matches ..2 run scoreboard players add @s kitpvp.ench_ap_fill 60
execute if score @s kitpvp.kit matches 15 if score @s kitpvp.alive matches 1 if entity @s[tag=kitpvp.ench_domain] if score @s kitpvp.ench_ap matches ..2 if score @s kitpvp.ench_ap_fill matches 300.. run function kitpvp:skill/enchanter/fill_ap
""")

# 4. book_hold：去掉读书蓄力，只保留减速 / 闪烁发光 / 音效粒子 / 翻书
bh = read(os.path.join(BASE, "book_hold.mcfunction"))
lines = bh.split("\n")
keep = []
for ln in lines:
    if "ench_sw_fill" in ln or "ench_ap_fill" in ln or "book_p8" in ln:
        continue
    keep.append(ln)
bh = "\n".join(keep)
bh = re.sub(r"# 蓄力：[^\n]*\n", "", bh)
write(os.path.join(BASE, "book_hold.mcfunction"), bh)

# 5. tick：加冷却递减、蛋派发、领域 tick、临时强化计时
t = read(os.path.join(BASE, "tick.mcfunction"))
t = t.rstrip("\n") + """
# 坐杀博徒：冷却每刻 -1（只在对局里走）、领域里跑领域 tick、临时强化到点收掉
execute if score @s kitpvp.ench_domain_cd matches 1.. run scoreboard players remove @s kitpvp.ench_domain_cd 1
execute if entity @s[tag=kitpvp.ench_domain] run function kitpvp:skill/enchanter/domain_tick
execute if score @s kitpvp.ench_tmp matches 1.. run scoreboard players remove @s kitpvp.ench_tmp 1
execute if score @s kitpvp.ench_tmp matches ..0 if score @s kitpvp.ench_tmp_kind matches 1.. run function kitpvp:skill/enchanter/tmp_expire
# 赌徒之蛋：用掉一次就给下一次领域免冷却
execute if score @s kitpvp.ench_egg_used > @s kitpvp.ench_egg_last run function kitpvp:skill/enchanter/egg_cast
"""
write(os.path.join(BASE, "tick.mcfunction"), t)

# 6. load：补计分项
load_path = r"src/data/kitpvp/functions/load.mcfunction"
load = read(load_path)
add = """
# 附魔师·坐杀博徒（2026-11-28）
scoreboard objectives add kitpvp.ench_domain_t dummy "坐杀博徒剩余刻数（400 = 20 秒）"
scoreboard objectives add kitpvp.ench_domain_cd dummy "坐杀博徒冷却刻数（1000 = 50 秒）"
scoreboard objectives add kitpvp.ench_domain_ready dummy "赌徒之蛋：1 = 下一次领域不吃冷却"
scoreboard objectives add kitpvp.ench_egg_used minecraft.used:minecraft.turtle_spawn_egg
scoreboard objectives add kitpvp.ench_egg_last dummy "上一刻的赌徒之蛋使用次数"
scoreboard objectives add kitpvp.ench_tmp dummy "临时强化剩余刻数（利刃 200 / 锋锐 400）"
scoreboard objectives add kitpvp.ench_tmp_kind dummy "临时强化类型（3 = 攻击力修饰符）"
"""
if "kitpvp.ench_domain_t" not in load:
    load = load.rstrip("\n") + "\n" + add
write(load_path, load)

# 7. kit：选职业时把领域相关分数清零
kit_path = r"src/data/kitpvp/functions/kit/enchanter.mcfunction"
kit = read(kit_path)
add_kit = """scoreboard players set @s kitpvp.ench_domain_t 0
scoreboard players set @s kitpvp.ench_domain_cd 0
scoreboard players set @s kitpvp.ench_domain_ready 0
scoreboard players set @s kitpvp.ench_tmp 0
scoreboard players set @s kitpvp.ench_tmp_kind 0
"""
if "ench_domain_t" not in kit:
    kit = kit.rstrip("\n") + "\n" + add_kit
write(kit_path, kit)

# 8. advancement：右键方块 + 手持《神学大全》
adv = {
    "criteria": {
        "cast": {
            "trigger": "minecraft:item_used_on_block",
            "conditions": {
                "item": {"items": ["minecraft:book"], "nbt": "{KitBook:1b}"}
            }
        }
    },
    "rewards": {"function": "kitpvp:skill/enchanter/domain_cast"},
    "requirements": [["cast"]]
}
import json
p = r"src/data/kitpvp/advancements/player/ench_domain_cast.json"
os.makedirs(os.path.dirname(p), exist_ok=True)
with io.open(p, "w", encoding="utf-8", newline="\n") as f:
    json.dump(adv, f, ensure_ascii=False, indent=2)
    f.write("\n")
print("patched")
