# 末影珍珠的传送是原版行为，本函数不接管。
# 令牌是消耗品，但"用掉一颗就要等满一个补货间隔"：投出就进冷却，不能当场补回来。

title @s actionbar {"text":"末影之珠已投出","color":"dark_purple"}
playsound minecraft:entity.ender_pearl.throw master @s ~ ~ ~ 0.8 1.2

# ..0 守卫：计时中再投不重置，否则连投会把补货推得越来越远（见 03 §2.13）
execute if score @s kitpvp.cd matches ..0 run scoreboard players set @s kitpvp.cd 500
