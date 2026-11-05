# 地球·39 滑冰者：蓝冰当头的骷髅，脚上是染成蓝色、带冰霜行者 I 的皮革靴，手持附魔生鱼；常驻缓慢 I
# ★ 本体用 stray（冰骷髅）而不是 skeleton：它在 freeze_immune_entity_types 里，自己脚下那格细雪冻不着它
# ★ 细雪用 skill/earth/snow_place 那套（marker + earth_snow 分数）铺，10 秒后自己化掉，不覆盖已有方块
summon minecraft:stray ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_skater"],CustomName:'{"text":"滑冰者","color":"aqua"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,NoAI:1b,HandItems:[{id:"minecraft:cod",Count:1b,tag:{Enchantments:[{id:"minecraft:unbreaking",lvl:1}]}},{}],ArmorItems:[{id:"minecraft:leather_boots",Count:1b,tag:{display:{color:4159204},Enchantments:[{id:"minecraft:frost_walker",lvl:1}]}},{},{},{id:"minecraft:blue_ice",Count:1b}]}
effect give @e[tag=kitpvp.earth_skater] minecraft:slowness infinite 0 true
scoreboard players set @e[tag=kitpvp.earth_skater] kitpvp.earth_cd_a 20
