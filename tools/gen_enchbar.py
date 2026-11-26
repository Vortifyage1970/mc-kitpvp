import json, os, io

BASE = os.path.join('src', 'data', 'kitpvp', 'functions', 'skill', 'enchanter')
SEG = 20


def j(obj):
    return json.dumps(obj, ensure_ascii=False, separators=(',', ':'))


def line(n):
    filled = '▰' * n
    empty = '▱' * (SEG - n)
    parts = [
        {'text': '附魔 ', 'color': 'light_purple'},
        {'score': {'name': '@s', 'objective': 'kitpvp.ench_roll'}, 'color': 'gold'},
        {'text': '/11  ', 'color': 'dark_gray'},
    ]
    if filled:
        parts.append({'text': filled, 'color': 'aqua'})
    if empty:
        parts.append({'text': empty, 'color': 'dark_gray'})
    return 'execute if score #ench_p kitpvp.game matches %d run title @s actionbar %s' % (n, j(parts))


bar = [
    '# 附魔蓄力条：两发之间连续填充（20 格），满格就发一次',
    'execute if score @s kitpvp.ench_roll matches 11 run title @s actionbar ' + j([
        {'text': '附魔等级 ', 'color': 'light_purple'},
        {'text': '11', 'color': 'gold'},
        {'text': ' 级 ', 'color': 'white'},
        {'text': '▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰', 'color': 'gold'},
        {'text': '  MAX', 'color': 'gold', 'bold': True},
    ]),
    'execute if score @s kitpvp.ench_roll matches ..10 run function kitpvp:skill/enchanter/bar_charge',
]

charge = [
    '# 蓄力：已过刻数 / 总周期 * 20 = 格子数，格子变了才重画',
    'scoreboard players operation #ench_p kitpvp.game = @s kitpvp.ench_period',
    'scoreboard players operation #ench_p kitpvp.game -= @s kitpvp.ench_timer',
    'scoreboard players operation #ench_p kitpvp.game *= #ench_twenty kitpvp.game',
    'scoreboard players operation #ench_p kitpvp.game /= @s kitpvp.ench_period',
    'execute if score #ench_p kitpvp.game matches 21.. run scoreboard players set #ench_p kitpvp.game 20',
    'execute if score #ench_p kitpvp.game matches ..-1 run scoreboard players set #ench_p kitpvp.game 0',
    'execute unless score #ench_p kitpvp.game = @s kitpvp.ench_fill run function kitpvp:skill/enchanter/bar_draw',
]

draw = ['# 只在格子数变化时重画一次，避免每刻刷屏'] + \
       ['scoreboard players operation @s kitpvp.ench_fill = #ench_p kitpvp.game'] + \
       [line(n) for n in range(SEG + 1)]


def write(name, lines):
    path = os.path.join(BASE, name)
    with io.open(path, 'w', encoding='utf-8', newline='\n') as f:
        f.write('\n'.join(lines) + '\n')
    print(name, len(lines))


write('bar.mcfunction', bar)
write('bar_charge.mcfunction', charge)
write('bar_draw.mcfunction', draw)
