# 绊索陷阱：上限 3（只算背包）、补货 25 秒；丢出时由 drop_hook 起计
execute if score @s kitpvp.trap_id matches ..0 run function kitpvp:skill/zhanshishi/assign_slot

# 持有量只看背包：摆到地上的算「已用掉」，不再占用上限（否则丢完永远补不回来）
scoreboard players set #trap_cnt kitpvp.game 0
execute if score @s kitpvp.trap_id matches 1 store result score #trap_cnt kitpvp.game run clear @s minecraft:tripwire_hook{KitTrapHook:1b,KitTrapOwner:1b} 0
execute if score @s kitpvp.trap_id matches 2 store result score #trap_cnt kitpvp.game run clear @s minecraft:tripwire_hook{KitTrapHook:1b,KitTrapOwner:2b} 0
execute if score @s kitpvp.trap_id matches 3 store result score #trap_cnt kitpvp.game run clear @s minecraft:tripwire_hook{KitTrapHook:1b,KitTrapOwner:3b} 0
execute if score @s kitpvp.trap_id matches 4 store result score #trap_cnt kitpvp.game run clear @s minecraft:tripwire_hook{KitTrapHook:1b,KitTrapOwner:4b} 0
execute if score @s kitpvp.trap_id matches 5 store result score #trap_cnt kitpvp.game run clear @s minecraft:tripwire_hook{KitTrapHook:1b,KitTrapOwner:5b} 0
execute if score @s kitpvp.trap_id matches 6 store result score #trap_cnt kitpvp.game run clear @s minecraft:tripwire_hook{KitTrapHook:1b,KitTrapOwner:6b} 0
execute if score #trap_cnt kitpvp.game matches ..2 run function kitpvp:skill/zhanshishi/give_hook
execute if score #trap_cnt kitpvp.game matches ..2 run scoreboard players set @s kitpvp.trap_hook_cd 500
execute if score #trap_cnt kitpvp.game matches ..2 run title @s actionbar {"text":"补给：这是个陷阱！","color":"red"}
