# @s = 音符盒的死亡守卫：本体已经不在 3 格内了 ⇒ 在原地放一个"弹音器"，再自毁
# ★ 不能直接 schedule 连音：schedule 调起来的函数没有位置上下文，playsound 的 ~ ~ ~ 会落在世界原点
#   （0,0,0 附近没人，@a[distance=..32] 一个都选不中 ⇒ 音效"消失"）。所以留一个 marker 记住死亡地点，
#   由 tick 每刻带着 at @s 调 noteblock_cascade。
summon minecraft:marker ~ ~0.5 ~ {Tags:["kitpvp.nb_dying"]}
scoreboard players set @e[tag=kitpvp.nb_dying,limit=1,sort=nearest] kitpvp.nb_step 0
particle minecraft:note ~ ~0.5 ~ 0.4 0.4 0.4 1 12
kill @s
