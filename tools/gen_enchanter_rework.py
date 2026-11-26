# -*- coding: utf-8 -*-
"""把附魔师从"按时间自动蓄力"改成"命中充剑 / 挨打充甲 + 手持《神学大全》缓慢双充"。

产物：
  kit/enchanter.mcfunction
  skill/enchanter/{tick,hud,name_refresh,book_hold,book_page,book_gain,ench_check,
                   gain_sword,gain_armor,up_sword,up_armor,ench_hit,ench_hurt}.mcfunction
  删除 skill/enchanter/upgrade.mcfunction
  改写 load.mcfunction 的 bossbar 段与 objective 段
  改写 game/reset.mcfunction、util/clear_player.mcfunction 里的收条段
  改写 debug/ench_5min / ench_8min / ench_check
  新增 advancements/player/{ench_hit,ench_hurt}.json
"""
import io, json, os, re

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
FN = os.path.join(ROOT, 'src', 'data', 'kitpvp', 'functions')
SK = os.path.join(FN, 'skill', 'enchanter')
ADV = os.path.join(ROOT, 'src', 'data', 'kitpvp', 'advancements', 'player')


def w(path, text):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with io.open(path, 'w', encoding='utf-8', newline='\n') as f:
        f.write(text if text.endswith('\n') else text + '\n')


def rd(path):
    with io.open(path, 'r', encoding='utf-8') as f:
        return f.read()


SLOTS = range(1, 9)
NEED = 3
MAXLV = 11


# ---------------------------------------------------------------- kit
w(os.path.join(FN, 'kit', 'enchanter.mcfunction'), """# 附魔师（kit = 98）：金套 + 金剑 + 《神学大全》
# 剑的附魔靠"命中玩家"充能，护甲的靠"被玩家打中"充能；书是慢速双充的替代手段
function kitpvp:util/clear_player
scoreboard players set @s kitpvp.kit 98
tag @s add kitpvp.selected

scoreboard players set @s kitpvp.alive 1
scoreboard players set @s kitpvp.lives 3

attribute @s minecraft:generic.max_health base set 20
attribute @s minecraft:generic.movement_speed base set 0.1

item replace entity @s armor.head with minecraft:golden_helmet{Unbreakable:1b,KitEnch:1b}
item replace entity @s armor.chest with minecraft:golden_chestplate{Unbreakable:1b,KitEnch:1b}
item replace entity @s armor.legs with minecraft:golden_leggings{Unbreakable:1b,KitEnch:1b}
item replace entity @s armor.feet with minecraft:golden_boots{Unbreakable:1b,KitEnch:1b}
item replace entity @s hotbar.0 with minecraft:golden_sword{Unbreakable:1b,KitEnch:1b}
item replace entity @s hotbar.1 with minecraft:cooked_beef 24
item replace entity @s hotbar.2 with minecraft:book{KitBook:1b,display:{Name:'{"text":"《神学大全》","color":"gold","italic":false}',Lore:['{"text":"拿在主手时：移速 -30%、身上发光","color":"gray","italic":false}','{"text":"每 15 秒给剑和护甲各 +1 点蓄力","color":"dark_gray","italic":false}']}}

scoreboard players set @s kitpvp.ench_sw 0
scoreboard players set @s kitpvp.ench_ap 0
scoreboard players set @s kitpvp.ench_sword 0
scoreboard players set @s kitpvp.ench_armor 0
scoreboard players set @s kitpvp.ench_book_t 0
scoreboard players set @s kitpvp.ench_book_cd 0
scoreboard players set @s kitpvp.ench_pity 0
execute as @e[tag=kitpvp.ench_bench] run kill @s
function kitpvp:skill/enchanter/assign_slot
function kitpvp:skill/enchanter/name_refresh

tellraw @s [{"text":"已选择 ","color":"gray"},{"text":"附魔师","color":"light_purple","bold":true}]
tellraw @s [{"text":"打中人 → 剑附魔充能；被打中 → 护甲附魔充能（各 3 点升 1 级）","color":"dark_gray"}]
tellraw @s [{"text":"《神学大全》拿在主手：移速 -30%、发光，每 15 秒给两条各 +1 点","color":"dark_gray"}]
""")

# ---------------------------------------------------------------- tick / book
w(os.path.join(SK, 'tick.mcfunction'), """# 附魔师每刻：只有"手里拿着《神学大全》"这一条被动要走时间
execute if data entity @s SelectedItem{KitBook:1b} run function kitpvp:skill/enchanter/book_hold
""")

w(os.path.join(SK, 'book_hold.mcfunction'), """# 主手拿着《神学大全》：减速 30% + 发光 + 翻书声 + 每 300 刻给两条各 +1 点
effect give @s minecraft:slowness 1 1 true
effect give @s minecraft:glowing 1 0 true
scoreboard players add @s kitpvp.ench_book_t 1
scoreboard players add @s kitpvp.ench_book_cd 1
execute if score @s kitpvp.ench_book_t matches 300.. run function kitpvp:skill/enchanter/book_gain
execute if score @s kitpvp.ench_book_cd matches 40.. run function kitpvp:skill/enchanter/book_page
""")

w(os.path.join(SK, 'book_gain.mcfunction'), """# 读了 15 秒：两条各 +1 点，并重置读书计时
scoreboard players set @s kitpvp.ench_book_t 0
playsound minecraft:block.enchantment_table.use master @s ~ ~ ~ 0.5 1.6
particle minecraft:enchant ~ ~1 ~ 0.4 0.6 0.4 0.2 12
scoreboard players add @s kitpvp.ench_sw 1
scoreboard players add @s kitpvp.ench_ap 1
function kitpvp:skill/enchanter/ench_check
""")

w(os.path.join(SK, 'book_page.mcfunction'), """# 每 2 秒一声翻书
scoreboard players set @s kitpvp.ench_book_cd 0
playsound minecraft:item.book.page_turn master @s ~ ~ ~ 0.7 1.2
""")

# ---------------------------------------------------------------- charge sources
w(os.path.join(SK, 'ench_hit.mcfunction'), """# advancement：附魔师用武器打中了玩家
advancement revoke @s only kitpvp:player/ench_hit
execute unless score @s kitpvp.kit matches 98 run return fail
execute unless score @s kitpvp.alive matches 1 run return fail
scoreboard players add @s kitpvp.ench_sw 1
playsound minecraft:block.note_block.chime master @s ~ ~ ~ 0.35 1.9
function kitpvp:skill/enchanter/ench_check
""")

w(os.path.join(SK, 'ench_hurt.mcfunction'), """# advancement：附魔师被玩家打中
advancement revoke @s only kitpvp:player/ench_hurt
execute unless score @s kitpvp.kit matches 98 run return fail
execute unless score @s kitpvp.alive matches 1 run return fail
scoreboard players add @s kitpvp.ench_ap 1
playsound minecraft:block.note_block.chime master @s ~ ~ ~ 0.35 1.4
function kitpvp:skill/enchanter/ench_check
""")

w(os.path.join(SK, 'ench_check.mcfunction'), """# 任何来源加了蓄力之后都走这里：满了就升一级
execute if score @s kitpvp.ench_sw matches 3.. run function kitpvp:skill/enchanter/up_sword
execute if score @s kitpvp.ench_ap matches 3.. run function kitpvp:skill/enchanter/up_armor
""")

w(os.path.join(SK, 'up_sword.mcfunction'), """# 剑升一级：扣 3 点蓄力、等级 +1、掷一次剑附魔
scoreboard players remove @s kitpvp.ench_sw 3
scoreboard players add @s kitpvp.ench_sword 1
execute if score @s kitpvp.ench_sword matches 0.. run function kitpvp:skill/enchanter/roll_sword
execute if score @s kitpvp.ench_sword matches 11.. run scoreboard players set @s kitpvp.ench_sw 3
effect give @s minecraft:glowing 5 0 true
playsound minecraft:entity.player.levelup master @s ~ ~ ~ 0.5 1.6
tellraw @s [{"text":"\\n[附魔师] ","color":"light_purple"},{"text":"剑附魔升到 ","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.ench_sword"}},{"text":" 级","color":"white"}]
function kitpvp:skill/enchanter/name_refresh
""")

w(os.path.join(SK, 'up_armor.mcfunction'), """# 护甲升一级：扣 3 点蓄力、等级 +1、按等级掷护甲
scoreboard players remove @s kitpvp.ench_ap 3
scoreboard players add @s kitpvp.ench_armor 1
execute if score @s kitpvp.ench_armor matches ..7 run function kitpvp:skill/enchanter/roll_all_armor
execute if score @s kitpvp.ench_armor matches 8 run function kitpvp:skill/enchanter/roll_head_chest
execute if score @s kitpvp.ench_armor matches 9 run function kitpvp:skill/enchanter/roll_legs_feet
execute if score @s kitpvp.ench_armor matches 10 run function kitpvp:skill/enchanter/roll_head_legs
execute if score @s kitpvp.ench_armor matches 11 run function kitpvp:skill/enchanter/roll_chest_feet
execute if score @s kitpvp.ench_armor matches 11.. run scoreboard players set @s kitpvp.ench_ap 3
effect give @s minecraft:glowing 5 0 true
playsound minecraft:entity.player.levelup master @s ~ ~ ~ 0.5 1.2
tellraw @s [{"text":"\\n[附魔师] ","color":"light_purple"},{"text":"护甲附魔升到 ","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.ench_armor"}},{"text":" 级","color":"white"}]
function kitpvp:skill/enchanter/name_refresh
""")

# ---------------------------------------------------------------- hud
L = []
L.append('# 附魔师 HUD：每人两条 bossbar（剑 / 护甲），值 0..3 就是这一级的蓄力点数')
for i in SLOTS:
    L.append('bossbar set kitpvp:ench_s%d players' % i)
    L.append('bossbar set kitpvp:ench_a%d players' % i)
L.append('execute if score #state kitpvp.game matches 1 as @a[scores={kitpvp.kit=98}] run function kitpvp:skill/enchanter/hud_show')
w(os.path.join(SK, 'hud.mcfunction'), '\n'.join(L))

H = []
for i in SLOTS:
    H.append('execute if score @s kitpvp.ench_slot matches %d run bossbar set kitpvp:ench_s%d players @s' % (i, i))
    H.append('execute if score @s kitpvp.ench_slot matches %d run bossbar set kitpvp:ench_a%d players @s' % (i, i))
for i in SLOTS:
    H.append('execute if score @s kitpvp.ench_slot matches %d run execute store result bossbar kitpvp:ench_s%d value run scoreboard players get @s kitpvp.ench_sw' % (i, i))
    H.append('execute if score @s kitpvp.ench_slot matches %d run execute store result bossbar kitpvp:ench_a%d value run scoreboard players get @s kitpvp.ench_ap' % (i, i))
for i in SLOTS:
    H.append('execute if score @s kitpvp.ench_slot matches %d run bossbar set kitpvp:ench_s%d color purple' % (i, i))
    H.append('execute if score @s kitpvp.ench_slot matches %d run bossbar set kitpvp:ench_a%d color blue' % (i, i))
for i in SLOTS:
    H.append('execute if score @s kitpvp.ench_slot matches %d if score @s kitpvp.ench_sword matches 11.. run bossbar set kitpvp:ench_s%d color yellow' % (i, i))
    H.append('execute if score @s kitpvp.ench_slot matches %d if score @s kitpvp.ench_armor matches 11.. run bossbar set kitpvp:ench_a%d color yellow' % (i, i))
w(os.path.join(SK, 'hud_show.mcfunction'), '\n'.join(H))

N = []
for i in SLOTS:
    for lv in range(0, MAXLV + 1):
        title = '剑附魔 Lv %d' % lv
        if lv == MAXLV:
            title = '剑附魔 11（满）'
        N.append('execute if score @s kitpvp.ench_slot matches %d if score @s kitpvp.ench_sword matches %d run bossbar set kitpvp:ench_s%d name {"text":"%s"}' % (i, lv, i, title))
for i in SLOTS:
    for lv in range(0, MAXLV + 1):
        title = '护甲附魔 Lv %d' % lv
        if lv == MAXLV:
            title = '护甲附魔 11（满）'
        N.append('execute if score @s kitpvp.ench_slot matches %d if score @s kitpvp.ench_armor matches %d run bossbar set kitpvp:ench_a%d name {"text":"%s"}' % (i, lv, i, title))
w(os.path.join(SK, 'name_refresh.mcfunction'), '\n'.join(N))

# ---------------------------------------------------------------- load.mcfunction
load_path = os.path.join(FN, 'load.mcfunction')
lines = rd(load_path).split('\n')
start = next(i for i, l in enumerate(lines) if l.startswith('bossbar add kitpvp:ench_hud_1'))
end = next(i for i, l in enumerate(lines) if l.startswith('bossbar set kitpvp:ench_hud_8 value'))
bar = []
for i in SLOTS:
    bar.append('bossbar add kitpvp:ench_s%d {"text":"剑附魔 Lv 0","color":"purple"}' % i)
    bar.append('bossbar set kitpvp:ench_s%d name {"text":"剑附魔 Lv 0","color":"purple"}' % i)
    bar.append('bossbar set kitpvp:ench_s%d color purple' % i)
    bar.append('bossbar set kitpvp:ench_s%d style progress' % i)
    bar.append('bossbar set kitpvp:ench_s%d max 3' % i)
    bar.append('bossbar set kitpvp:ench_s%d value 0' % i)
for i in SLOTS:
    bar.append('bossbar add kitpvp:ench_a%d {"text":"护甲附魔 Lv 0","color":"blue"}' % i)
    bar.append('bossbar set kitpvp:ench_a%d name {"text":"护甲附魔 Lv 0","color":"blue"}' % i)
    bar.append('bossbar set kitpvp:ench_a%d color blue' % i)
    bar.append('bossbar set kitpvp:ench_a%d style progress' % i)
    bar.append('bossbar set kitpvp:ench_a%d max 3' % i)
    bar.append('bossbar set kitpvp:ench_a%d value 0' % i)
lines[start:end + 1] = bar

obj_start = next(i for i, l in enumerate(lines) if l.startswith('scoreboard objectives add kitpvp.ench_roll'))
obj_end = next(i for i, l in enumerate(lines) if l.startswith('scoreboard objectives add kitpvp.ench_sslot'))
obj = [
    'scoreboard objectives add kitpvp.ench_sw dummy "剑附魔的蓄力（打中玩家 +1，满 3 升 1 级）"',
    'scoreboard objectives add kitpvp.ench_ap dummy "护甲附魔的蓄力（被玩家打中 +1，满 3 升 1 级）"',
    'scoreboard objectives add kitpvp.ench_sword dummy "剑附魔等级（0..11）"',
    'scoreboard objectives add kitpvp.ench_armor dummy "护甲附魔等级（0..11）"',
    'scoreboard objectives add kitpvp.ench_book_t dummy "手持《神学大全》读了几刻（300 刻给 1 点）"',
    'scoreboard objectives add kitpvp.ench_book_cd dummy "翻书声的间隔计时"',
    'scoreboard objectives add kitpvp.ench_pity dummy "附魔师连续没出锋利的次数（3 次后保底）"',
    'scoreboard objectives add kitpvp.ench_lv dummy "这一次附魔做完后的等级（给聊天栏播报用）"',
    'scoreboard objectives add kitpvp.ench_slot dummy "附魔师的 bossbar 槽（1..8）"',
    'scoreboard players set #ench_need kitpvp.game 3',
    'scoreboard players set #ench_eight kitpvp.game 8',
    'scoreboard players set #ench_one kitpvp.game 1',
    'scoreboard objectives add kitpvp.ench_sslot dummy "剑找到了第几个格子（0 = 还在主手，1..37 = 已临时换进主手）"',
]
lines[obj_start:obj_end + 1] = obj
w(load_path, '\n'.join(lines))

# ---------------------------------------------------------------- reset / clear_player
def replace_bars(path, old_prefix):
    t = rd(path)
    pat = re.compile(r'^( *)bossbar set kitpvp:' + old_prefix + r'_\d+ players\n(\1scoreboard players set @s kitpvp.ench_slot 0\n)?', re.M)
    stops = [l for l in t.split('\n') if l.strip().startswith('bossbar set kitpvp:ench_hud_')]
    if not stops:
        return False
    new = []
    for i in SLOTS:
        new.append('bossbar set kitpvp:ench_s%d players' % i)
        new.append('bossbar set kitpvp:ench_a%d players' % i)
    out = [l for l in t.split('\n') if not l.strip().startswith('bossbar set kitpvp:ench_hud_')]
    # 插回原位置：放在最后一次出现的位置
    idx = max(i for i, l in enumerate(t.split('\n')) if 'bossbar set kitpvp:ench_hud_' in l) - len(stops) + 1
    out[idx:idx] = new
    w(path, '\n'.join(out))
    return True


replace_bars(os.path.join(FN, 'game', 'reset.mcfunction'), 'ench_hud')
replace_bars(os.path.join(FN, 'util', 'clear_player.mcfunction'), 'ench_hud')

# ---------------------------------------------------------------- debug
w(os.path.join(FN, 'debug', 'ench_rebuild.mcfunction'), """# 把附魔师重置成干净的一套（金剑主手、金甲全新、两条蓄力清零）
item replace entity @s hotbar.0 with minecraft:golden_sword{Unbreakable:1b,KitEnch:1b}
item replace entity @s armor.head with minecraft:golden_helmet{Unbreakable:1b,KitEnch:1b}
item replace entity @s armor.chest with minecraft:golden_chestplate{Unbreakable:1b,KitEnch:1b}
item replace entity @s armor.legs with minecraft:golden_leggings{Unbreakable:1b,KitEnch:1b}
item replace entity @s armor.feet with minecraft:golden_boots{Unbreakable:1b,KitEnch:1b}
scoreboard players set @s kitpvp.ench_sw 0
scoreboard players set @s kitpvp.ench_ap 0
scoreboard players set @s kitpvp.ench_sword 0
scoreboard players set @s kitpvp.ench_armor 0
scoreboard players set @s kitpvp.ench_pity 0
""")


def grant(n):
    out = []
    for _ in range(n):
        out.append('scoreboard players set @s kitpvp.ench_sw 3')
        out.append('function kitpvp:skill/enchanter/up_sword')
        out.append('scoreboard players set @s kitpvp.ench_ap 3')
        out.append('function kitpvp:skill/enchanter/up_armor')
    return '\n'.join(out)


w(os.path.join(FN, 'debug', 'ench_5min.mcfunction'),
  '# 模拟"5 分钟累计"：直接补 7 级\nfunction kitpvp:debug/ench_rebuild\n' + grant(7) + '\nfunction kitpvp:skill/enchanter/name_refresh\n')
w(os.path.join(FN, 'debug', 'ench_8min.mcfunction'),
  '# 模拟"8 分钟累计"：直接补 11 级\nfunction kitpvp:debug/ench_rebuild\n' + grant(11) + '\nfunction kitpvp:skill/enchanter/name_refresh\n')

w(os.path.join(FN, 'debug', 'ench_check.mcfunction'), """# 附魔师自检：两条蓄力 / 两级等级 / 手持物
execute as @p run tellraw @a [{"text":"[附魔师] 剑蓄力=","color":"gray"},{"score":{"name":"@p","objective":"kitpvp.ench_sw"}},{"text":" 剑等级=","color":"gray"},{"score":{"name":"@p","objective":"kitpvp.ench_sword"}},{"text":" 甲蓄力=","color":"gray"},{"score":{"name":"@p","objective":"kitpvp.ench_ap"}},{"text":" 甲等级=","color":"gray"},{"score":{"name":"@p","objective":"kitpvp.ench_armor"}}]
execute as @p run tellraw @a [{"text":"[附魔师] 手上一格=","color":"gray"},{"nbt":"SelectedItem.id","entity":"@p","color":"white"}]
""")

# ---------------------------------------------------------------- advancements
hit = {
    "criteria": {
        "hit": {
            "trigger": "minecraft:player_hurt_entity",
            "conditions": {
                "entity": {"type": "minecraft:player"},
                "damage": {"source_entity": {"type": "minecraft:player"}}
            }
        }
    },
    "requirements": [["hit"]],
    "rewards": {"function": "kitpvp:skill/enchanter/ench_hit"}
}
hurt = {
    "criteria": {
        "hurt": {
            "trigger": "minecraft:entity_hurt_player",
            "conditions": {
                "damage": {"source_entity": {"type": "minecraft:player"}}
            }
        }
    },
    "requirements": [["hurt"]],
    "rewards": {"function": "kitpvp:skill/enchanter/ench_hurt"}
}
for name, data in (('ench_hit', hit), ('ench_hurt', hurt)):
    with io.open(os.path.join(ADV, name + '.json'), 'w', encoding='utf-8', newline='\n') as f:
        f.write(json.dumps(data, ensure_ascii=False, indent=2) + '\n')

# 删掉旧的 upgrade
old = os.path.join(SK, 'upgrade.mcfunction')
if os.path.exists(old):
    os.remove(old)
print('done')
