# @s = 一瓶刚落地的酿造台药水（tick 里 OnGround 或 brw_life ≥ 30 时调进来）
# 砸开后在原地留一团滞留云：半径 3 格、只存在 1 秒（20 刻），走进去的人吃 15 秒的效果
# 注意所有 if entity @s[tag=...] 都写在 as 之前 —— 一旦 as @a，@s 就变成玩家了
particle minecraft:item_slime ~ ~ ~ 0.3 0.2 0.3 0.05 12 force
playsound minecraft:entity.splash_potion.break block @a ~ ~ ~ 1.0 1.0
# Duration:20 = 云只活 1 秒；Radius:3 + RadiusPerTick/OnUse 0 = 全程不变大不缩；ReapplicationDelay 20 = 同一人只吃一次
execute if entity @s[tag=kitpvp.brw_strength] run summon minecraft:area_effect_cloud ~ ~ ~ {Radius:3.0f,RadiusPerTick:0.0f,RadiusOnUse:0.0f,Duration:20,WaitTime:0,ReapplicationDelay:20,Color:12625004,Effects:[{Id:5b,Amplifier:0b,Duration:300,Ambient:0b,ShowParticles:1b,ShowIcon:1b}],Tags:["kitpvp.brw_cloud"]}
execute if entity @s[tag=kitpvp.brw_speed] run summon minecraft:area_effect_cloud ~ ~ ~ {Radius:3.0f,RadiusPerTick:0.0f,RadiusOnUse:0.0f,Duration:20,WaitTime:0,ReapplicationDelay:20,Color:8518,Effects:[{Id:1b,Amplifier:0b,Duration:300,Ambient:0b,ShowParticles:1b,ShowIcon:1b}],Tags:["kitpvp.brw_cloud"]}
execute if entity @s[tag=kitpvp.brw_harm] run summon minecraft:area_effect_cloud ~ ~ ~ {Radius:3.0f,RadiusPerTick:0.0f,RadiusOnUse:0.0f,Duration:20,WaitTime:0,ReapplicationDelay:20,Color:4393481,Effects:[{Id:7b,Amplifier:0b,Duration:1,Ambient:0b,ShowParticles:1b,ShowIcon:1b}],Tags:["kitpvp.brw_cloud"]}
execute if entity @s[tag=kitpvp.brw_nausea] run summon minecraft:area_effect_cloud ~ ~ ~ {Radius:3.0f,RadiusPerTick:0.0f,RadiusOnUse:0.0f,Duration:20,WaitTime:0,ReapplicationDelay:20,Color:5511764,Effects:[{Id:9b,Amplifier:0b,Duration:300,Ambient:0b,ShowParticles:1b,ShowIcon:1b}],Tags:["kitpvp.brw_cloud"]}
execute if entity @s[tag=kitpvp.brw_resist] run summon minecraft:area_effect_cloud ~ ~ ~ {Radius:3.0f,RadiusPerTick:0.0f,RadiusOnUse:0.0f,Duration:20,WaitTime:0,ReapplicationDelay:20,Color:10044730,Effects:[{Id:11b,Amplifier:0b,Duration:300,Ambient:0b,ShowParticles:1b,ShowIcon:1b}],Tags:["kitpvp.brw_cloud"]}
kill @s
