# 木星探针：/function kitpvp:debug/jupiter_probe
# 分两段看：① 召唤后立刻数一下有没有带 tag 的木星（#jup = 1 才有）② 打死，2 刻后打印尸体状态
# 输出里 "召唤后 #jup=" 这一行最要紧：0 = summon 那行根本没生出实体（或 tag 不对）
scoreboard players set #jup kitpvp.game 0
execute at @s run function kitpvp:summon/earth_jupiter
execute store success score #jup kitpvp.game if entity @e[tag=kitpvp.earth_jupiter]
tellraw @a [{"text":"[探针] 召唤后 #jup=","color":"gray"},{"score":{"name":"#jup","objective":"kitpvp.game"}},{"text":"（1=有木星，0=没生出来）","color":"dark_gray"}]
damage @e[type=minecraft:zombie,tag=kitpvp.earth_jupiter,distance=..3,sort=nearest,limit=1] 100 minecraft:generic
schedule function kitpvp:debug/jupiter_probe_after 2t replace
