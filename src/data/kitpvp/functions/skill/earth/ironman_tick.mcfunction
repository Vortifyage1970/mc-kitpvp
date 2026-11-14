# @s = 铁人（普通僵尸，走原版 AI）：只管炸弹节拍 —— 每 5 秒在脚边丢一颗小炸弹
scoreboard players remove @s kitpvp.im_cd 1
execute if score @s kitpvp.im_cd matches ..0 run function kitpvp:skill/earth/ironman_bomb
execute if score @s kitpvp.im_cd matches ..0 run scoreboard players set @s kitpvp.im_cd 100
