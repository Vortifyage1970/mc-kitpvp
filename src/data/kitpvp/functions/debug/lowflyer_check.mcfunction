tellraw @a [{"text":"═══ 低空飞行器自检 ═══","color":"gold","bold":true}]
scoreboard players set #lfc kitpvp.game 0
scoreboard players set #lfb kitpvp.game 0
execute as @e[tag=kitpvp.earth_lowflyer_carrier] run scoreboard players add #lfc kitpvp.game 1
execute as @e[tag=kitpvp.earth_lowflyer_body] run scoreboard players add #lfb kitpvp.game 1
tellraw @a [{"text":"蝙蝠 = ","color":"gray"},{"score":{"name":"#lfc","objective":"kitpvp.game"},"color":"white"},{"text":"   吊舱骷髅 = ","color":"gray"},{"score":{"name":"#lfb","objective":"kitpvp.game"},"color":"white"},{"text":"（0 / 0 = 没召出来）","color":"dark_gray"}]
# 现在箭由原版骷髅 AI 自己射：它只认"最近的玩家"，所以按 16 格 + 有视线数一遍它可能打谁
scoreboard players set #lfv kitpvp.game 0
execute as @e[tag=kitpvp.earth_lowflyer_body,limit=1,sort=nearest] at @s run execute as @a[distance=..16,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] run scoreboard players add #lfv kitpvp.game 1
tellraw @a [{"text":"16 格内它会去打的人 = ","color":"gray"},{"score":{"name":"#lfv","objective":"kitpvp.game"},"color":"white"},{"text":"（旁观不算；创造会被锁定但打不掉血；召唤者现在也照打）","color":"dark_gray"}]
# 直接把"吊舱 16 格内的玩家"名字列出来，方便看是不是自己站太远
execute as @e[tag=kitpvp.earth_lowflyer_body,limit=1,sort=nearest] at @s run tellraw @a [{"text":"吊舱 16 格内的玩家：","color":"gray"},{"selector":"@a[distance=..16,gamemode=!spectator,tag=!kitpvp.spectator]","color":"white"}]
