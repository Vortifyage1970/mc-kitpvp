import io, os

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
FN = os.path.join(ROOT, 'src', 'data', 'kitpvp', 'functions')
ENCH = os.path.join(FN, 'skill', 'enchanter')


def read(p):
    with io.open(p, 'r', encoding='utf-8') as f:
        return f.read()


def write(p, s):
    with io.open(p, 'w', encoding='utf-8', newline='\n') as f:
        f.write(s)


# 1) 每刻真的调用强化计时（之前根本没调，所以条不动、也没强化）
p = os.path.join(FN, 'tick', 'earth.mcfunction')
t = read(p)
old = '# 附魔师（kit 98）：每刻走自己的强化计时\nfunction kitpvp:skill/enchanter/hud'
new = ('# 附魔师（kit 98）：每刻走自己的强化计时\n'
       'execute as @a[tag=kitpvp.selected,scores={kitpvp.kit=98,kitpvp.alive=1},tag=!kitpvp.spectator] run function kitpvp:skill/enchanter/tick\n'
       'function kitpvp:skill/enchanter/hud')
assert old in t
write(p, t.replace(old, new))

# 2) upgrade 里那个 bar 函数已经删了，换成改名字
p = os.path.join(ENCH, 'upgrade.mcfunction')
t = read(p)
assert 'function kitpvp:skill/enchanter/bar' in t
write(p, t.replace('function kitpvp:skill/enchanter/bar', 'function kitpvp:skill/enchanter/name_refresh'))

# 3) 穿装备时先刷一次名字
p = os.path.join(FN, 'kit', 'enchanter.mcfunction')
t = read(p)
old = 'function kitpvp:skill/enchanter/assign_slot'
assert old in t
write(p, t.replace(old, old + '\nfunction kitpvp:skill/enchanter/name_refresh'))

# 4) 生成名字刷新：8 个槽位 × 0..11 级
lines = ['# 让 bossbar 的标题显示当前附魔等级：8 槽 × 12 级，只在升级/穿上时调用']
for slot in range(1, 9):
    for lvl in range(0, 12):
        if lvl == 11:
            js = '{"text":"附魔等级：11(MAX)","bold":true}'
        else:
            js = '{"text":"附魔等级：%d"}' % lvl
        lines.append(
            'execute if score @s kitpvp.ench_slot matches %d if score @s kitpvp.ench_roll matches %d '
            'run bossbar set kitpvp:ench_hud_%d name %s' % (slot, lvl, slot, js))
write(os.path.join(ENCH, 'name_refresh.mcfunction'), '\n'.join(lines) + '\n')

# 5) 初始名字改成 附魔等级：0
p = os.path.join(FN, 'load.mcfunction')
t = read(p)
t = t.replace('{"text":"附魔蓄力","color":"light_purple"}', '{"text":"附魔等级：0","color":"light_purple"}')
write(p, t)

print('name_refresh lines:', len(lines) - 1)
