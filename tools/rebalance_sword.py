import io, os

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
SK = os.path.join(ROOT, 'src', 'data', 'kitpvp', 'functions', 'skill', 'enchanter')


def read(p):
    with io.open(p, 'r', encoding='utf-8') as f:
        return f.read()


def write(p, s):
    with io.open(p, 'w', encoding='utf-8', newline='\n') as f:
        f.write(s)


# 1) 横扫之刃：照抄击退那套 NBT 手术，只换附魔 id 与播报文字
t = read(os.path.join(SK, 'apply_sword_knockback.mcfunction'))
t = t.replace('minecraft:knockback', 'minecraft:sweeping')
t = t.replace('剑 上的 knockback +1 级', '剑 上的 sweeping +1 级')
t = t.replace('{"text":"剑 · 击退 ","color":"gray"}', '{"text":"剑 · 横扫之刃 ","color":"gray"}')
write(os.path.join(SK, 'apply_sword_sweeping.mcfunction'), t)

# 2) 改区间：锋利 45 / 火焰 12 / 击退 22 / 横扫 12 / 亡灵 37（合计 128）
p = os.path.join(SK, 'sw_roll.mcfunction')
t = read(p)
t = t.replace('if score #ench_r kitpvp.game matches 45..63 run function kitpvp:skill/enchanter/apply_sword_fire_aspect',
              'if score #ench_r kitpvp.game matches 45..56 run function kitpvp:skill/enchanter/apply_sword_fire_aspect')
t = t.replace('if score #ench_r kitpvp.game matches 64..101 run function kitpvp:skill/enchanter/apply_sword_knockback',
              'if score #ench_r kitpvp.game matches 57..78 run function kitpvp:skill/enchanter/apply_sword_knockback')
old_smite = 'execute if data entity @s SelectedItem{id:"minecraft:golden_sword"} if score #ench_r kitpvp.game matches 102..127 run function kitpvp:skill/enchanter/apply_sword_smite'
assert old_smite in t
t = t.replace(old_smite,
              'execute if data entity @s SelectedItem{id:"minecraft:golden_sword"} if score #ench_r kitpvp.game matches 79..90 run function kitpvp:skill/enchanter/apply_sword_sweeping\n'
              'execute if data entity @s SelectedItem{id:"minecraft:golden_sword"} if score #ench_r kitpvp.game matches 91..127 run function kitpvp:skill/enchanter/apply_sword_smite')
t = t.replace('# 真正掷一次剑附魔（调用前金剑必须已经在主手）',
              '# 真正掷一次剑附魔（调用前金剑必须已经在主手）\n# 权重 128：锋利 45 / 火焰 12 / 击退 22 / 横扫之刃 12 / 亡灵杀手 37')
write(p, t)
print('ok')
