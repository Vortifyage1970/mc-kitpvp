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
item replace entity @s hotbar.1 with minecraft:cooked_beef 32
item replace entity @s hotbar.2 with minecraft:camel_spawn_egg{EntityTag:{Silent:1b,NoAI:1b,NoGravity:1b,Invulnerable:1b,PersistenceRequired:1b},KitLiSingle:1b,Enchantments:[{id:"minecraft:unbreaking",lvl:1s}],display:{Name:'{"text":"单抽","color":"light_purple","italic":false}',Lore:['{"text":"右键：受 3 点伤害抽一次（冷却 2 秒）","color":"gray","italic":false}']}}
item replace entity @s hotbar.3 with minecraft:panda_spawn_egg{KitLiTen:1b,Enchantments:[{id:"minecraft:unbreaking",lvl:1s}],display:{Name:'{"text":"十连","color":"gold","italic":false}',Lore:['{"text":"右键：受 20 点伤害连抽十次（冷却 5 秒）","color":"gray","italic":false}']}}

scoreboard players set @s kitpvp.ench_sw 0
scoreboard players set @s kitpvp.ench_pending 0
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
scoreboard players add @s kitpvp.ench_domain_used 0
scoreboard players operation @s kitpvp.ench_domain_last = @s kitpvp.ench_domain_used
scoreboard players add @s kitpvp.ench_egg_used 0
scoreboard players operation @s kitpvp.ench_egg_last = @s kitpvp.ench_egg_used
scoreboard players set @s kitpvp.ench_tmp 0
scoreboard players set @s kitpvp.ench_tmp_kind 0
tag @s remove kitpvp.ench_domain
tag @s remove kitpvp.ench_wait
execute as @e[tag=kitpvp.ench_bench] run kill @s
scoreboard players set @s kitpvp.li_single_cd 0
scoreboard players set @s kitpvp.li_pity 0
scoreboard players set @s kitpvp.li_ten_cd 0
scoreboard players set @s kitpvp.li_dom_pull 0
scoreboard players add @s kitpvp.li_single_used 0
scoreboard players operation @s kitpvp.li_single_last = @s kitpvp.li_single_used
scoreboard players add @s kitpvp.li_ten_used 0
scoreboard players operation @s kitpvp.li_ten_last = @s kitpvp.li_ten_used
scoreboard players set @s kitpvp.ench_slot 0
function kitpvp:skill/li_ench/assign_slot
function kitpvp:skill/li_ench/pity_name
function kitpvp:skill/li_ench/name_refresh
function kitpvp:skill/li_ench/hud_show

tellraw @s [{"text":"已选择 ","color":"gray"},{"text":"里·附魔师","color":"dark_red","bold":true}]
tellraw @s [{"text":"右键「单抽」受 3 点伤害抽一次；「十连」受 20 点伤害抽十次","color":"dark_gray"}]
tellraw @s [{"text":"抽卡涨剑/甲进度，3 点升 1 级，各 11 级封顶；冷却 60 秒","color":"dark_gray"}]
