# @s = 陷阱师：检查是否捡到了别人的「爆炸陷阱」（owner 与自己不同）
execute unless score @s kitpvp.trap_id matches 1 store result score #trap_tt kitpvp.game run clear @s minecraft:tnt{KitTrapBoom:1b,KitTrapOwner:1b} 0
execute unless score @s kitpvp.trap_id matches 1 if score #trap_tt kitpvp.game matches 1.. run scoreboard players set #trap_to kitpvp.game 1
execute unless score @s kitpvp.trap_id matches 1 if score #trap_tt kitpvp.game matches 1.. run function kitpvp:skill/zhanshishi/trigger_boom
execute unless score @s kitpvp.trap_id matches 2 store result score #trap_tt kitpvp.game run clear @s minecraft:tnt{KitTrapBoom:1b,KitTrapOwner:2b} 0
execute unless score @s kitpvp.trap_id matches 2 if score #trap_tt kitpvp.game matches 1.. run scoreboard players set #trap_to kitpvp.game 2
execute unless score @s kitpvp.trap_id matches 2 if score #trap_tt kitpvp.game matches 1.. run function kitpvp:skill/zhanshishi/trigger_boom
execute unless score @s kitpvp.trap_id matches 3 store result score #trap_tt kitpvp.game run clear @s minecraft:tnt{KitTrapBoom:1b,KitTrapOwner:3b} 0
execute unless score @s kitpvp.trap_id matches 3 if score #trap_tt kitpvp.game matches 1.. run scoreboard players set #trap_to kitpvp.game 3
execute unless score @s kitpvp.trap_id matches 3 if score #trap_tt kitpvp.game matches 1.. run function kitpvp:skill/zhanshishi/trigger_boom
execute unless score @s kitpvp.trap_id matches 4 store result score #trap_tt kitpvp.game run clear @s minecraft:tnt{KitTrapBoom:1b,KitTrapOwner:4b} 0
execute unless score @s kitpvp.trap_id matches 4 if score #trap_tt kitpvp.game matches 1.. run scoreboard players set #trap_to kitpvp.game 4
execute unless score @s kitpvp.trap_id matches 4 if score #trap_tt kitpvp.game matches 1.. run function kitpvp:skill/zhanshishi/trigger_boom
execute unless score @s kitpvp.trap_id matches 5 store result score #trap_tt kitpvp.game run clear @s minecraft:tnt{KitTrapBoom:1b,KitTrapOwner:5b} 0
execute unless score @s kitpvp.trap_id matches 5 if score #trap_tt kitpvp.game matches 1.. run scoreboard players set #trap_to kitpvp.game 5
execute unless score @s kitpvp.trap_id matches 5 if score #trap_tt kitpvp.game matches 1.. run function kitpvp:skill/zhanshishi/trigger_boom
execute unless score @s kitpvp.trap_id matches 6 store result score #trap_tt kitpvp.game run clear @s minecraft:tnt{KitTrapBoom:1b,KitTrapOwner:6b} 0
execute unless score @s kitpvp.trap_id matches 6 if score #trap_tt kitpvp.game matches 1.. run scoreboard players set #trap_to kitpvp.game 6
execute unless score @s kitpvp.trap_id matches 6 if score #trap_tt kitpvp.game matches 1.. run function kitpvp:skill/zhanshishi/trigger_boom
