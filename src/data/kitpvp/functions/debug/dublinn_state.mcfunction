# 用法：站在深池飞行兵旁边跑 /function kitpvp:debug/dublinn_state
# 读法：飞行兵数=0 ⇒ 没召出来/被清掉了；我的 etid 与 主人 相同 ⇒ 它就是"你的"召唤物，按设计不打你
scoreboard players set #dl_dbg kitpvp.game 0
execute store result score #dl_dbg kitpvp.game if entity @e[tag=kitpvp.earth_dublinn,distance=..16]
scoreboard players set #dl_dbg_owner kitpvp.game -1
scoreboard players operation #dl_dbg_owner kitpvp.game = @e[tag=kitpvp.earth_dublinn,distance=..16,sort=nearest,limit=1] kitpvp.earth_owner
scoreboard players set #dl_dbg_cd kitpvp.game -1
scoreboard players operation #dl_dbg_cd kitpvp.game = @e[tag=kitpvp.earth_dublinn,distance=..16,sort=nearest,limit=1] kitpvp.earth_cd_a
tellraw @s [{"text":"[深池] 16 格内飞行兵：","color":"gray"},{"score":{"name":"#dl_dbg","objective":"kitpvp.game"},"color":"yellow"},{"text":"  最近那只的主人 etid：","color":"gray"},{"score":{"name":"#dl_dbg_owner","objective":"kitpvp.game"},"color":"aqua"}]
tellraw @s [{"text":"[深池] 最近那只的出手冷却：","color":"gray"},{"score":{"name":"#dl_dbg_cd","objective":"kitpvp.game"},"color":"yellow"},{"text":"（≥1 = 正在冷却中，≤0 = 下一刻就出手）","color":"dark_gray"}]
tellraw @s [{"text":"[深池] 我自己的 etid：","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.etid"},"color":"aqua"},{"text":"（= 主人时它不会打你，这是设计）","color":"dark_gray"}]
