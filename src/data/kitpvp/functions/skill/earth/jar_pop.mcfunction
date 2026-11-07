# @s = 罐子的"守卫"标记（隐形 marker）：罐子已经不在了，就在守卫脚下摇一只随机生灵
# 不用尸体帧：本机实测尸体不到 1 刻就被移除，读不到 Health=0（木星、资本家都踩过这个坑）
# 主人编号每刻由 tick 从罐子抄到守卫身上，所以这里直接读 @s
tellraw @a {"text":"[罐子] 碎了","color":"gray"}
execute at @s run playsound minecraft:block.decorated_pot.shatter master @a ~ ~ ~ 2.0 1.0
execute at @s run playsound minecraft:block.decorated_pot.break master @a ~ ~ ~ 2.0 0.9
particle minecraft:poof ~ ~1 ~ 0.35 0.35 0.35 0.05 12 force
# 主人编号：没有 earth_owner 分的（手动 /function 召的）先补 0 再抄，否则 operation 会因源分缺失失败
scoreboard players add @s kitpvp.earth_owner 0
scoreboard players operation #jar_own kitpvp.game = @s kitpvp.earth_owner
# 走正式随机链路：random 自己摇 rng（0..75）、自己调 summon/<种类>，和玩家召唤用的是同一套
function kitpvp:skill/earth/random
# 新生的那只没有主人（link 没跑）。24 格内所有"还没主人 + 刚出生"的生灵，把罐子的主人编号抄过去。
# 不用 3 格半径：飞行器、支援者这类会在出生后几刻内被挪到十几二十格高，3 格够不着
scoreboard players add @e[tag=kitpvp.earth_minion_new,distance=..24] kitpvp.earth_owner 0
scoreboard players operation @e[tag=kitpvp.earth_minion_new,distance=..24,scores={kitpvp.earth_owner=..0}] kitpvp.earth_owner = #jar_own kitpvp.game
# 队伍也要跟着抄：不攻击召唤者靠的是同队，光有 earth_owner 不够（草丛、电磁炮那套才读这个分）
execute if score #jar_own kitpvp.game matches 1 run team join earth_1 @e[tag=kitpvp.earth_minion_new,distance=..24]
execute if score #jar_own kitpvp.game matches 2 run team join earth_2 @e[tag=kitpvp.earth_minion_new,distance=..24]
execute if score #jar_own kitpvp.game matches 3 run team join earth_3 @e[tag=kitpvp.earth_minion_new,distance=..24]
execute if score #jar_own kitpvp.game matches 4 run team join earth_4 @e[tag=kitpvp.earth_minion_new,distance=..24]
execute if score #jar_own kitpvp.game matches 5 run team join earth_5 @e[tag=kitpvp.earth_minion_new,distance=..24]
execute if score #jar_own kitpvp.game matches 6 run team join earth_6 @e[tag=kitpvp.earth_minion_new,distance=..24]
# 和 link 一样收尾：这个 tag 是"本次召唤"的一次性标记，留着会让别家 link 再认领一次
tag @e remove kitpvp.earth_minion_new
# 守卫用完自毁
kill @s
