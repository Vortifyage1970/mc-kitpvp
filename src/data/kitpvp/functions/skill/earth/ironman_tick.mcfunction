# @s = 铁人（普通僵尸，走原版 AI）：只管炸弹节拍 —— 每 5 秒在身后一格丢一颗隐形小炸弹
# 冲量不在 tick 里做：铁人在丢炸弹那一下收到一次 Motion（见 ironman_bomb），之后交给原版物理
scoreboard players remove @s kitpvp.im_cd 1
execute if score @s kitpvp.im_cd matches ..0 run function kitpvp:skill/earth/ironman_bomb
execute if score @s kitpvp.im_cd matches ..0 run scoreboard players set @s kitpvp.im_cd 100
