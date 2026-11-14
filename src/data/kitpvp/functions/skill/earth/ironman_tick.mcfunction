# @s = 铁人（NoAI 僵尸）：每刻由命令驱着走向"最近的、不是召唤者的"活玩家；每 5 秒在脚边丢一颗小炸弹
# 目标筛选：先给召唤者挂临时 tag，选目标时排除掉（和 nograv_step 同一个坑：不排除就会绕着主人转）
scoreboard players set #im_owner kitpvp.game 0
scoreboard players operation #im_owner kitpvp.game = @s kitpvp.earth_owner
tag @a remove kitpvp.im_owner
execute if score #im_owner kitpvp.game matches 1.. as @a if score @s kitpvp.etid = #im_owner kitpvp.game run tag @s add kitpvp.im_owner
# 走位：1.6 格内停下（贴身会自己踩炸），40 格内每刻挪 0.12 格（≈2.4 格/秒，比玩家冲刺慢，追得上走位不上的）
execute if entity @p[distance=1.6..40,sort=nearest,gamemode=!creative,gamemode=!spectator,tag=!kitpvp.spectator,tag=!kitpvp.im_owner,nbt=!{Health:0.0f}] facing entity @p[distance=1.6..40,sort=nearest,gamemode=!creative,gamemode=!spectator,tag=!kitpvp.spectator,tag=!kitpvp.im_owner,nbt=!{Health:0.0f}] feet run tp @s ^ ^ ^0.12
# 找不到近处的人就原地待着（NoAI ⇒ 不会自己乱走）
tag @a remove kitpvp.im_owner
# 炸弹节拍：100 刻（5 秒）一颗，丢在脚边
scoreboard players remove @s kitpvp.im_cd 1
execute if score @s kitpvp.im_cd matches ..0 run function kitpvp:skill/earth/ironman_bomb
execute if score @s kitpvp.im_cd matches ..0 run scoreboard players set @s kitpvp.im_cd 100
