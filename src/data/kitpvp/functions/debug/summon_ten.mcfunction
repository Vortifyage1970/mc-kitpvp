# 随机在召唤者周围撒 10 只生灵（测试用）
# 用法：站在空地上，/reload 后 /function kitpvp:debug/summon_ten
# 为什么每只都单独 positioned：random 在"执行坐标"上召唤，link 也只认领落点 4 格内的生灵。
# 十只挤在一点会互相推挤、而且 link 一次只能认领一个半径，所以每只各自散开、各自认领。
# 冷却（kitpvp.cd）与补货不管：这是测试，不占玩家的召唤冷却
execute as @p at @s positioned ~4 ~ ~ run function kitpvp:debug/summon_ten_one
execute as @p at @s positioned ~-4 ~ ~ run function kitpvp:debug/summon_ten_one
execute as @p at @s positioned ~ ~ ~4 run function kitpvp:debug/summon_ten_one
execute as @p at @s positioned ~ ~ ~-4 run function kitpvp:debug/summon_ten_one
execute as @p at @s positioned ~3 ~ ~3 run function kitpvp:debug/summon_ten_one
execute as @p at @s positioned ~-3 ~ ~3 run function kitpvp:debug/summon_ten_one
execute as @p at @s positioned ~3 ~ ~-3 run function kitpvp:debug/summon_ten_one
execute as @p at @s positioned ~-3 ~ ~-3 run function kitpvp:debug/summon_ten_one
execute as @p at @s positioned ~6 ~ ~ run function kitpvp:debug/summon_ten_one
execute as @p at @s positioned ~-6 ~ ~ run function kitpvp:debug/summon_ten_one
execute if entity @p run title @s actionbar {"text":"十只生灵已降临","color":"blue"}
execute unless entity @p run tellraw @a {"text":"[十连] 附近没有玩家，什么都没召","color":"red"}
