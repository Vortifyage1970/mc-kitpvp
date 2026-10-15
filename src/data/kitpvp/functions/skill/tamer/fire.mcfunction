# 放狼本身是原版行为，这里只做一件事：用掉一个就开始补货计时——满仓放一个也照样进冷却，不会当场补回来。
# ..0 守卫：计时中再放不重置，否则连续放会把补货推得越来越远（见 03 §2.13）
execute if score @s kitpvp.cd matches ..0 run scoreboard players set @s kitpvp.cd 600
