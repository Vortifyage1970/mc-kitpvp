# 蘑菇牛蛋与炸弹兵的 5 种令牌共用同一个 used 统计：首行无条件推进快照，再按载体名字分流（见 04 §17.4）
scoreboard players operation @s kitpvp.tf_rise_last = @s kitpvp.tf_rise_used
execute at @s if entity @e[type=minecraft:mooshroom,name="开始一场起义",distance=..8] run function kitpvp:skill/tainted_farmer/rise_summon
