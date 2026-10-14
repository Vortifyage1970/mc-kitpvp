# 每 20 刻调用一次；@s = 一名已进入突然死亡的存活玩家
# 间隔按剩余命数：3 命 45 秒（900 刻）/ 2 命 35 秒（700）/ 1 命 25 秒（500）
# 掉命当刻就收紧倒计时，否则 3 命转 1 命还要把旧的 45 秒走完
execute if score @s kitpvp.lives matches 2 if score @s kitpvp.soul_next matches 701.. run scoreboard players set @s kitpvp.soul_next 700
execute if score @s kitpvp.lives matches ..1 if score @s kitpvp.soul_next matches 501.. run scoreboard players set @s kitpvp.soul_next 500

scoreboard players remove @s kitpvp.soul_next 20

execute if score @s kitpvp.soul_next matches ..0 run function kitpvp:skill/soul/give
# ..1 兜住 0 / 负命数，保证倒计时一定会被重新装载，不会每秒连发
execute if score @s kitpvp.soul_next matches ..0 if score @s kitpvp.lives matches 3.. run scoreboard players set @s kitpvp.soul_next 900
execute if score @s kitpvp.soul_next matches ..0 if score @s kitpvp.lives matches 2 run scoreboard players set @s kitpvp.soul_next 700
execute if score @s kitpvp.soul_next matches ..0 if score @s kitpvp.lives matches ..1 run scoreboard players set @s kitpvp.soul_next 500
