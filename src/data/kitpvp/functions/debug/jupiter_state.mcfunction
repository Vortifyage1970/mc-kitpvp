# 木星状态速查：/function kitpvp:debug/jupiter_state
# 每只木星打印：血量分（Health×100，0 = 已死）、是否已经放过雷、坐标
# 再打印世界里现存的雷电实体数量 —— 有雷但没伤害，说明 summon 成功、只是别的地方没跑到
tellraw @a [{"text":"=== 木星状态 ===","color":"gold"}]
execute as @e[tag=kitpvp.earth_jupiter] run tellraw @a [{"text":"  hp=","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.earth_hp"}},{"text":"  已放雷=","color":"gray"},{"selector":"@s[tag=kitpvp.earth_jupiter_struck]"},{"text":"  pos=","color":"gray"},{"nbt":"Pos","entity":"@s"}]
tellraw @a [{"text":"  现存雷电实体：","color":"gray"},{"selector":"@e[type=minecraft:lightning_bolt]"},{"text":"  （空 = 一道都没生成）","color":"dark_gray"}]
tellraw @a [{"text":"  提示：hp 一直是 0 且没有雷 = tick 那条没跑；有雷没伤害 = 雷生成成功","color":"dark_gray"}]
