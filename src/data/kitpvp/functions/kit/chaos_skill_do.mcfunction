# 重铸：按 tag 清掉所有混沌武器（不动望远镜 / 牛排），随机发一把，冷却 600 刻
scoreboard players set @s kitpvp.cd 600
playsound minecraft:block.beacon.activate master @s ~ ~ ~ 1 1.2
particle minecraft:enchanted_hit ~ ~1 ~ 0.5 0.5 0.5 0.1 20 normal
title @s actionbar {"text":"混沌重铸","color":"dark_purple"}
function kitpvp:kit/chaos_next
# 望远镜被吃掉了才补（正常不会）
execute unless data entity @s Inventory[{id:"minecraft:spyglass"}] run give @s minecraft:spyglass{ChaosToken:1b,Unbreakable:1b,display:{Name:'{"text":"混沌重铸","color":"dark_purple","italic":false}',Lore:['{"text":"右键：清掉手上的武器，随机重铸一把（冷却 30 秒）","color":"dark_purple","italic":false}']}} 1
