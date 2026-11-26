import io, os

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
DBG = os.path.join(ROOT, 'src', 'data', 'kitpvp', 'functions', 'debug')

HEAD = '''# {title}
# 用法（游戏内，站在想测的人身上执行）：/function kitpvp:debug/{name}
# 会先把你手上和身上的金剑金甲换成干净的（清掉已有附魔，剑会直接拿在手上），再补 {n} 次强化
execute unless score @s kitpvp.kit matches 98 run tellraw @s [{{"text":"[附魔师] ","color":"light_purple"}},{{"text":"你现在不是附魔师（kit 不是 98），先选这个职业再用","color":"red"}}]
execute if score @s kitpvp.kit matches 98 run tellraw @s [{{"text":"[附魔师] ","color":"light_purple"}},{{"text":"重置装备并补 {n_label} 次强化…","color":"gray"}}]
execute if score @s kitpvp.kit matches 98 run item replace entity @s weapon.mainhand with minecraft:golden_sword{{Unbreakable:1b,KitEnch:1b}}
execute if score @s kitpvp.kit matches 98 run item replace entity @s armor.head with minecraft:golden_helmet{{Unbreakable:1b,KitEnch:1b}}
execute if score @s kitpvp.kit matches 98 run item replace entity @s armor.chest with minecraft:golden_chestplate{{Unbreakable:1b,KitEnch:1b}}
execute if score @s kitpvp.kit matches 98 run item replace entity @s armor.legs with minecraft:golden_leggings{{Unbreakable:1b,KitEnch:1b}}
execute if score @s kitpvp.kit matches 98 run item replace entity @s armor.feet with minecraft:golden_boots{{Unbreakable:1b,KitEnch:1b}}
execute if score @s kitpvp.kit matches 98 run scoreboard players set @s kitpvp.ench_roll 0
execute if score @s kitpvp.kit matches 98 run scoreboard players set @s kitpvp.ench_pity 0
'''

UPGRADE = 'execute if score @s kitpvp.kit matches 98 run function kitpvp:skill/enchanter/upgrade\n'

TAIL = '''execute if score @s kitpvp.kit matches 98 run scoreboard players set @s kitpvp.ench_timer {timer}
execute if score @s kitpvp.kit matches 98 run scoreboard players set @s kitpvp.ench_period {timer}
execute if score @s kitpvp.kit matches 98 run function kitpvp:skill/enchanter/name_refresh
execute if score @s kitpvp.kit matches 98 run tellraw @s [{{"text":"[附魔师] ","color":"light_purple"}},{{"text":"{done}","color":"green"}}]
'''


def build(name, title, n, n_label, timer, done):
    body = HEAD.format(title=title, name=name, n=n, n_label=n_label) + UPGRADE * n
    body += TAIL.format(timer=timer, done=done)
    with io.open(os.path.join(DBG, name + '.mcfunction'), 'w', encoding='utf-8', newline='\n') as f:
        f.write(body)


build('ench_5min', '[测试] 附魔师：直接把面板推到 5 分钟（7 次强化）', 7, '7', 930,
      '已到 5 分钟面板（7 次强化），下一发 46.5 秒后')
build('ench_8min', '[测试] 附魔师：直接把面板推到 8 分钟封顶（11 次强化）', 11, '11', 1000000,
      '已到 8 分钟封顶（11 次强化，计时停表）')
print('ok')
