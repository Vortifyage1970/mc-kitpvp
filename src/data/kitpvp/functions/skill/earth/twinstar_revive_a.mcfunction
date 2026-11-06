# 1 秒到了：B 还活着 ⇒ A 在它脚下满血复活；B 也没了 ⇒ 两只算一起死，谁都别复活
# replace 去重：这 1 秒里同一只死两次只算最后那次，不会复活出两只
execute if entity @e[tag=kitpvp.earth_twinstar_b] at @e[tag=kitpvp.earth_twinstar_b,limit=1] run function kitpvp:summon/earth_twinstar_a

# ★ 复活出来的是全新的召唤物、没走过 link：不继承归属它就会打召唤者（包括你）。
#   抄存活那只的 earth_owner，再按 1..6 挂回同名队伍（队伍名 = earth_<etid>，见 link.mcfunction）
execute at @e[tag=kitpvp.earth_twinstar_b,limit=1] run scoreboard players operation @e[tag=kitpvp.earth_minion_new,distance=..2] kitpvp.earth_owner = @e[tag=kitpvp.earth_twinstar_b,limit=1] kitpvp.earth_owner
execute at @e[tag=kitpvp.earth_twinstar_b,limit=1] if score @e[tag=kitpvp.earth_minion_new,distance=..2] kitpvp.earth_owner matches 1 run team join earth_1 @e[tag=kitpvp.earth_minion_new,distance=..2]
execute at @e[tag=kitpvp.earth_twinstar_b,limit=1] if score @e[tag=kitpvp.earth_minion_new,distance=..2] kitpvp.earth_owner matches 2 run team join earth_2 @e[tag=kitpvp.earth_minion_new,distance=..2]
execute at @e[tag=kitpvp.earth_twinstar_b,limit=1] if score @e[tag=kitpvp.earth_minion_new,distance=..2] kitpvp.earth_owner matches 3 run team join earth_3 @e[tag=kitpvp.earth_minion_new,distance=..2]
execute at @e[tag=kitpvp.earth_twinstar_b,limit=1] if score @e[tag=kitpvp.earth_minion_new,distance=..2] kitpvp.earth_owner matches 4 run team join earth_4 @e[tag=kitpvp.earth_minion_new,distance=..2]
execute at @e[tag=kitpvp.earth_twinstar_b,limit=1] if score @e[tag=kitpvp.earth_minion_new,distance=..2] kitpvp.earth_owner matches 5 run team join earth_5 @e[tag=kitpvp.earth_minion_new,distance=..2]
execute at @e[tag=kitpvp.earth_twinstar_b,limit=1] if score @e[tag=kitpvp.earth_minion_new,distance=..2] kitpvp.earth_owner matches 6 run team join earth_6 @e[tag=kitpvp.earth_minion_new,distance=..2]
execute at @e[tag=kitpvp.earth_twinstar_b,limit=1] run tag @e[tag=kitpvp.earth_minion_new,distance=..2] remove kitpvp.earth_minion_new
