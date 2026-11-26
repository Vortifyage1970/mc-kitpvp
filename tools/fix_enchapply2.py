import io, os, re, glob

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
ENCH = os.path.join(ROOT, 'src', 'data', 'kitpvp', 'functions', 'skill', 'enchanter')
FN = os.path.join(ROOT, 'src', 'data', 'kitpvp', 'functions')

pat = re.compile(
    r'^execute unless data entity (\S+) ArmorItems\[3\]\.tag\.Enchantments\[\{id:"(minecraft:\w+)"\}\] '
    r'run data modify entity \S+ ArmorItems\[3\]\.tag\.Enchantments append value \{id:"minecraft:\w+",lvl:0s\}$')


def read(p):
    with io.open(p, 'r', encoding='utf-8') as f:
        return f.read()


def write(p, s):
    with io.open(p, 'w', encoding='utf-8', newline='\n') as f:
        f.write(s)


changed = 0
for p in sorted(glob.glob(os.path.join(ENCH, 'apply_*.mcfunction'))):
    lines = read(p).split('\n')
    out = []
    hit = False
    for ln in lines:
        m = pat.match(ln)
        if m:
            b, ench = m.group(1), m.group(2)
            # tag / Enchantments 可能都不存在，先补出来再 append，否则 append 会静默失败
            out.append('execute unless data entity %s ArmorItems[3].tag run data modify entity %s ArmorItems[3].tag set value {}' % (b, b))
            out.append('execute unless data entity %s ArmorItems[3].tag.Enchantments run data modify entity %s ArmorItems[3].tag.Enchantments set value []' % (b, b))
            out.append('execute unless data entity %s ArmorItems[3].tag.Enchantments[{id:"%s"}] run data modify entity %s ArmorItems[3].tag.Enchantments append value {id:"%s",lvl:0s}' % (b, ench, b, ench))
            hit = True
        else:
            out.append(ln)
    if hit:
        write(p, '\n'.join(out))
        changed += 1

print('patched', changed, 'files')

# ench_check：先把分数置 -1，读不到时不会显示上一次的旧值
p = os.path.join(FN, 'debug', 'ench_check.mcfunction')
t = read(p)
t = t.replace('# 打印附魔师的进度与两条关键附魔等级',
              '# 打印附魔师的进度与两条关键附魔等级（-1 = 没有这条附魔）')
t = t.replace('execute store result score #ench_chk1 kitpvp.game run data get entity @p Inventory[{Slot:103b}].tag.Enchantments[{id:"minecraft:protection"}].lvl',
              'scoreboard players set #ench_chk1 kitpvp.game -1\nexecute store result score #ench_chk1 kitpvp.game run data get entity @p Inventory[{Slot:103b}].tag.Enchantments[{id:"minecraft:protection"}].lvl')
t = t.replace('execute store result score #ench_chk2 kitpvp.game run data get entity @p Inventory[{Slot:0b}].tag.Enchantments[{id:"minecraft:sharpness"}].lvl',
              'scoreboard players set #ench_chk2 kitpvp.game -1\nexecute store result score #ench_chk2 kitpvp.game run data get entity @p Inventory[{Slot:0b}].tag.Enchantments[{id:"minecraft:sharpness"}].lvl')
write(p, t)
print('ench_check patched')
