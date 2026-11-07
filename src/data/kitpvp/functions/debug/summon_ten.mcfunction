# 随机在召唤者周围撒 10 只生灵（测试用）
# 用法：站在空地上，/reload 后 /function kitpvp:debug/summon_ten
# 每只单独 positioned：random 在"执行坐标"上召唤，link 也只认领落点 4 格内的生灵。
# 十只挤在一点会互相推挤，所以各自散开、各自认领。
# 冷却（kitpvp.cd）与补货不管：这是测试，不占玩家的召唤冷却
execute as @p at @s positioned ~3 ~ ~ run function kitpvp:debug/summon_ten_one
execute as @p at @s positioned ~-3 ~ ~ run function kitpvp:debug/summon_ten_one
execute as @p at @s positioned ~ ~ ~3 run function kitpvp:debug/summon_ten_one
execute as @p at @s positioned ~ ~ ~-3 run function kitpvp:debug/summon_ten_one
execute as @p at @s positioned ~2 ~ ~2 run function kitpvp:debug/summon_ten_one
execute as @p at @s positioned ~-2 ~ ~2 run function kitpvp:debug/summon_ten_one
execute as @p at @s positioned ~2 ~ ~-2 run function kitpvp:debug/summon_ten_one
execute as @p at @s positioned ~-2 ~ ~-2 run function kitpvp:debug/summon_ten_one
execute as @p at @s positioned ~4 ~ ~ run function kitpvp:debug/summon_ten_one
execute as @p at @s positioned ~-4 ~ ~ run function kitpvp:debug/summon_ten_one
# 兜底认领：有些召唤物出生后会自己挪位置 / 换实体（支援者要被提上去、坐骑是外层实体），
# link 的 4 格半径够不着。10 格内还没主人的一律划给召唤者，并按槽位补一次队伍
execute as @p at @s run scoreboard players add @e[tag=kitpvp.earth_minion,distance=..10] kitpvp.earth_owner 0
execute as @p at @s run scoreboard players operation @e[tag=kitpvp.earth_minion,distance=..10,scores={kitpvp.earth_owner=..0}] kitpvp.earth_owner = @s kitpvp.etid
execute as @p at @s if score @s kitpvp.etid matches 1 run team join earth_1 @e[tag=kitpvp.earth_minion,distance=..10]
execute as @p at @s if score @s kitpvp.etid matches 2 run team join earth_2 @e[tag=kitpvp.earth_minion,distance=..10]
execute as @p at @s if score @s kitpvp.etid matches 3 run team join earth_3 @e[tag=kitpvp.earth_minion,distance=..10]
execute as @p at @s if score @s kitpvp.etid matches 4 run team join earth_4 @e[tag=kitpvp.earth_minion,distance=..10]
execute as @p at @s if score @s kitpvp.etid matches 5 run team join earth_5 @e[tag=kitpvp.earth_minion,distance=..10]
execute as @p at @s if score @s kitpvp.etid matches 6 run team join earth_6 @e[tag=kitpvp.earth_minion,distance=..10]
# 自检：报附近总数与"仍然没主人"的只数，方便一眼确认认领有没有生效
scoreboard players set #ten_all kitpvp.game 0
scoreboard players set #ten_orphan kitpvp.game 0
execute as @p at @s as @e[tag=kitpvp.earth_minion,distance=..10] run scoreboard players add #ten_all kitpvp.game 1
execute as @p at @s as @e[tag=kitpvp.earth_minion,distance=..10] if score @s kitpvp.earth_owner matches ..0 run scoreboard players add #ten_orphan kitpvp.game 1
execute as @p run title @s actionbar {"text":"十只生灵已降临","color":"blue"}
execute as @p run tellraw @s [{"text":"[十连] 附近生灵 ","color":"gray"},{"score":{"name":"#ten_all","objective":"kitpvp.game"}},{"text":" 只，其中没主人 ","color":"gray"},{"score":{"name":"#ten_orphan","objective":"kitpvp.game"}},{"text":" 只","color":"gray"}]
execute unless entity @p run tellraw @a {"text":"[十连] 附近没有玩家，什么都没召","color":"red"}
