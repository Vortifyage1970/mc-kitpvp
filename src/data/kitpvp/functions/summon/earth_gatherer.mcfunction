# 地球·52 集合者：出场的一瞬间把 50 格内所有地球生灵（含其它召唤物、含别的集合者）拉到自己脚边
# 只发生一次：不挂 tick、不挂计时器 —— 它是个"一次性集结信号"，不是持续光环
# 用 spreadplayers 而不是 tp 到同一点：1~4 格内散开，避免几十只叠成一摞互相窒息、也避免碰撞箱把彼此挤飞
# 头是南瓜灯，主手山羊角（吹号）、副手钟（召集），本体僵尸 20 血；打人还是 3 点基础伤害，手上东西纯装饰
# ★ 自己拉不动自己：只在"这一只"身上挂临时 tag kitpvp.gatherer_self，用它当排除条件；
#   其它集合者身上没有这个 tag，所以它们会被拉过来（按"所有生灵"的语义走，不再整类排除）
summon minecraft:zombie ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_gatherer","kitpvp.gatherer_self"],CustomName:'{"text":"集合者","color":"yellow"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Health:20.0f,HandItems:[{id:"minecraft:goat_horn",Count:1b,tag:{Enchantments:[{id:"minecraft:sharpness",lvl:3s}]}},{id:"minecraft:bell",Count:1b,tag:{Enchantments:[{id:"minecraft:sharpness",lvl:3s}]}}],ArmorItems:[{},{},{},{id:"minecraft:jack_o_lantern",Count:1b}],Attributes:[{Name:"minecraft:generic.max_health",Base:20.0}]}
# 集结：50 格内所有带 earth_minion 的（除刚生成的这一只自己）拉过来
# 集合号：先吹一声山羊角（"召唤"那支），再把人拉过来 —— 声音和动作对得上，场上其他人也知道它来了
playsound minecraft:item.goat_horn.sound.5 master @a[distance=..48] ~ ~ ~ 1.0 0.9
execute at @s run spreadplayers ~ ~ 1 4 false @e[tag=kitpvp.earth_minion,tag=!kitpvp.gatherer_self,distance=..50]
# 用完立刻摘掉临时 tag，否则下一只集合者出场时会把这一只也漏掉
tag @e[tag=kitpvp.gatherer_self,distance=..6] remove kitpvp.gatherer_self
# 一声集合钟：给附近的人一个听觉提示（20 格内）
playsound minecraft:block.bell.resonate master @a[distance=..20] ~ ~ ~ 1.0 0.8
