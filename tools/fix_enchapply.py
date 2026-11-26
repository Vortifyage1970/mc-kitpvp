import io, os, re, glob

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
ENCH = os.path.join(ROOT, 'src', 'data', 'kitpvp', 'functions', 'skill', 'enchanter')
FN = os.path.join(ROOT, 'src', 'data', 'kitpvp', 'functions')

BENCH = '@e[tag=kitpvp.ench_bench,distance=..2,limit=1,sort=nearest]'
SLOTMAP = {'0b': 'hotbar.0', '103b': 'armor.head', '102b': 'armor.chest', '101b': 'armor.legs', '100b': 'armor.feet'}


def read(path):
    with io.open(path, 'r', encoding='utf-8') as f:
        return f.read()


def write(path, text):
    with io.open(path, 'w', encoding='utf-8', newline='\n') as f:
        f.write(text)


def convert(rel):
    path = os.path.join(FN, rel)
    t = read(path)

    # 1) 临时实体：物品 → 盔甲架（物品实体在 1.20.1 没有 contents 槽位）
    t = t.replace(
        'execute at @s run summon minecraft:item ~ ~ ~ {Tags:["kitpvp.ench_bench"],PickupDelay:32767s,Item:{id:"minecraft:stone",Count:1b}}',
        'execute at @s run summon minecraft:armor_stand ~ ~ ~ {Tags:["kitpvp.ench_bench"],Invisible:1b,NoGravity:1b,Invulnerable:1b}')
    # 兼容已经改过的写法
    t = re.sub(r'execute at @s run summon minecraft:item ~ ~ ~ \{Tags:\["kitpvp\.ench_bench"\][^\n]*\}',
               'execute at @s run summon minecraft:armor_stand ~ ~ ~ {Tags:["kitpvp.ench_bench"],Invisible:1b,NoGravity:1b,Invulnerable:1b}', t)

    # 2) 把玩家身上那件搬到盔甲架的 armor.head（item replace 是"移动"语义）
    def move_in(m):
        slot = SLOTMAP[m.group(1)]
        return 'item replace entity %s armor.head from entity @s %s' % (BENCH, slot)
    t = re.sub(r'data modify entity %s Item set from entity @s Inventory\[\{Slot:(\w+)\}\]' % re.escape(BENCH), move_in, t)

    # 3) NBT 路径：Item.tag -> ArmorItems[3].tag
    t = t.replace('] Item.tag.Enchantments', '] ArmorItems[3].tag.Enchantments')

    # 4) 搬回玩家身上
    def move_out(m):
        slot = m.group(1)
        return 'item replace entity @s %s from entity %s armor.head' % (slot, BENCH)
    t = re.sub(r'item replace entity @s (\S+) from entity %s contents' % re.escape(BENCH), move_out, t)

    t = t.replace('# 剑 上的', '# 剑 上的').replace('借一个临时物品实体做 NBT 手术', '借一个临时盔甲架做 NBT 手术')
    write(path, t)


for p in sorted(glob.glob(os.path.join(ENCH, 'apply_*.mcfunction'))):
    convert(os.path.relpath(p, FN))

# bossbar 只认 pink/blue/red/green/yellow/purple/white，没有 light_purple / gold
for rel in ('load.mcfunction', 'skill/enchanter/hud.mcfunction'):
    path = os.path.join(FN, rel)
    t = read(path)
    t = t.replace('bossbar set kitpvp:ench_hud', 'bossbar set kitpvp:ench_hud')
    t = re.sub(r'(bossbar set kitpvp:ench_hud_\d+) color light_purple', r'\1 color pink', t)
    t = re.sub(r'(bossbar set kitpvp:ench_hud_\d+) color gold', r'\1 color yellow', t)
    t = t.replace('{"text":"附魔蓄力","color":"light_purple"}', '{"text":"附魔蓄力","color":"light_purple"}')
    write(path, t)

print('converted', len(glob.glob(os.path.join(ENCH, 'apply_*.mcfunction'))), 'apply files')
