import io, os

F = r"src/data/kitpvp/functions/skill/enchanter"

def rd(p):
    with io.open(p, encoding="utf-8") as f:
        return f.read()

def wr(p, s):
    with io.open(p, "w", encoding="utf-8", newline="\n") as f:
        f.write(s)

# 领域 60 秒（1200 刻），冷却 60 秒（1200 刻）
p = os.path.join(F, "domain_start.mcfunction")
s = rd(p)
s = s.replace("scoreboard players set @s kitpvp.ench_domain_t 400", "scoreboard players set @s kitpvp.ench_domain_t 1200")
s = s.replace("scoreboard players set @s kitpvp.ench_domain_cd 1000", "scoreboard players set @s kitpvp.ench_domain_cd 1200")
s = s.replace("20 秒赌场时间（400 刻），冷却 50 秒（1000 刻）", "60 秒赌场时间（1200 刻），冷却 60 秒（1200 刻）")
s = s.replace('{"text":"坐杀博徒：20 秒，每次命中抽一张卡","color":"light_purple"}',
              '{"text":"坐杀博徒：60 秒，每次命中抽一张卡","color":"light_purple"}')
wr(p, s)

# 卡片数值：普通进度 0.2、稀有进度 0.5、buff 时长略加、冷却抵扣改 8 秒
CARD_EDITS = {
    "c02_str": [("effect give @s minecraft:strength 3 0 true", "effect give @s minecraft:strength 4 0 true"),
                ('{"text":"（3 秒）"', '{"text":"（4 秒）"')],
    "c03_spd": [("effect give @s minecraft:speed 5 1 true", "effect give @s minecraft:speed 6 1 true"),
                ('{"text":"（5 秒）"', '{"text":"（6 秒）"')],
    "c04_res": [("effect give @s minecraft:resistance 5 0 true", "effect give @s minecraft:resistance 6 0 true"),
                ('{"text":"（5 秒）"', '{"text":"（6 秒）"')],
    "c05_haste": [("effect give @s minecraft:haste 5 1 true", "effect give @s minecraft:haste 6 1 true"),
                  ('{"text":"（5 秒）"', '{"text":"（6 秒）"')],
    "c10_fine_sw": [("scoreboard players add @s kitpvp.ench_sw_fill 120", "scoreboard players add @s kitpvp.ench_sw_fill 150"),
                    ('{"text":"（剑进度 +0.4）"', '{"text":"（剑进度 +0.5）"')],
    "c11_fine_ap": [("scoreboard players add @s kitpvp.ench_ap_fill 120", "scoreboard players add @s kitpvp.ench_ap_fill 150"),
                    ('{"text":"（护甲进度 +0.4）"', '{"text":"（护甲进度 +0.5）"')],
    "c12_sharp3": [("scoreboard players set @s kitpvp.ench_tmp 200", "scoreboard players set @s kitpvp.ench_tmp 240"),
                   ("2 operation add", "2 operation add"),
                   ('{"text":"（锋利 +3 · 10 秒）"', '{"text":"（锋利 +3 · 12 秒）"')],
    "c13_prot2": [("effect give @s minecraft:resistance 10 1 true", "effect give @s minecraft:resistance 12 1 true"),
                  ('{"text":"（全套保护 +2 · 10 秒）"', '{"text":"（全套保护 +2 · 12 秒）"')],
    "c15_cd5s": [("scoreboard players remove @s kitpvp.ench_domain_cd 100", "scoreboard players remove @s kitpvp.ench_domain_cd 160"),
                 ('{"text":"（下次领域冷却 −5 秒）"', '{"text":"（下次领域冷却 −8 秒）"')],
    "c22_sharp5": [("scoreboard players set @s kitpvp.ench_tmp 400", "scoreboard players set @s kitpvp.ench_tmp 400")],
}

for name, pairs in CARD_EDITS.items():
    p = os.path.join(F, "card", name + ".mcfunction")
    s = rd(p)
    for a, b in pairs:
        s = s.replace(a, b)
    wr(p, s)

# 说明文案里的秒数
for name in ("c12_sharp3", "c13_prot2"):
    p = os.path.join(F, "card", name + ".mcfunction")
    s = rd(p)
    s = s.replace("# 利刃：攻击力 +2（等价锋利 III），10 秒", "# 利刃：攻击力 +2（等价锋利 III），12 秒")
    s = s.replace("# 铁壁：四件保护 +2 ≈ 抗性 II 40%，10 秒", "# 铁壁：四件保护 +2 ≈ 抗性 II 40%，12 秒")
    wr(p, s)

print("tuned")
