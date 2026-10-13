# 由 assassin_dispatch 调用（快照已在 dispatch 首行推进）；tp 后位置会变，故先清生物
execute at @s run kill @e[type=minecraft:enderman,name="刺客魂石"]

effect give @s minecraft:speed 20 1 true
effect give @s minecraft:invisibility 20 0 true

tag @s add kitpvp.soul_transit
execute at @s as @a[tag=!kitpvp.soul_transit,tag=!kitpvp.spectator,sort=nearest,limit=1] at @s run tp @a[tag=kitpvp.soul_transit,limit=1] ~ ~ ~
tag @s remove kitpvp.soul_transit

title @s actionbar {"text":"魂石·暗袭：速度 II + 隐身 I（20 秒）","color":"dark_purple"}
playsound minecraft:entity.enderman.teleport master @s ~ ~ ~ 0.8 1.4
