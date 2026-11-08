# @s = 一瓶刚落地的酿造台药水（tick 里 OnGround 或 brw_life ≥ 30 时调进来）
# 砸开后在原地撒一片 4 格范围的效果：只有玩家吃，酿造台自己（僵尸）不会被自己的药水影响
# 不用 area_effect_cloud 的原因：云对范围内所有活体生效，站在落点上的酿造台会给自己上力量/速度/抗性，
# 瞬间伤害那瓶还会把自己扣血 —— 改成效果直接给 @a，僵尸就天然被排除在外
# 注意所有 if entity @s[tag=...] 都写在 as 之前 —— 一旦 as @a，@s 就变成玩家了
particle minecraft:item_slime ~ ~ ~ 0.3 0.2 0.3 0.05 12 force
playsound minecraft:entity.splash_potion.break block @a ~ ~ ~ 1.0 1.0
# 力量 I（颜色 0xC0A3EC）
execute if entity @s[tag=kitpvp.brw_strength] run particle minecraft:dust 0.753 0.639 0.925 1.4 ~ ~0.3 ~ 2.4 0.5 2.4 0.02 90 normal
execute if entity @s[tag=kitpvp.brw_strength] run effect give @a[distance=..4,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] minecraft:strength 15 0 true
# 速度 I（0x002146）
execute if entity @s[tag=kitpvp.brw_speed] run particle minecraft:dust 0.0 0.129 0.275 1.4 ~ ~0.3 ~ 2.4 0.5 2.4 0.02 90 normal
execute if entity @s[tag=kitpvp.brw_speed] run effect give @a[distance=..4,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] minecraft:speed 15 0 true
# 瞬间伤害 I（0x430A09）
execute if entity @s[tag=kitpvp.brw_harm] run particle minecraft:dust 0.263 0.039 0.035 1.4 ~ ~0.3 ~ 2.4 0.5 2.4 0.02 90 normal
execute if entity @s[tag=kitpvp.brw_harm] run effect give @a[distance=..4,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] minecraft:instant_damage 1 0 true
# 反胃 I（0x541A54）
execute if entity @s[tag=kitpvp.brw_nausea] run particle minecraft:dust 0.329 0.102 0.329 1.4 ~ ~0.3 ~ 2.4 0.5 2.4 0.02 90 normal
execute if entity @s[tag=kitpvp.brw_nausea] run effect give @a[distance=..4,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] minecraft:nausea 15 0 true
# 抗性提升 I（0x99453A）
execute if entity @s[tag=kitpvp.brw_resist] run particle minecraft:dust 0.6 0.271 0.227 1.4 ~ ~0.3 ~ 2.4 0.5 2.4 0.02 90 normal
execute if entity @s[tag=kitpvp.brw_resist] run effect give @a[distance=..4,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] minecraft:resistance 15 0 true
kill @s
