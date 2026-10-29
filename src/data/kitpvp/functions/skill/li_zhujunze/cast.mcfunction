# 首行无条件推进快照，漏写会每刻连发
scoreboard players operation @s kitpvp.li_pig_last = @s kitpvp.li_pig_used

# 放出一只就进 10 秒（200 刻）补货计时；..0 守卫保证连放不把补货越推越远（03 §2.13）
execute if score @s kitpvp.cd matches ..0 run scoreboard players set @s kitpvp.cd 200

title @s actionbar {"text":"iLsacuL 已出现","color":"light_purple"}
playsound minecraft:entity.pig.ambient master @s ~ ~ ~ 1 0.8
