# 井盖体检：/function kitpvp:debug/manhole_check
# 打印地底还剩几只、每只的装填计时、头顶 2.5 格内的玩家，以及每人身上的 mh_summoner（1 = 埋它的人，不触发）
scoreboard players set #mh_n kitpvp.game 0
execute as @e[tag=kitpvp.earth_manhole] run scoreboard players add #mh_n kitpvp.game 1
tellraw @a [{"text":"[井盖] 地底还有 ","color":"gold"},{"score":{"name":"#mh_n","objective":"kitpvp.game"}},{"text":" 只没破土","color":"gold"}]
execute as @e[tag=kitpvp.earth_manhole,limit=4] at @s run tellraw @a [{"text":"[井盖] cd=","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.earth_cd_a"}},{"text":" 头顶活人：","color":"gray"},{"selector":"@a[distance=..2.5,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}]"}]
scoreboard players add @a kitpvp.mh_summoner 0
execute as @a run tellraw @a [{"text":"[井盖] 你 mh_summoner=","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.mh_summoner"}},{"text":"（1 = 自己埋的，踩上去不爆；想测就置 0）","color":"gray"}]
