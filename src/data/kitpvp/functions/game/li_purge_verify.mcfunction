# iLsacuL 复核：kill 的移除落在下一刻，所以必须隔刻再看一次，不能同刻数
# 还有残留就整轮重来（再拉、再杀、再复查），最多 6 轮；清干净或放弃都把轮次归零
scoreboard players add #lipurge kitpvp.game 1

execute if entity @e[tag=kitpvp.li_pig] if score #lipurge kitpvp.game matches ..5 run function kitpvp:game/li_purge
execute unless entity @e[tag=kitpvp.li_pig] run scoreboard players set #lipurge kitpvp.game 0

execute if entity @e[tag=kitpvp.li_pig] if score #lipurge kitpvp.game matches 6.. run tellraw @a [{"text":"[警告] ","color":"red","bold":true},{"text":"iLsacuL 未能完全清除，请检查未加载区块","color":"red"}]
execute if entity @e[tag=kitpvp.li_pig] if score #lipurge kitpvp.game matches 6.. run scoreboard players set #lipurge kitpvp.game 0
