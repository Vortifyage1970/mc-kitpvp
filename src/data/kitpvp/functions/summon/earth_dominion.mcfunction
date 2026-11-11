# 地球·51 内卫（Dominion）：头戴红树根的僵尸，穿黑色皮革甲，主手石剑、副手「烟火之心」，**出场只放一次**黑色烟花
# 烟花本身不伤人，纯粹是"给自己报点"——放一次亮一次，谁都能顺着看过来
# 手上一把石剑纯装饰：僵尸的近战伤害只看 attack_damage 属性（3 点），拿什么剑都一样
# 头槽被红树根占着，所以皮革套只穿三件（胸甲/护腿/靴子），没有皮革头盔
summon minecraft:zombie ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_dominion"],CustomName:'{"text":"内卫","color":"dark_gray"}',CustomNameVisible:0b,PersistenceRequired:1b,CanPickUpLoot:0b,Health:15.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:15.0}],HandItems:[{id:"minecraft:stone_sword",Count:1b},{id:"minecraft:firework_star",Count:1b,tag:{display:{Name:'{"text":"烟火之心","color":"dark_gray","italic":false}'}}}],ArmorItems:[{id:"minecraft:leather_boots",Count:1b,tag:{display:{color:0}}},{id:"minecraft:leather_leggings",Count:1b,tag:{display:{color:0}}},{id:"minecraft:leather_chestplate",Count:1b,tag:{display:{color:0}}},{id:"minecraft:mangrove_roots",Count:1b}]}
# 出场计时归零，然后**只放这一场**烟花（2026-11-10：需求改成"仅出场时放一次"）
# 必须 as 本体来跑：dominion_firework 里读的是 @s 的 dominion_age / earth_cd_a
execute as @e[tag=kitpvp.earth_dominion] at @s run function kitpvp:skill/earth/dominion_firework
