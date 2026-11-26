# @s = 被日蚀锁定的玩家：一次性 20 秒失明 + 一个跟着他走的倒计时
effect give @s minecraft:blindness 20 0 true
tag @s add kitpvp.sun_hit
scoreboard players set @s kitpvp.sun_hit_timer 400
scoreboard players set @s kitpvp.sun_hit_next 20
