# 地球·63 音符盒：音符盒当头的骷髅，每挨一下就打一个随机音符（乐器 + 音高都是随机的）
# 判"挨打"用血量下降（和篝火同一套思路）：nb_hp 每刻读一次，比 nb_prev 小就是这一帧掉了血
# 3 刻（0.15 秒）冷却：连击时是"哒哒哒"的鼓点，不会糊成一片；三个 objective 只在 load 里建一次
summon minecraft:skeleton ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_noteblock"],CustomName:'[{"text":"音符盒","color":"aqua"},{"text":" ❤","color":"red"},{"score":{"name":"@s","objective":"kitpvp.nb_hp1"},"color":"white"}]',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Health:20.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:20.0}],HandItems:[{},{}],ArmorItems:[{},{},{},{id:"minecraft:note_block",Count:1b}]}
execute as @e[tag=kitpvp.earth_noteblock] store result score @s kitpvp.nb_hp run data get entity @s Health 100
# 血量快照：nb_hp 是这一帧的真实值，nb_prev 初值给满血（2000 = 20.0 ×100），两者相等 ⇒ 不会一出生就误触发
execute as @e[tag=kitpvp.earth_noteblock] store result score @s kitpvp.nb_hp run data get entity @s Health 100
scoreboard players set @e[tag=kitpvp.earth_noteblock] kitpvp.nb_prev 2000
# 死亡守卫：隐形 marker 跟着它走，本体一消失（打死 / 被清场）就在原地播一段下落式连音
summon minecraft:marker ~ ~ ~ {Tags:["kitpvp.earth_noteblock_guard"]}
# ★ 必须埋 earth_cd_a 初值：tick 里拿 scores={kitpvp.earth_cd_a=..0} 当冷却门，
#   分数不存在时选择器根本不匹配 ⇒ 挨打也不会响（大蜜蜂当年就栽在这条上）
scoreboard players set @e[tag=kitpvp.earth_noteblock] kitpvp.earth_cd_a 0
