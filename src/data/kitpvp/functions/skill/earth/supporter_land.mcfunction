# @s = 正在下落、这一帧已经踩到地面的支援者（at @s）
# 先累计再收无敌：命令先跑、实体后 tick，落地那一帧的摔落伤害还没结算；
# 立刻解除 Invulnerable 会让 20 格的落势照样把它摔死，所以等到第 2 帧再收
scoreboard players add @s kitpvp.sup_land 1
execute if score @s kitpvp.sup_land matches 1 run particle minecraft:poof ~ ~0.3 ~ 0.6 0.15 0.6 0.01 16
execute if score @s kitpvp.sup_land matches 1 run playsound minecraft:entity.generic.big_fall block @a ~ ~ ~ 0.9 1
execute if score @s kitpvp.sup_land matches 2.. run data merge entity @s {Invulnerable:0b}
execute if score @s kitpvp.sup_land matches 2.. run tag @s remove kitpvp.sup_falling
