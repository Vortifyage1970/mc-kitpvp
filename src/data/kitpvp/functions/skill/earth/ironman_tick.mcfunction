# @s = 铁人（普通僵尸，走原版 AI）：炸弹节拍 + 被自己屁股后面那颗炸弹顶出去（冲量 4 刻）
# 冲量：炸弹在身后一格爆，方向就是朝向 ⇒ 每刻沿视线推 0.7 格、抬 0.08 格，4 刻约 2.8 格
# （用 tp 而不是 Motion 是刻意的：生物每刻的 AI travel 会覆盖掉真实速度，只有位置改动留得住）
execute if score @s kitpvp.im_push matches 1.. at @s run tp @s ^ ^0.08 ^0.7
execute if score @s kitpvp.im_push matches 1.. run scoreboard players remove @s kitpvp.im_push 1
# 炸弹节拍：100 刻（5 秒）一颗
scoreboard players remove @s kitpvp.im_cd 1
execute if score @s kitpvp.im_cd matches ..0 run function kitpvp:skill/earth/ironman_bomb
execute if score @s kitpvp.im_cd matches ..0 run scoreboard players set @s kitpvp.im_cd 100
