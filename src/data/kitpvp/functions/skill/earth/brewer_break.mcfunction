# @s = 一瓶刚落地的酿造台药水（tick 里 OnGround 或 brw_life ≥ 30 时调进来）
# 砸开：4 格内的玩家各吃一口对应的效果，时长 15 秒；然后瓶子消失
# 注意所有 if entity @s[tag=...] 都写在 as @a 之前 —— 一旦 as @a，@s 就变成玩家了
particle minecraft:effect ~ ~ ~ 0.4 0.3 0.4 0.05 25 force
particle minecraft:item_slime ~ ~ ~ 0.3 0.2 0.3 0.05 12 force
playsound minecraft:entity.splash_potion.break block @a ~ ~ ~ 1.0 1.0
execute if entity @s[tag=kitpvp.brw_strength] as @a[distance=..4,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] run effect give @s minecraft:strength 15 0 true
execute if entity @s[tag=kitpvp.brw_speed] as @a[distance=..4,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] run effect give @s minecraft:speed 15 0 true
execute if entity @s[tag=kitpvp.brw_harm] as @a[distance=..4,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] run effect give @s minecraft:instant_damage 1 0 true
execute if entity @s[tag=kitpvp.brw_nausea] as @a[distance=..4,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] run effect give @s minecraft:nausea 15 0 true
execute if entity @s[tag=kitpvp.brw_resist] as @a[distance=..4,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] run effect give @s minecraft:resistance 15 0 true
kill @s
