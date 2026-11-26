"""让"剑附魔"不再要求拿在手上：先找到剑在哪一格，临时换到主手，附完再换回去。

生成：
  skill/enchanter/sw_find.mcfunction      37 条"第 N 格有金剑就换进来"
  skill/enchanter/sw_in_*.mcfunction      换进主手 -> 掷附魔
  skill/enchanter/sw_out_*.mcfunction     换回原格
  skill/enchanter/sw_return.mcfunction    按 ench_sslot 分派回去
  skill/enchanter/sw_roll.mcfunction      真正的掷附魔（从 roll_sword 搬过来）
  skill/enchanter/roll_sword.mcfunction   改成"找剑 -> 掷"
"""
import io, os

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
SK = os.path.join(ROOT, 'src', 'data', 'kitpvp', 'functions', 'skill', 'enchanter')


def read(p):
    with io.open(p, 'r', encoding='utf-8') as f:
        return f.read()


def write(p, s):
    with io.open(p, 'w', encoding='utf-8', newline='\n') as f:
        f.write(s)


SLOTS = []
for i in range(9):
    SLOTS.append((i, 'hotbar.%d' % i))
for i in range(9, 36):
    SLOTS.append((i, 'inventory.%d' % (i - 9)))
SLOTS.append((-106, 'weapon.offhand'))

B = '@e[tag=kitpvp.sw_bench,limit=1,sort=nearest]'

find_lines = ['# 在主手以外的 37 个格子里找金剑，找到就交给 sw_in_<格子>']
in_blocks, out_blocks = {}, {}
for idx, (slotid, slot) in enumerate(SLOTS):
    k = idx + 1
    find_lines.append(
        'execute if score @s kitpvp.ench_sslot matches 0 '
        'if data entity @s Inventory[{Slot:%db,id:"minecraft:golden_sword"}] '
        'run function kitpvp:skill/enchanter/sw_in_%d' % (slotid, k))

    in_blocks[k] = (
        '# 把 %s 的金剑换到主手（手上原来拿着的东西先寄存在台子上）\n' % slot +
        'tag @s remove kitpvp.sw_hand\n'
        'execute at @s run summon minecraft:armor_stand ~ ~ ~ {Tags:["kitpvp.sw_bench"],Invisible:1b,NoGravity:1b,Invulnerable:1b}\n'
        'item replace entity %s armor.chest from entity @s %s\n' % (B, slot) +
        'execute if data entity @s SelectedItem run tag @s add kitpvp.sw_hand\n'
        'execute if entity @s[tag=kitpvp.sw_hand] run item replace entity %s armor.legs from entity @s weapon.mainhand\n' % B +
        'item replace entity @s weapon.mainhand from entity %s armor.chest\n' % B +
        'execute unless entity @s[tag=kitpvp.sw_hand] run item replace entity @s %s with minecraft:air\n' % slot +
        'execute if entity @s[tag=kitpvp.sw_hand] run item replace entity @s %s from entity %s armor.legs\n' % (slot, B) +
        'scoreboard players set @s kitpvp.ench_sslot %d\n' % k +
        'function kitpvp:skill/enchanter/sw_roll\n'
    )

    out_blocks[k] = (
        '# 把主手上的金剑换回 %s，手上恢复原来的东西，完事拆台子\n' % slot +
        'item replace entity %s armor.chest from entity @s weapon.mainhand\n' % B +
        'execute if entity @s[tag=kitpvp.sw_hand] run item replace entity @s weapon.mainhand from entity @s %s\n' % slot +
        'execute unless entity @s[tag=kitpvp.sw_hand] run item replace entity @s weapon.mainhand with minecraft:air\n' +
        'item replace entity @s %s from entity %s armor.chest\n' % (slot, B) +
        'kill @e[tag=kitpvp.sw_bench]\n' +
        'tag @s remove kitpvp.sw_hand\n'
    )

return_lines = ['# 附完把剑放回原格']
for k in range(1, len(SLOTS) + 1):
    return_lines.append('execute if score @s kitpvp.ench_sslot matches %d run function kitpvp:skill/enchanter/sw_out_%d' % (k, k))
return_lines.append('scoreboard players set @s kitpvp.ench_sslot 0')

old = read(os.path.join(ROOT, 'tools', 'roll_sword_orig.txt')).replace('\ufeff', '')
body = [l for l in old.split('\n') if l and not l.startswith('#')]
sw_roll = '# 真正掷一次剑附魔（调用前金剑必须已经在主手）\n' + '\n'.join(body) + '\nfunction kitpvp:skill/enchanter/sw_return\n'
write(os.path.join(SK, 'sw_roll.mcfunction'), sw_roll)

roll_sword = (
    '# 剑附魔入口：手上拿着就在手上附，没拿就先去背包里找\n'
    'scoreboard players set @s kitpvp.ench_sslot 0\n'
    'execute unless data entity @s SelectedItem{id:"minecraft:golden_sword"} run function kitpvp:skill/enchanter/sw_find\n'
    'execute if score @s kitpvp.ench_sslot matches 0 if data entity @s SelectedItem{id:"minecraft:golden_sword"} run function kitpvp:skill/enchanter/sw_roll\n'
)
write(os.path.join(SK, 'roll_sword.mcfunction'), roll_sword)
write(os.path.join(SK, 'sw_find.mcfunction'), '\n'.join(find_lines) + '\n')
write(os.path.join(SK, 'sw_return.mcfunction'), '\n'.join(return_lines) + '\n')
for k, block in in_blocks.items():
    write(os.path.join(SK, 'sw_in_%d.mcfunction' % k), block)
for k, block in out_blocks.items():
    write(os.path.join(SK, 'sw_out_%d.mcfunction' % k), block)
print('slots =', len(SLOTS))
