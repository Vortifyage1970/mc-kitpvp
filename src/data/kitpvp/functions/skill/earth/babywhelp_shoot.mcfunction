# 下面这一行由 babywhelp_fire 调进来时 @s 还是宝宝；这里只负责"真的吐出去"
scoreboard players set @s kitpvp.bw_cd 100
# 吐之前的预警：喉咙里亮一下、来一声吸气（不然玩家看不见它在准备）
execute at @s run particle minecraft:flame ~ ~1.4 ~ 0.06 0.06 0.06 0.005 3
execute at @s run playsound minecraft:entity.blaze.breathe hostile @a[distance=..24] ~ ~ ~ 0.7 1.3
# 朝目标的胸口召唤一颗火球；朝向决定它自己的 Rotation，速度由 babywhelp_ball 每刻 tp 推进
execute anchored eyes facing entity @p[tag=kitpvp.bw_tgt] eyes positioned ^ ^ ^1 run summon minecraft:small_fireball ~ ~ ~ {Tags:["kitpvp.bw_ball","kitpvp.bw_new"],NoGravity:1b,Silent:1b}
# 把"谁召的"记到火球身上（etid），火球靠它排除召唤者本人
scoreboard players operation @e[tag=kitpvp.bw_new] kitpvp.bw_owner = @s kitpvp.earth_owner
tag @e[tag=kitpvp.bw_new] remove kitpvp.bw_new
execute at @s run playsound minecraft:entity.blaze.shoot hostile @a[distance=..24] ~ ~ ~ 0.85 1.1
