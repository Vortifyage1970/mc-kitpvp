# 蠹虫陷阱：召唤 25 血「陷阱虫」，力量 I / 速度 I，站到**布陷阱者**那套队（#trap_to = 他的 trap_id）
execute unless score @s kitpvp.trap_id matches 1 run clear @s minecraft:firework_star{KitTrapWorm:1b,KitTrapOwner:1b}
execute unless score @s kitpvp.trap_id matches 2 run clear @s minecraft:firework_star{KitTrapWorm:1b,KitTrapOwner:2b}
execute unless score @s kitpvp.trap_id matches 3 run clear @s minecraft:firework_star{KitTrapWorm:1b,KitTrapOwner:3b}
execute unless score @s kitpvp.trap_id matches 4 run clear @s minecraft:firework_star{KitTrapWorm:1b,KitTrapOwner:4b}
execute unless score @s kitpvp.trap_id matches 5 run clear @s minecraft:firework_star{KitTrapWorm:1b,KitTrapOwner:5b}
execute unless score @s kitpvp.trap_id matches 6 run clear @s minecraft:firework_star{KitTrapWorm:1b,KitTrapOwner:6b}
summon minecraft:silverfish ~ ~ ~ {Tags:["kitpvp.trap_worm","kitpvp.team_new"],CustomName:'{"text":"陷阱虫","color":"gold"}',CustomNameVisible:1b,PersistenceRequired:1b,Health:25f,Attributes:[{Name:"minecraft:generic.max_health",Base:25.0}]}
effect give @e[tag=kitpvp.trap_worm,distance=..4,sort=nearest,limit=1] minecraft:strength infinite 0 true
effect give @e[tag=kitpvp.trap_worm,distance=..4,sort=nearest,limit=1] minecraft:speed infinite 0 true
execute as @a[scores={kitpvp.kit=77,kitpvp.trap_id=1}] if score #trap_to kitpvp.game matches 1 run scoreboard players operation #steam kitpvp.game = @s kitpvp.trap_team
execute as @a[scores={kitpvp.kit=77,kitpvp.trap_id=2}] if score #trap_to kitpvp.game matches 2 run scoreboard players operation #steam kitpvp.game = @s kitpvp.trap_team
execute as @a[scores={kitpvp.kit=77,kitpvp.trap_id=3}] if score #trap_to kitpvp.game matches 3 run scoreboard players operation #steam kitpvp.game = @s kitpvp.trap_team
execute as @a[scores={kitpvp.kit=77,kitpvp.trap_id=4}] if score #trap_to kitpvp.game matches 4 run scoreboard players operation #steam kitpvp.game = @s kitpvp.trap_team
execute as @a[scores={kitpvp.kit=77,kitpvp.trap_id=5}] if score #trap_to kitpvp.game matches 5 run scoreboard players operation #steam kitpvp.game = @s kitpvp.trap_team
execute as @a[scores={kitpvp.kit=77,kitpvp.trap_id=6}] if score #trap_to kitpvp.game matches 6 run scoreboard players operation #steam kitpvp.game = @s kitpvp.trap_team
function kitpvp:util/team_join
title @s actionbar {"text":"踩中了蠹虫陷阱！","color":"gold"}
playsound minecraft:entity.silverfish.ambient master @s ~ ~ ~ 1 0.6
