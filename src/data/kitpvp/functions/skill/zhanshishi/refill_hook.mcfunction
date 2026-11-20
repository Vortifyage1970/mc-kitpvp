# 绊索陷阱：上限 3、25 秒（500 刻）补 1；持有量 = 背包 + 场上自己没被捡走的
scoreboard players set #trap_cnt kitpvp.game 0
execute if score @s kitpvp.trap_id matches 1 store result score #trap_cnt kitpvp.game run clear @s minecraft:tripwire_hook{KitTrapHook:1b,KitTrapOwner:1b} 0
execute if score @s kitpvp.trap_id matches 1 store result score #trap_gnd kitpvp.game if entity @e[type=minecraft:item,nbt={Item:{tag:{KitTrapHook:1b,KitTrapOwner:1b}}}]
execute if score @s kitpvp.trap_id matches 1 run scoreboard players operation #trap_cnt kitpvp.game += #trap_gnd kitpvp.game
execute if score @s kitpvp.trap_id matches 2 store result score #trap_cnt kitpvp.game run clear @s minecraft:tripwire_hook{KitTrapHook:1b,KitTrapOwner:2b} 0
execute if score @s kitpvp.trap_id matches 2 store result score #trap_gnd kitpvp.game if entity @e[type=minecraft:item,nbt={Item:{tag:{KitTrapHook:1b,KitTrapOwner:2b}}}]
execute if score @s kitpvp.trap_id matches 2 run scoreboard players operation #trap_cnt kitpvp.game += #trap_gnd kitpvp.game
execute if score @s kitpvp.trap_id matches 3 store result score #trap_cnt kitpvp.game run clear @s minecraft:tripwire_hook{KitTrapHook:1b,KitTrapOwner:3b} 0
execute if score @s kitpvp.trap_id matches 3 store result score #trap_gnd kitpvp.game if entity @e[type=minecraft:item,nbt={Item:{tag:{KitTrapHook:1b,KitTrapOwner:3b}}}]
execute if score @s kitpvp.trap_id matches 3 run scoreboard players operation #trap_cnt kitpvp.game += #trap_gnd kitpvp.game
execute if score @s kitpvp.trap_id matches 4 store result score #trap_cnt kitpvp.game run clear @s minecraft:tripwire_hook{KitTrapHook:1b,KitTrapOwner:4b} 0
execute if score @s kitpvp.trap_id matches 4 store result score #trap_gnd kitpvp.game if entity @e[type=minecraft:item,nbt={Item:{tag:{KitTrapHook:1b,KitTrapOwner:4b}}}]
execute if score @s kitpvp.trap_id matches 4 run scoreboard players operation #trap_cnt kitpvp.game += #trap_gnd kitpvp.game
execute if score @s kitpvp.trap_id matches 5 store result score #trap_cnt kitpvp.game run clear @s minecraft:tripwire_hook{KitTrapHook:1b,KitTrapOwner:5b} 0
execute if score @s kitpvp.trap_id matches 5 store result score #trap_gnd kitpvp.game if entity @e[type=minecraft:item,nbt={Item:{tag:{KitTrapHook:1b,KitTrapOwner:5b}}}]
execute if score @s kitpvp.trap_id matches 5 run scoreboard players operation #trap_cnt kitpvp.game += #trap_gnd kitpvp.game
execute if score @s kitpvp.trap_id matches 6 store result score #trap_cnt kitpvp.game run clear @s minecraft:tripwire_hook{KitTrapHook:1b,KitTrapOwner:6b} 0
execute if score @s kitpvp.trap_id matches 6 store result score #trap_gnd kitpvp.game if entity @e[type=minecraft:item,nbt={Item:{tag:{KitTrapHook:1b,KitTrapOwner:6b}}}]
execute if score @s kitpvp.trap_id matches 6 run scoreboard players operation #trap_cnt kitpvp.game += #trap_gnd kitpvp.game
execute if score #trap_cnt kitpvp.game matches ..2 run function kitpvp:skill/zhanshishi/give_hook
execute if score #trap_cnt kitpvp.game matches ..2 run scoreboard players set @s kitpvp.trap_hook_cd 500
execute if score #trap_cnt kitpvp.game matches ..2 run title @s actionbar {"text":"补给：这是个陷阱！","color":"red"}
