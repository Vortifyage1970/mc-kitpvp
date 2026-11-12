# 重铸：清主手、随机换一把，冷却走全局 kitpvp.cd（30 秒 = 600 刻，tick 第 3 行统一递减）
scoreboard players set @s kitpvp.cd 600
execute at @s run kill @e[tag=kitpvp.chaos_token,distance=..8]
playsound minecraft:block.beacon.activate master @s ~ ~ ~ 1 1.2
particle minecraft:enchanted_hit ~ ~1 ~ 0.5 0.5 0.5 0.1 20 normal
item replace entity @s weapon.mainhand with minecraft:air
title @s actionbar {"text":"混沌·重铸","color":"dark_purple"}
function kitpvp:kit/chaos_next
# 蛋是一次性的（生存里会被消耗），用完后补回来
execute unless data entity @s Inventory[{id:"minecraft:pufferfish_spawn_egg"}] run give @s minecraft:pufferfish_spawn_egg{ChaosToken:1b,EntityTag:{Tags:["kitpvp.chaos_token"]},display:{Name:'{"text":"混沌·重铸","color":"dark_purple","italic":false}',Lore:['{"text":"右键：清掉手上的武器，随机重铸一把（冷却 30 秒）","color":"dark_purple","italic":false}']}} 1
