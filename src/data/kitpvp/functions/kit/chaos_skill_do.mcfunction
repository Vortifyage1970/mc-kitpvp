# 重铸：清掉武器、随机换一把，冷却走全局 kitpvp.cd（30 秒 = 600 刻，tick 第 3 行统一递减）
# 令牌本身会被主手替换吃掉，所以最后补一发（有就不给，避免叠）
scoreboard players set @s kitpvp.cd 600
playsound minecraft:block.beacon.activate master @s ~ ~ ~ 1 1.2
particle minecraft:enchanted_hit ~ ~1 ~ 0.5 0.5 0.5 0.1 20 normal
item replace entity @s weapon.mainhand with minecraft:air
title @s actionbar {"text":"混沌·重铸","color":"dark_purple"}
function kitpvp:kit/chaos_next
# 保险：万一这一摇没落到任何一把（理论上不会），再摇一次
execute unless data entity @s SelectedItem run function kitpvp:kit/chaos_next
# 补回「混沌·重铸」望远镜（手上/背包里还有就不重复给）
execute unless data entity @s Inventory[{id:"minecraft:spyglass"}] run give @s minecraft:spyglass{ChaosToken:1b,Unbreakable:1b,display:{Name:'{"text":"混沌·重铸","color":"dark_purple","italic":false}',Lore:['{"text":"右键：清掉手上的武器，随机重铸一把（冷却 30 秒）","color":"dark_purple","italic":false}']}} 1
