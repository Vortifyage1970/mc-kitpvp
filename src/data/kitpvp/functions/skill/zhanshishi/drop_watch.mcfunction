# 绊索陷阱：**丢出去**就进冷却（只看背包数量，掉到地上不改变背包 → 只有真丢出去才减少）
scoreboard players set #trap_now kitpvp.game 0
execute if score @s kitpvp.trap_id matches 1 store result score #trap_now kitpvp.game run clear @s minecraft:tripwire_hook{KitTrapHook:1b,KitTrapOwner:1b} 0
execute if score @s kitpvp.trap_id matches 2 store result score #trap_now kitpvp.game run clear @s minecraft:tripwire_hook{KitTrapHook:1b,KitTrapOwner:2b} 0
execute if score @s kitpvp.trap_id matches 3 store result score #trap_now kitpvp.game run clear @s minecraft:tripwire_hook{KitTrapHook:1b,KitTrapOwner:3b} 0
execute if score @s kitpvp.trap_id matches 4 store result score #trap_now kitpvp.game run clear @s minecraft:tripwire_hook{KitTrapHook:1b,KitTrapOwner:4b} 0
execute if score @s kitpvp.trap_id matches 5 store result score #trap_now kitpvp.game run clear @s minecraft:tripwire_hook{KitTrapHook:1b,KitTrapOwner:5b} 0
execute if score @s kitpvp.trap_id matches 6 store result score #trap_now kitpvp.game run clear @s minecraft:tripwire_hook{KitTrapHook:1b,KitTrapOwner:6b} 0
# 背包里的数量变少 = 刚刚丢出去至少一个；计时中再丢不重置（同 03 §2.13）
execute if score #trap_now kitpvp.game < @s kitpvp.trap_hook_prev if score @s kitpvp.trap_hook_cd matches ..0 run scoreboard players set @s kitpvp.trap_hook_cd 500
scoreboard players operation @s kitpvp.trap_hook_prev = #trap_now kitpvp.game

# 蠹虫陷阱：**丢出去**就进冷却（只看背包数量，掉到地上不改变背包 → 只有真丢出去才减少）
scoreboard players set #trap_now kitpvp.game 0
execute if score @s kitpvp.trap_id matches 1 store result score #trap_now kitpvp.game run clear @s minecraft:firework_star{KitTrapWorm:1b,KitTrapOwner:1b} 0
execute if score @s kitpvp.trap_id matches 2 store result score #trap_now kitpvp.game run clear @s minecraft:firework_star{KitTrapWorm:1b,KitTrapOwner:2b} 0
execute if score @s kitpvp.trap_id matches 3 store result score #trap_now kitpvp.game run clear @s minecraft:firework_star{KitTrapWorm:1b,KitTrapOwner:3b} 0
execute if score @s kitpvp.trap_id matches 4 store result score #trap_now kitpvp.game run clear @s minecraft:firework_star{KitTrapWorm:1b,KitTrapOwner:4b} 0
execute if score @s kitpvp.trap_id matches 5 store result score #trap_now kitpvp.game run clear @s minecraft:firework_star{KitTrapWorm:1b,KitTrapOwner:5b} 0
execute if score @s kitpvp.trap_id matches 6 store result score #trap_now kitpvp.game run clear @s minecraft:firework_star{KitTrapWorm:1b,KitTrapOwner:6b} 0
# 背包里的数量变少 = 刚刚丢出去至少一个；计时中再丢不重置（同 03 §2.13）
execute if score #trap_now kitpvp.game < @s kitpvp.trap_worm_prev if score @s kitpvp.trap_worm_cd matches ..0 run scoreboard players set @s kitpvp.trap_worm_cd 1800
scoreboard players operation @s kitpvp.trap_worm_prev = #trap_now kitpvp.game
