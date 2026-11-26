# @s = 用掉附魔师魂石的玩家（在玩家身上执行）
# 玩家实体的 NBT 不允许 /data 改，所以走"临时盔甲架手术"：
#   ① stone_bak  —— 备份原件（手=武器，四格=头/胸/腿/靴）
#   ② stone_work —— 一次只放一件，改完 NBT 再写回玩家
# 20 秒后由 enchanter_expire 从 stone_bak 还原（只还原还带着 KitSoulTemp 的槽位）
kill @e[tag=kitpvp.stone_bak,distance=..8]
kill @e[tag=kitpvp.stone_work,distance=..8]
summon minecraft:armor_stand ~ ~ ~ {Tags:["kitpvp.stone_bak"],Invisible:1b,NoGravity:1b,Invulnerable:1b,Silent:1b}
summon minecraft:armor_stand ~ ~ ~ {Tags:["kitpvp.stone_work"],Invisible:1b,NoGravity:1b,Invulnerable:1b,Silent:1b}
# ---- 备份原件 ----
item replace entity @e[tag=kitpvp.stone_bak,limit=1,sort=nearest] armor.head from entity @s weapon.mainhand
item replace entity @e[tag=kitpvp.stone_bak,limit=1,sort=nearest] armor.chest from entity @s armor.head
item replace entity @e[tag=kitpvp.stone_bak,limit=1,sort=nearest] armor.legs from entity @s armor.chest
item replace entity @e[tag=kitpvp.stone_bak,limit=1,sort=nearest] armor.feet from entity @s armor.legs
item replace entity @e[tag=kitpvp.stone_bak,limit=1,sort=nearest] weapon.mainhand from entity @s armor.feet
# ---- 武器：全部五级战斗附魔 ----
item replace entity @e[tag=kitpvp.stone_work,limit=1,sort=nearest] armor.head from entity @s weapon.mainhand
data modify entity @e[tag=kitpvp.stone_work,limit=1,sort=nearest] ArmorItems[3].tag.KitSoulTemp set value 1b
data modify entity @e[tag=kitpvp.stone_work,limit=1,sort=nearest] ArmorItems[3].tag.Enchantments set value [{id:"minecraft:sharpness",lvl:5s},{id:"minecraft:smite",lvl:5s},{id:"minecraft:fire_aspect",lvl:5s},{id:"minecraft:knockback",lvl:5s},{id:"minecraft:sweeping",lvl:5s}]
item replace entity @s weapon.mainhand from entity @e[tag=kitpvp.stone_work,limit=1,sort=nearest] armor.head
# ---- 头盔 ----
item replace entity @e[tag=kitpvp.stone_work,limit=1,sort=nearest] armor.head from entity @s armor.head
data modify entity @e[tag=kitpvp.stone_work,limit=1,sort=nearest] ArmorItems[3].tag.KitSoulTemp set value 1b
data modify entity @e[tag=kitpvp.stone_work,limit=1,sort=nearest] ArmorItems[3].tag.Enchantments set value [{id:"minecraft:protection",lvl:5s},{id:"minecraft:projectile_protection",lvl:5s},{id:"minecraft:fire_protection",lvl:5s},{id:"minecraft:blast_protection",lvl:5s},{id:"minecraft:respiration",lvl:5s},{id:"minecraft:aqua_affinity",lvl:5s}]
item replace entity @s armor.head from entity @e[tag=kitpvp.stone_work,limit=1,sort=nearest] armor.head
# ---- 胸甲 ----
item replace entity @e[tag=kitpvp.stone_work,limit=1,sort=nearest] armor.head from entity @s armor.chest
data modify entity @e[tag=kitpvp.stone_work,limit=1,sort=nearest] ArmorItems[3].tag.KitSoulTemp set value 1b
data modify entity @e[tag=kitpvp.stone_work,limit=1,sort=nearest] ArmorItems[3].tag.Enchantments set value [{id:"minecraft:protection",lvl:5s},{id:"minecraft:projectile_protection",lvl:5s},{id:"minecraft:fire_protection",lvl:5s},{id:"minecraft:blast_protection",lvl:5s},{id:"minecraft:thorns",lvl:5s}]
item replace entity @s armor.chest from entity @e[tag=kitpvp.stone_work,limit=1,sort=nearest] armor.head
# ---- 护腿 ----
item replace entity @e[tag=kitpvp.stone_work,limit=1,sort=nearest] armor.head from entity @s armor.legs
data modify entity @e[tag=kitpvp.stone_work,limit=1,sort=nearest] ArmorItems[3].tag.KitSoulTemp set value 1b
data modify entity @e[tag=kitpvp.stone_work,limit=1,sort=nearest] ArmorItems[3].tag.Enchantments set value [{id:"minecraft:protection",lvl:5s},{id:"minecraft:projectile_protection",lvl:5s},{id:"minecraft:fire_protection",lvl:5s},{id:"minecraft:blast_protection",lvl:5s},{id:"minecraft:thorns",lvl:5s}]
item replace entity @s armor.legs from entity @e[tag=kitpvp.stone_work,limit=1,sort=nearest] armor.head
# ---- 靴子 ----
item replace entity @e[tag=kitpvp.stone_work,limit=1,sort=nearest] armor.head from entity @s armor.feet
data modify entity @e[tag=kitpvp.stone_work,limit=1,sort=nearest] ArmorItems[3].tag.KitSoulTemp set value 1b
data modify entity @e[tag=kitpvp.stone_work,limit=1,sort=nearest] ArmorItems[3].tag.Enchantments set value [{id:"minecraft:protection",lvl:5s},{id:"minecraft:projectile_protection",lvl:5s},{id:"minecraft:fire_protection",lvl:5s},{id:"minecraft:blast_protection",lvl:5s},{id:"minecraft:feather_falling",lvl:5s},{id:"minecraft:depth_strider",lvl:5s},{id:"minecraft:frost_walker",lvl:5s},{id:"minecraft:soul_speed",lvl:5s}]
item replace entity @s armor.feet from entity @e[tag=kitpvp.stone_work,limit=1,sort=nearest] armor.head
# ---- 计时 ----
scoreboard players set @s kitpvp.stone_left 400
playsound minecraft:block.enchantment_table.use master @s ~ ~ ~ 1.0 1.4
playsound minecraft:entity.player.levelup master @s ~ ~ ~ 0.6 1.6
particle minecraft:enchant ~ ~1 ~ 0.8 1.0 0.8 0.05 40
tellraw @s [{"text":"[附魔师魂石] ","color":"light_purple"},{"text":"武器与四件护甲获得五级附魔，持续 20 秒","color":"white"}]
