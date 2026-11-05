# 地球·40 滑冰者：蓝冰当头的骷髅，脚上是染成蓝色、带冰霜行者 I 的皮革靴，手持附魔生鱼；常驻缓慢 I
# ★ 本体用 stray（冰骷髅）而不是 skeleton：它在 freeze_immune_entity_types 里，自己脚下那格细雪冻不着它
# ★ 细雪由 skill/earth/skater_ice 每秒在脚下空气处铺一格，永久保留（清场靠 map restore）
# ★ 手里那条鱼：原版没有"蓝色的生鱼"这个物品（display.color 只对皮革护甲生效），所以是改名成蓝色文字的 cod，纹理仍是生鱼
# ★ NoAI 已撤：恢复正常 AI —— 会追人、会近战，也会像骷髅那样射箭（1.20.1 的射击 AI 不检查手里有没有弓）
summon minecraft:stray ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_skater"],CustomName:'{"text":"滑冰者","color":"aqua"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,HandItems:[{id:"minecraft:cod",Count:1b,tag:{Enchantments:[{id:"minecraft:unbreaking",lvl:1}],display:{Name:'{"text":"蓝色的生鱼","color":"blue","italic":false}'}}},{}],ArmorItems:[{id:"minecraft:leather_boots",Count:1b,tag:{display:{color:4159204},Enchantments:[{id:"minecraft:frost_walker",lvl:1}]}},{},{},{id:"minecraft:blue_ice",Count:1b}]}
effect give @e[tag=kitpvp.earth_skater] minecraft:slowness infinite 0 true
scoreboard players set @e[tag=kitpvp.earth_skater] kitpvp.earth_cd_a 20
# 滑行音效计时（2 秒一声；分数不存在的话 scores={..0} 选择器不匹配，会一直不响）
scoreboard players set @e[tag=kitpvp.earth_skater] kitpvp.skater_snd 40
