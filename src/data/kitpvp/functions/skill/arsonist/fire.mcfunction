# last 推进已在 arsonist_cast 里做完，本函数不重复
# 令牌是消耗品，但"用掉一个就要等满一个补货间隔"：投出就进冷却，不能当场补回来

title @s actionbar {"text":"燃烧瓶已投出","color":"gold"}
playsound minecraft:entity.splash_potion.throw master @s ~ ~ ~ 0.8 1.0

# ..0 守卫：计时中再投不重置，否则连投会把补货推得越来越远（见 03 §2.13）
execute if score @s kitpvp.cd matches ..0 run scoreboard players set @s kitpvp.cd 900
