# 名叫「海龟蛋」的实体（load 里按装饰保护的那批）每局复原前统一清掉
kill @e[name="海龟蛋"]
kill @e[tag=kitpvp.tamer_wolf]
kill @e[type=wolf]

execute if score #global kitpvp.map matches 1 run function kitpvp:map/desert/restore
execute if score #global kitpvp.map matches 2 run function kitpvp:map/arena/restore
execute if score #global kitpvp.map matches 3 run function kitpvp:map/snow/restore
execute if score #global kitpvp.map matches 7 run function kitpvp:map/earth/restore
execute if score #global kitpvp.map matches 8 run function kitpvp:map/xian/restore
