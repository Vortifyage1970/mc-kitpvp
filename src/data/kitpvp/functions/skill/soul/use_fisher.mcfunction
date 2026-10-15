# 首行推进快照，漏写会每刻重复触发
scoreboard players operation @s kitpvp.soul_fisher_last = @s kitpvp.soul_fisher_used

# 清掉刷怪蛋刷出的那条鳕鱼
execute at @s run kill @e[type=minecraft:cod,tag=kitpvp.soul_fisher_token,distance=..16]

# 发一把与里·渔夫逐字一致的激流三叉戟（实际伤害 6，见 04 §九），多一个结束回收的标记；先清再发。
# 鳕鱼蛋在本服只有这里发，used 统计不会被污染
clear @s minecraft:trident{KitSoulFisherTrident:1b}
give @s minecraft:trident{KitSoulFisherTrident:1b,Unbreakable:1b,Enchantments:[{id:"minecraft:riptide",lvl:1}],AttributeModifiers:[{AttributeName:"generic.attack_damage",Name:"generic.attack_damage",Amount:5,Operation:0,UUID:[I;29,0,0,5],Slot:"mainhand"},{AttributeName:"generic.attack_speed",Name:"generic.attack_speed",Amount:-3,Operation:0,UUID:[I;29,0,0,6],Slot:"mainhand"}]} 1

tag @s add kitpvp.soul_fisher_active
scoreboard players set @s kitpvp.soul_fisher_timer 400

# 报幕与音效照抄里·渔夫的领域展开（两段见 domain_start / domain_open）
tellraw @a [{"text":"◆　","color":"dark_aqua"},{"text":"领","color":"dark_blue","bold":true},{"text":"域","color":"blue","bold":true},{"text":"展","color":"dark_aqua","bold":true},{"text":"开","color":"aqua","bold":true},{"text":"　◆","color":"dark_aqua"}]
execute as @a at @s run playsound minecraft:entity.ender_dragon.growl master @s ~ ~ ~ 0.6 0.8

# 雨 20 秒；doWeatherCycle 已关，停雨由 fisher_expire 与 game/reset 负责（见 04 §五）
weather rain 20

# 雨爱从"最后 20 秒"进入：ev_0067 在曲内第 758 刻，到收尾 1162 刻正好剩 404 刻（≈20.2 秒）
schedule function kitpvp:music/yu_ai/ev_0067 1t replace

title @s actionbar {"text":"魂石·激流：激流 I 三叉戟（20 秒）","color":"blue"}
playsound minecraft:item.trident.return master @s ~ ~ ~ 0.8 1.2
