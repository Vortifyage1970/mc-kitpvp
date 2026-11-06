# 每刻跑在双星A 的守卫上：本体不在 3 格内就开始倒计时
# B 还活着 ⇒ 在它脚下复活；B 也没了 ⇒ 两只算一起死，守卫撤退
scoreboard players add @s kitpvp.earth_revive_cd 0
execute unless score @s kitpvp.earth_revive_cd matches 1.. run scoreboard players set @s kitpvp.earth_revive_cd 20
execute if score @s kitpvp.earth_revive_cd matches 1.. run scoreboard players remove @s kitpvp.earth_revive_cd 1
execute if entity @e[tag=kitpvp.earth_twinstar_b] if score @s kitpvp.earth_revive_cd matches ..0 at @e[tag=kitpvp.earth_twinstar_b,limit=1] run function kitpvp:summon/earth_twinstar_a
execute unless entity @e[tag=kitpvp.earth_twinstar_b] if score @s kitpvp.earth_revive_cd matches ..0 run kill @s
execute if score @s kitpvp.earth_revive_cd matches ..0 if entity @e[tag=kitpvp.earth_twinstar_b] run kill @s
