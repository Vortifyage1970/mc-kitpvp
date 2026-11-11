# 太阳魂石落地（执行位置 = 落点，@s = 使用者）
# 范围与太阳黑子一致（9 格）：落点周围**除自己以外**的玩家 20 秒失明，并在 20 秒内每 2 秒被灌一条噪音（128 选 1）
# 自己用 tag 排除：`soul_sun_owner` 在落点写给最近的那名玩家（= 使用者），marker 到期 / reset / 换职业时摘掉
execute as @a[distance=..8,sort=nearest,limit=1] run tag @s add kitpvp.soul_sun_owner
execute at @s as @a[distance=..9,scores={kitpvp.alive=1},tag=!kitpvp.spectator,tag=!kitpvp.soul_sun_owner] run effect give @s minecraft:blindness 20 0 true
summon minecraft:marker ~ ~ ~ {Tags:["kitpvp.soul_sun_marker","kitpvp.soul_sun_new"]}
scoreboard players set @e[tag=kitpvp.soul_sun_new] kitpvp.soul_timer 400
scoreboard players set @e[tag=kitpvp.soul_sun_new] kitpvp.soul_next 20
tag @e[tag=kitpvp.soul_sun_new] remove kitpvp.soul_sun_new

title @s actionbar {"text":"魂石·日蚀：9 格内其他玩家失明 20 秒，每 2 秒一条噪音","color":"gold"}
playsound minecraft:block.beacon.deactivate master @s ~ ~ ~ 1.0 0.6
