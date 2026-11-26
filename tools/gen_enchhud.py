import io, os, re

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
F = os.path.join(ROOT, 'src', 'data', 'kitpvp', 'functions')

SLOTS = range(1, 9)


def read(rel):
    with io.open(os.path.join(F, rel), 'r', encoding='utf-8') as f:
        return f.read()


def write(rel, text):
    path = os.path.join(F, rel)
    with io.open(path, 'w', encoding='utf-8', newline='\n') as f:
        f.write(text)


hud = ['# 附魔师 HUD：像汉堡小子那样，每人一条 bossbar 显示距离下一发的蓄力进度']
for n in SLOTS:
    hud.append('execute unless score #state kitpvp.game matches 1 run bossbar set kitpvp:ench_hud_%d players' % n)
for n in SLOTS:
    hud.append('execute if score #state kitpvp.game matches 1 as @a[scores={kitpvp.kit=98,kitpvp.ench_slot=%d}] run bossbar set kitpvp:ench_hud_%d players @s' % (n, n))
for n in SLOTS:
    hud.append('execute if score #state kitpvp.game matches 1 as @a[scores={kitpvp.kit=98,kitpvp.ench_slot=%d}] run execute store result bossbar kitpvp:ench_hud_%d value run scoreboard players get @s kitpvp.ench_pct' % (n, n))
for n in SLOTS:
    hud.append('execute as @a[scores={kitpvp.kit=98,kitpvp.ench_slot=%d,kitpvp.ench_roll=11}] run bossbar set kitpvp:ench_hud_%d color gold' % (n, n))
for n in SLOTS:
    hud.append('execute as @a[scores={kitpvp.kit=98,kitpvp.ench_slot=%d}] unless score @s kitpvp.ench_roll matches 11 run bossbar set kitpvp:ench_hud_%d color light_purple' % (n, n))
write('skill/enchanter/hud.mcfunction', '\n'.join(hud) + '\n')

assign = ['# 给附魔师分一条专属 bossbar 槽（1..8，取第一个没人占的）']
for n in SLOTS:
    assign.append('execute unless score @s kitpvp.ench_slot matches 1.. unless entity @a[scores={kitpvp.ench_slot=%d,kitpvp.kit=98}] run scoreboard players set @s kitpvp.ench_slot %d' % (n, n))
write('skill/enchanter/assign_slot.mcfunction', '\n'.join(assign) + '\n')

tick = [
    '# 附魔师计时：每刻 -1，到 0 就强化一次；同时算 bossbar 的 0..1000 进度',
    'scoreboard players remove @s kitpvp.ench_timer 1',
    'execute if score @s kitpvp.ench_timer matches ..0 run function kitpvp:skill/enchanter/upgrade',
    '',
    '# 进度 = (总周期 - 剩余) * 1000 / 总周期',
    'scoreboard players operation @s kitpvp.ench_pct = @s kitpvp.ench_period',
    'scoreboard players operation @s kitpvp.ench_pct -= @s kitpvp.ench_timer',
    'scoreboard players operation @s kitpvp.ench_pct *= #ench_thousand kitpvp.game',
    'scoreboard players operation @s kitpvp.ench_pct /= @s kitpvp.ench_period',
    'execute if score @s kitpvp.ench_roll matches 11 run scoreboard players set @s kitpvp.ench_pct 1000',
    'execute if score @s kitpvp.ench_pct matches 1001.. run scoreboard players set @s kitpvp.ench_pct 1000',
    'execute if score @s kitpvp.ench_pct matches ..-1 run scoreboard players set @s kitpvp.ench_pct 0',
]
write('skill/enchanter/tick.mcfunction', '\n'.join(tick) + '\n')

# kit: 选职业时分槽，不再画 actionbar
p = 'kit/enchanter.mcfunction'
t = read(p).replace('function kitpvp:skill/enchanter/bar', 'function kitpvp:skill/enchanter/assign_slot')
write(p, t)

# tick/earth: 改成调 hud
p = 'tick/earth.mcfunction'
t = read(p)
old = 'execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1,kitpvp.kit=98},tag=!kitpvp.spectator] run function kitpvp:skill/enchanter/tick'
assert old in t, 'enchanter call line not found'
t = t.replace(old, 'function kitpvp:skill/enchanter/hud')
write(p, t)

# load: 8 条 bossbar + 三个计分项/常量
p = 'load.mcfunction'
lines = read(p).split('\n')
out = []
inserted_hud = False
for ln in lines:
    out.append(ln)
    if ln.startswith('bossbar set kitpvp:burger_hud_8 value'):
        for n in SLOTS:
            out.append('bossbar add kitpvp:ench_hud_%d {"text":"附魔蓄力","color":"light_purple"}' % n)
            out.append('bossbar set kitpvp:ench_hud_%d color light_purple' % n)
            out.append('bossbar set kitpvp:ench_hud_%d style progress' % n)
            out.append('bossbar set kitpvp:ench_hud_%d max 1000' % n)
            out.append('bossbar set kitpvp:ench_hud_%d value 0' % n)
        inserted_hud = True
assert inserted_hud, 'burger hud anchor not found'

out2 = []
for ln in out:
    out2.append(ln)
    if ln.startswith('scoreboard players set #ench_twenty kitpvp.game 20'):
        out2.append('scoreboard players set #ench_thousand kitpvp.game 1000')
        out2.append('scoreboard objectives add kitpvp.ench_slot dummy "附魔师的 bossbar 槽（1..8）"')
        out2.append('scoreboard objectives add kitpvp.ench_pct dummy "附魔师蓄力进度（0..1000，给 bossbar 用）"')
write(p, '\n'.join(out2))

# clear_player: 换职业时把自己的条收掉
p = 'util/clear_player.mcfunction'
lines = read(p).split('\n')
out = []
done = False
for ln in lines:
    out.append(ln)
    if ln.startswith('execute if score @s kitpvp.burger_slot matches 8 run bossbar set kitpvp:burger_hud_8 players'):
        for n in SLOTS:
            out.append('execute if score @s kitpvp.ench_slot matches %d run bossbar set kitpvp:ench_hud_%d players' % (n, n))
        done = True
assert done, 'clear_player anchor not found'
write(p, '\n'.join(out))

# reset: 收全部
p = 'game/reset.mcfunction'
lines = read(p).split('\n')
out = []
done = False
for ln in lines:
    out.append(ln)
    if ln.strip() == 'bossbar set kitpvp:burger_hud_8 players':
        for n in SLOTS:
            out.append('bossbar set kitpvp:ench_hud_%d players' % n)
        done = True
assert done, 'reset anchor not found'
write(p, '\n'.join(out))

for f in ('bar.mcfunction', 'bar_charge.mcfunction', 'bar_draw.mcfunction'):
    path = os.path.join(F, 'skill', 'enchanter', f)
    if os.path.exists(path):
        os.remove(path)
        print('removed', f)

print('ok')
