# 1 秒到了：B 还活着 ⇒ A 在 B 脚下满血复活；B 也没了 ⇒ 两只算一起死，谁都别复活
# replace 去重：这 1 秒里 A 死了两次只算最后那次，不会复活出两只 A
execute if entity @e[tag=kitpvp.earth_twinstar_b] at @e[tag=kitpvp.earth_twinstar_b,limit=1] run function kitpvp:summon/earth_twinstar_a