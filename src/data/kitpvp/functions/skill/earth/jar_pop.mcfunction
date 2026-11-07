# @s = 刚被打死的罐子（尸体还在的那几刻：Health:0.0f），at 它身上执行
# ★ 先打标记：尸体要播约 20 刻死亡动画，不打标记这一条会连摇十几次，一次刷出十几只
tag @s add kitpvp.jar_popped
# 主人编号：没有 earth_owner 分的罐子（手动 /function、魂石召的）先补 0 再抄，否则 operation 会因源分缺失失败
scoreboard players add @s kitpvp.earth_owner 0
scoreboard players operation #jar_own kitpvp.game = @s kitpvp.earth_owner
# 走正式随机链路：random 自己摇 rng（0..73）、自己调 summon/<种类>，和玩家召唤用的是同一套
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
