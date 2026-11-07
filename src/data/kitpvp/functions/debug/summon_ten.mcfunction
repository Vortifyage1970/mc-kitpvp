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
# 测试专用：把主人改成不存在的 99 号槽，并从队伍里踢出去 ——
# 这样它们不认你是主人，会像对待敌人一样回头打你。正式召唤走 link，照常认主、不会打你
execute as @p at @s run scoreboard players set @e[tag=kitpvp.earth_minion,distance=..10] kitpvp.earth_owner 99
execute as @p at @s run team leave @e[tag=kitpvp.earth_minion,distance=..10]
execute as @p at @s run tag @e[tag=kitpvp.earth_minion,distance=..10] add kitpvp.ten_test
# 自检：报附近总数与"还没被改成测试归属"的只数（应为 0）
scoreboard players set #ten_all kitpvp.game 0
scoreboard players set #ten_orphan kitpvp.game 0
execute as @p at @s as @e[tag=kitpvp.earth_minion,distance=..10] run scoreboard players add #ten_all kitpvp.game 1
execute as @p at @s as @e[tag=kitpvp.earth_minion,distance=..10] unless score @s kitpvp.earth_owner matches 99 run scoreboard players add #ten_orphan kitpvp.game 1
execute as @p run title @s actionbar {"text":"十只生灵已降临（测试：它们会打你）","color":"red"}
execute as @p run tellraw @s [{"text":"[十连] 附近生灵 ","color":"gray"},{"score":{"name":"#ten_all","objective":"kitpvp.game"}},{"text":" 只，其中没转成敌对的 ","color":"gray"},{"score":{"name":"#ten_orphan","objective":"kitpvp.game"}},{"text":" 只","color":"gray"}]
execute unless entity @p run tellraw @a {"text":"[十连] 附近没有玩家，什么都没召","color":"red"}
