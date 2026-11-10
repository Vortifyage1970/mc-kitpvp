# 太阳魂石落地（执行位置 = 落点，@s = 使用者）
# 范围与太阳黑子一致（9 格）：落点周围玩家 20 秒失明，并在 20 秒内每 2 秒被灌一条噪音（128 选 1）
execute at @s as @a[distance=..9,scores={kitpvp.alive=1},tag=!kitpvp.spectator] run effect give @s minecraft:blindness 20 0 true
summon minecraft:marker ~ ~ ~ {Tags:["kitpvp.soul_sun_marker","kitpvp.soul_sun_new"]}
scoreboard players set @e[tag=kitpvp.soul_sun_new] kitpvp.soul_timer 400
scoreboard players set @e[tag=kitpvp.soul_sun_new] kitpvp.soul_next 20
tag @e[tag=kitpvp.soul_sun_new] remove kitpvp.soul_sun_new

title @s actionbar {"text":"魂石·日蚀：9 格内失明 20 秒，每 2 秒一条噪音","color":"gold"}
playsound minecraft:block.beacon.deactivate master @s ~ ~ ~ 1.0 0.6
