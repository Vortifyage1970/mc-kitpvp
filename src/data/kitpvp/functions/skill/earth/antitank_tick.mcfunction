# @s = 反装甲步兵（as @s at @s）：装填 60 刻打「唯一的一炮」，之后永久速度 I，不再装填
# at_shot 0 = 还没开炮（缓慢 III 状态下装填），1 = 已经打完，永久速度 I
scoreboard players set #at_own kitpvp.game 0
scoreboard players operation #at_own kitpvp.game = @s kitpvp.earth_owner

# 选靶：20 格内的活人，有明确主人时排除主人；无主（指令/魂石召的）时谁都算
tag @a remove kitpvp.at_tgt
execute if score #at_own kitpvp.game matches 1.. as @a[distance=..20,gamemode=!creative,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] unless score @s kitpvp.etid = #at_own kitpvp.game run tag @s add kitpvp.at_tgt
execute unless score #at_own kitpvp.game matches 1.. as @a[distance=..20,gamemode=!creative,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] run tag @s add kitpvp.at_tgt

# 装填：只在"还没开过炮 且 有靶子"时推进，封顶 60（3 秒）
execute if score @s kitpvp.at_shot matches 0 if score @s kitpvp.at_charge matches 0.. if entity @a[tag=kitpvp.at_tgt,distance=..20] run scoreboard players add @s kitpvp.at_charge 1
execute if score @s kitpvp.at_shot matches 0 if score @s kitpvp.at_charge matches 61.. run scoreboard players set @s kitpvp.at_charge 60

# 装填满：开这一炮（fire 里把 at_shot 置 1、摘掉缓慢、永久速度 I）
execute if score @s kitpvp.at_shot matches 0 if score @s kitpvp.at_charge matches 60 at @s run function kitpvp:skill/earth/antitank_fire
