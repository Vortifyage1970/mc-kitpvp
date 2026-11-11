# @s = 刚挨了打的那个玩家（tick 用 HurtTime=9 抓的，只命中一帧，不会连发）
# 不能直接 give：give 出去的纸只要 NBT 一模一样，就会自己叠成一摞。
# 改成掉一个物品实体，再当场给它写一个唯一序号 —— 序号不同就永远叠不起来，看起来就是"一张一张的物料"
# 每次发完记一个 60 刻（3 秒）冷却：同一个人 3 秒内最多拿一张
scoreboard players set @s kitpvp.coser_cd 60
summon minecraft:item ~ ~ ~ {PickupDelay:0s,Tags:["kitpvp.coser_paper"],Item:{id:"minecraft:paper",Count:1b,tag:{display:{Name:'{"text":"物料","color":"light_purple","italic":false}'},Enchantments:[{id:"minecraft:unbreaking",lvl:1}],kitpvp:{serial:0}}}}
scoreboard players add #coser_serial kitpvp.game 1
execute store result entity @e[tag=kitpvp.coser_paper,limit=1,sort=nearest] Item.tag.kitpvp.serial int 1 run scoreboard players get #coser_serial kitpvp.game
tag @e[tag=kitpvp.coser_paper,limit=1,sort=nearest] remove kitpvp.coser_paper
