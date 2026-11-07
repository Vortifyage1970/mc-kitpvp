# @s = 8 格内的一名玩家（at 他自己）。塞一颗"眩晕"：蓝色染料 + 唯一序号，永远叠不起来
# 为什么不用 give：give 出去的 NBT 一模一样就会自己叠成一摞，看不到"这一下塞了几个"
# 掉在地上的物品实体 PickupDelay 0，下一刻就被贴身捡走，体感等于直接塞进包里
summon minecraft:item ~ ~1 ~ {PickupDelay:0s,Tags:["kitpvp.hive_orb"],Item:{id:"minecraft:blue_dye",Count:1b,tag:{display:{Name:'{"text":"眩晕","color":"aqua","italic":false}'},Enchantments:[{id:"minecraft:unbreaking",lvl:1}],kitpvp:{serial:0}}}}
scoreboard players add #hive_serial kitpvp.game 1
execute store result entity @e[tag=kitpvp.hive_orb,limit=1,sort=nearest] Item.tag.kitpvp.serial int 1 run scoreboard players get #hive_serial kitpvp.game
tag @e[tag=kitpvp.hive_orb,limit=1,sort=nearest] remove kitpvp.hive_orb
