# 地球·41 门槛哥：头戴深色橡木活板门、双手各一扇锋利 II 的深色橡木门
# 死亡时在原地立起一扇深色橡木门 —— 靠脚下跟着走的隐形 marker 判定（尸体一瞬就没了，读不到 Health=0）
# 门的放置与收尾在 skill/earth/threshold_death；guard 跟着本体移动的线写在 tick 里
summon minecraft:zombie ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_threshold"],CustomName:'{"text":"门槛哥","color":"dark_gray"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,HandItems:[{id:"minecraft:dark_oak_door",Count:1b,tag:{Enchantments:[{id:"minecraft:sharpness",lvl:2}]}},{id:"minecraft:dark_oak_door",Count:1b,tag:{Enchantments:[{id:"minecraft:sharpness",lvl:2}]}}],ArmorItems:[{},{},{},{id:"minecraft:dark_oak_trapdoor",Count:1b}]}
summon minecraft:marker ~ ~ ~ {Tags:["kitpvp.earth_threshold_guard"]}