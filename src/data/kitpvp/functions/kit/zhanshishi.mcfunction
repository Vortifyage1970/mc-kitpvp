# 陷阱师（kit = 77，职业职业）：铁盔 / 黄皮革胸甲 / 铁护腿 / 铁靴（护甲 12）+ 击退 I 木剑 + 熟羊肉 x24
# 陷阱 = 掉落物，物品里烙着布陷阱者的 trap_id：自己捡回是回收，别人捡走会被拆掉并对捡起者触发
# 绊索(3/25s) 漂浮(每 25 次跳跃 +1，无上限) 蠹虫(1/60s) 猛毒(开局 2 个，不补货) 爆炸(1，死亡补货)
function kitpvp:util/clear_player

scoreboard players set @s kitpvp.kit 77
tag @s add kitpvp.selected
scoreboard players set @s kitpvp.alive 1
scoreboard players set @s kitpvp.lives 3

item replace entity @s armor.head with minecraft:iron_helmet{Unbreakable:1b}
item replace entity @s armor.chest with minecraft:leather_chestplate{Unbreakable:1b,display:{color:16776960}}
item replace entity @s armor.legs with minecraft:iron_leggings{Unbreakable:1b}
item replace entity @s armor.feet with minecraft:iron_boots{Unbreakable:1b}

item replace entity @s weapon.mainhand with minecraft:wooden_sword{Unbreakable:1b,Enchantments:[{id:"minecraft:knockback",lvl:1}]} 1
give @s minecraft:cooked_mutton 24

scoreboard players set @s kitpvp.trap_hook_cd 0
scoreboard players set @s kitpvp.trap_worm_cd 0
scoreboard players operation @s kitpvp.trap_hook_drop_last = @s kitpvp.trap_hook_drop_used
scoreboard players operation @s kitpvp.trap_worm_drop_last = @s kitpvp.trap_worm_drop_used
scoreboard players operation @s kitpvp.trap_hook_pick_last = @s kitpvp.trap_hook_pick_used
scoreboard players operation @s kitpvp.trap_float_pick_last = @s kitpvp.trap_float_pick_used
scoreboard players operation @s kitpvp.trap_worm_pick_last = @s kitpvp.trap_worm_pick_used
scoreboard players operation @s kitpvp.trap_poison_pick_last = @s kitpvp.trap_poison_pick_used
scoreboard players operation @s kitpvp.trap_boom_pick_last = @s kitpvp.trap_boom_pick_used
scoreboard players operation @s kitpvp.trap_float_last = @s kitpvp.trap_jump_used
function kitpvp:skill/zhanshishi/assign_slot
function kitpvp:skill/zhanshishi/give_hook
function kitpvp:skill/zhanshishi/give_hook
function kitpvp:skill/zhanshishi/give_hook
function kitpvp:skill/zhanshishi/give_worm
function kitpvp:skill/zhanshishi/give_boom
function kitpvp:skill/zhanshishi/give_poison
function kitpvp:skill/zhanshishi/give_poison

tellraw @s [{"text":"已选择 ","color":"gray"},{"text":"陷阱师","color":"aqua","bold":true}]
playsound minecraft:ui.button.click master @s ~ ~ ~ 1 1.2
