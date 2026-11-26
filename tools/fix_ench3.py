import io, os, glob

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
FN = os.path.join(ROOT, 'src', 'data', 'kitpvp', 'functions')
ENCH = os.path.join(FN, 'skill', 'enchanter')


def read(p):
    with io.open(p, 'r', encoding='utf-8') as f:
        return f.read()


def write(p, s):
    with io.open(p, 'w', encoding='utf-8', newline='\n') as f:
        f.write(s)


# 1) 每条 [附魔] 播报前面加一个空行，连着出两条时不会粘在一起
n = 0
for p in sorted(glob.glob(os.path.join(ENCH, 'apply_*.mcfunction'))):
    t = read(p)
    if '{"text":"[附魔] ' in t:
        t = t.replace('{"text":"[附魔] ', '{"text":"\\n[附魔] ')
        write(p, t)
        n += 1

# 2) tick/earth 里的调用补 at @s：apply 里用 distance=..2 找临时架子，没有 at @s 时距离基准是世界出生点
p = os.path.join(FN, 'tick', 'earth.mcfunction')
t = read(p)
old = 'execute as @a[tag=kitpvp.selected,scores={kitpvp.kit=98,kitpvp.alive=1},tag=!kitpvp.spectator] run function kitpvp:skill/enchanter/tick'
new = 'execute as @a[tag=kitpvp.selected,scores={kitpvp.kit=98,kitpvp.alive=1},tag=!kitpvp.spectator] at @s run function kitpvp:skill/enchanter/tick'
if old in t:
    t = t.replace(old, new)
    write(p, t)
    print('tick call gets at @s')

# 3) 分步自检：哪一步断了就问出来
steps = '''# 分步自检：0 = 那一步没成功，1 = 成功
kill @e[tag=kitpvp.ench_bench]
scoreboard players set #s1 kitpvp.game 0
execute if data entity @s Inventory[{Slot:0b}].tag.KitEnch run scoreboard players set #s1 kitpvp.game 1
execute at @s run summon minecraft:armor_stand ~ ~ ~ {Tags:["kitpvp.ench_bench"],Invisible:1b,NoGravity:1b,Invulnerable:1b}
scoreboard players set #s2 kitpvp.game 0
execute if entity @e[tag=kitpvp.ench_bench,distance=..2] run scoreboard players set #s2 kitpvp.game 1
item replace entity @e[tag=kitpvp.ench_bench,distance=..2,limit=1,sort=nearest] armor.head from entity @s hotbar.0
scoreboard players set #s3 kitpvp.game 0
execute if data entity @e[tag=kitpvp.ench_bench,distance=..2,limit=1,sort=nearest] ArmorItems[3].tag.KitEnch run scoreboard players set #s3 kitpvp.game 1
execute unless data entity @e[tag=kitpvp.ench_bench,distance=..2,limit=1,sort=nearest] ArmorItems[3].tag run data modify entity @e[tag=kitpvp.ench_bench,distance=..2,limit=1,sort=nearest] ArmorItems[3].tag set value {}
execute unless data entity @e[tag=kitpvp.ench_bench,distance=..2,limit=1,sort=nearest] ArmorItems[3].tag.Enchantments run data modify entity @e[tag=kitpvp.ench_bench,distance=..2,limit=1,sort=nearest] ArmorItems[3].tag.Enchantments set value []
execute unless data entity @e[tag=kitpvp.ench_bench,distance=..2,limit=1,sort=nearest] ArmorItems[3].tag.Enchantments[{id:"minecraft:sharpness"}] run data modify entity @e[tag=kitpvp.ench_bench,distance=..2,limit=1,sort=nearest] ArmorItems[3].tag.Enchantments append value {id:"minecraft:sharpness",lvl:0s}
scoreboard players set #s4 kitpvp.game 0
execute if data entity @e[tag=kitpvp.ench_bench,distance=..2,limit=1,sort=nearest] ArmorItems[3].tag.Enchantments[{id:"minecraft:sharpness",lvl:0s}] run scoreboard players set #s4 kitpvp.game 1
item replace entity @s hotbar.0 from entity @e[tag=kitpvp.ench_bench,distance=..2,limit=1,sort=nearest] armor.head
scoreboard players set #s5 kitpvp.game 0
execute if data entity @s Inventory[{Slot:0b}].tag.Enchantments[{id:"minecraft:sharpness"}] run scoreboard players set #s5 kitpvp.game 1
kill @e[tag=kitpvp.ench_bench]
tellraw @a [{"text":"[附魔自检] ","color":"light_purple"},{"text":"剑在(1)=","color":"gray"},{"score":{"name":"#s1","objective":"kitpvp.game"}},{"text":" 架子出来(2)=","color":"gray"},{"score":{"name":"#s2","objective":"kitpvp.game"}},{"text":" 搬进架子(3)=","color":"gray"},{"score":{"name":"#s3","objective":"kitpvp.game"}},{"text":" 列表追加(4)=","color":"gray"},{"score":{"name":"#s4","objective":"kitpvp.game"}},{"text":" 搬回身上(5)=","color":"gray"},{"score":{"name":"#s5","objective":"kitpvp.game"}}]
'''
write(os.path.join(FN, 'debug', 'ench_steps.mcfunction'), steps)

print('newline patched', n, 'files')
