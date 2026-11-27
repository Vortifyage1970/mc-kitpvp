# 里·附魔师（kit = 99）：金套 + 金剑 + 坐杀博徒入场券；常态不能蓄力，全靠赌场抽卡
function kitpvp:util/clear_player
scoreboard players set @s kitpvp.kit 99
tag @s add kitpvp.selected

attribute @s minecraft:generic.max_health base set 20
attribute @s minecraft:generic.movement_speed base set 0.1

item replace entity @s armor.head with minecraft:golden_helmet{Unbreakable:1b,KitEnch:1b,Trim:{material:"minecraft:redstone",pattern:"minecraft:vex"}}
item replace entity @s armor.chest with minecraft:golden_chestplate{Unbreakable:1b,KitEnch:1b,Trim:{material:"minecraft:redstone",pattern:"minecraft:vex"}}
item replace entity @s armor.legs with minecraft:golden_leggings{Unbreakable:1b,KitEnch:1b,Trim:{material:"minecraft:redstone",pattern:"minecraft:vex"}}
item replace entity @s armor.feet with minecraft:golden_boots{Unbreakable:1b,KitEnch:1b,Trim:{material:"minecraft:redstone",pattern:"minecraft:vex"}}
item replace entity @s hotbar.0 with minecraft:golden_sword{Unbreakable:1b,KitEnch:1b}
item replace entity @s hotbar.1 with minecraft:cooked_beef 24
item replace entity @s hotbar.2 with minecraft:bat_spawn_egg{KitDomain:1b,Enchantments:[{id:"minecraft:unbreaking",lvl:1s}],display:{Name:'{"text":"坐杀博徒·入场券","color":"light_purple","italic":false}',Lore:['{"text":"右键使用：展开领域「坐杀博徒」","color":"gray","italic":false}','{"text":"60 秒赌场时间，每次命中抽一张卡","color":"dark_gray","italic":false}','{"text":"常态不能蓄力——赌场之外不会有任何进度","color":"dark_gray","italic":false}']}}

scoreboard players set @s kitpvp.ench_sw 0
scoreboard players set @s kitpvp.ench_ap 0
scoreboard players set @s kitpvp.ench_sword 0
scoreboard players set @s kitpvp.ench_armor 0
scoreboard players set @s kitpvp.ench_sw_fill 0
scoreboard players set @s kitpvp.ench_ap_fill 0
scoreboard players set @s kitpvp.ench_pity 0
scoreboard players set @s kitpvp.ench_hint 0
scoreboard players set @s kitpvp.ench_fx 0
scoreboard players set @s kitpvp.ench_domain_t 0
scoreboard players set @s kitpvp.ench_domain_cd 0
scoreboard players set @s kitpvp.ench_domain_ready 0
scoreboard players set @s kitpvp.ench_tmp 0
scoreboard players set @s kitpvp.ench_tmp_kind 0
tag @s remove kitpvp.ench_domain
tag @s remove kitpvp.ench_wait
execute as @e[tag=kitpvp.ench_bench] run kill @s
scoreboard players set @s kitpvp.ench_slot 0
function kitpvp:skill/li_ench/assign_slot
function kitpvp:skill/li_ench/name_refresh

tellraw @s [{"text":"已选择 ","color":"gray"},{"text":"里·附魔师","color":"dark_red","bold":true}]
tellraw @s [{"text":"常态不能蓄力：用「坐杀博徒·入场券」开场，60 秒内每次命中抽一张卡","color":"dark_gray"}]
tellraw @s [{"text":"抽卡涨剑/甲进度，3 点升 1 级，各 11 级封顶；冷却 60 秒","color":"dark_gray"}]
