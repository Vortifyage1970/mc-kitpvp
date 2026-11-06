# 地球·65 讲解石：滴水石块当头的僵尸，挨一下（任何来源掉血）就当场消失
# 消失时的播报用原版的 translate key multiplayer.player.left（="%s 离开了游戏"），和真玩家退服一模一样
# 血量快照复用 kitpvp.nb_hp / nb_prev（按实体分别存，和音符盒互不干扰）
summon minecraft:zombie ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_explainer"],CustomName:'{"text":"讲解石","color":"gray"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Health:20.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:20.0}],HandItems:[{},{}],ArmorItems:[{},{},{},{id:"minecraft:dripstone_block",Count:1b}]}
execute as @e[tag=kitpvp.earth_explainer] store result score @s kitpvp.nb_hp run data get entity @s Health 100
scoreboard players set @e[tag=kitpvp.earth_explainer] kitpvp.nb_prev 2000
