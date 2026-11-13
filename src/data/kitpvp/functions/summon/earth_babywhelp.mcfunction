# 飞龙宝宝：头顶末影龙头的僵尸，每 5 秒朝 20 格内最近的玩家吐一颗火球
# 装备槽顺序是 脚 → 腿 → 胸 → 头：绿皮靴 / 绿皮裤 / 鞘翅 / 末影龙头
# ⚠ 头上的龙头同时解决两件事：外观 + 白天不自燃（僵尸的 isSunBurnTick 只要头槽非空就不烧）
summon minecraft:zombie ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_babywhelp"],CustomName:'{"text":"飞龙宝宝","color":"dark_purple"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Health:30.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:30.0},{Name:"minecraft:generic.attack_damage",Base:3.0}],HandItems:[{},{}],ArmorItems:[{id:"minecraft:leather_boots",Count:1b,tag:{display:{color:43520}}},{id:"minecraft:leather_leggings",Count:1b,tag:{display:{color:43520}}},{id:"minecraft:elytra",Count:1b},{id:"minecraft:dragon_head",Count:1b}]}
scoreboard players set @e[tag=kitpvp.earth_babywhelp] kitpvp.bw_cd 60
