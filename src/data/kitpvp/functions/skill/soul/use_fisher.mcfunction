# 首行推进快照，漏写会每刻重复触发（铁律）
scoreboard players operation @s kitpvp.soul_fisher_last = @s kitpvp.soul_fisher_used

# 刷怪蛋必定真的刷出一条鳕鱼（纯副作用），当场清掉；只认自己 tag 的那条，地图里的鱼不动
execute at @s run kill @e[type=minecraft:cod,tag=kitpvp.soul_fisher_token,distance=..16]

# 发一把"里·渔夫同款"激流三叉戟：与 kit/tainted_fisher 那把逐字一致（实际伤害 6 / 攻速 1.0，见 04 §九），
# 只多一个结束回收用的标记。先清再发：连用两颗魂石也只保留一把。
# 渔夫自己那把（KitFisherTrident）完全不受影响，结束也不用还，所以到期只需收走这一把。
# 统计口径：鳕鱼蛋在本服只有这里发（唯一来源），所以 minecraft.used:cod_spawn_egg 不会被污染
clear @s minecraft:trident{KitSoulFisherTrident:1b}
give @s minecraft:trident{KitSoulFisherTrident:1b,Unbreakable:1b,Enchantments:[{id:"minecraft:riptide",lvl:1}],AttributeModifiers:[{AttributeName:"generic.attack_damage",Name:"generic.attack_damage",Amount:5,Operation:0,UUID:[I;29,0,0,5],Slot:"mainhand"},{AttributeName:"generic.attack_speed",Name:"generic.attack_speed",Amount:-3,Operation:0,UUID:[I;29,0,0,6],Slot:"mainhand"}]} 1

tag @s add kitpvp.soul_fisher_active
scoreboard players set @s kitpvp.soul_fisher_timer 400

# 报幕与音效照抄里·渔夫的领域展开（起手 + 1 秒后开领域两段，见 domain_start / domain_open）
tellraw @a [{"text":"◆　","color":"dark_aqua"},{"text":"领","color":"dark_blue","bold":true},{"text":"域","color":"blue","bold":true},{"text":"展","color":"dark_aqua","bold":true},{"text":"开","color":"aqua","bold":true},{"text":"　◆","color":"dark_aqua"}]
execute as @a at @s run playsound minecraft:entity.ender_dragon.growl master @s ~ ~ ~ 0.6 0.8

# 雨 20 秒；load 关了 doWeatherCycle，雨不会自己停 —— 停雨由 fisher_expire 与 game/reset 两道保险负责（见 04 §五）
weather rain 20

# 雨爱从"最后 20 秒"那段进入：每个音符事件都会 schedule 下一个，所以直接从中段事件起步就能播完尾段。
# ev_0067 在曲内第 758 刻，到收尾的 1162 刻还剩 404 刻（≈20.2 秒），与 20 秒窗口对齐
schedule function kitpvp:music/yu_ai/ev_0067 1t replace

title @s actionbar {"text":"魂石·激流：里·渔夫的激流三叉戟（20 秒）","color":"blue"}
playsound minecraft:item.trident.return master @s ~ ~ ~ 0.8 1.2
