# @s = 反装甲步兵（as @s at @s）：装填到 60 刻就开炮，开炮后 60 刻是速度 I 的抢位窗口
# 为什么用 at_charge 一个分数兼做两种状态：>= 0 是装填，-60..-1 是开炮后的跑位期，走到 0 正好接回缓慢 III
scoreboard players set #at_own kitpvp.game 0
scoreboard players operation #at_own kitpvp.game = @s kitpvp.earth_owner

# 选靶：20 格内的活人，有明确主人时排除主人；无主（指令/魂石召的）时谁都算
tag @a remove kitpvp.at_tgt
execute if score #at_own kitpvp.game matches 1.. as @a[distance=..20,gamemode=!creative,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] unless score @s kitpvp.etid = #at_own kitpvp.game run tag @s add kitpvp.at_tgt
execute unless score #at_own kitpvp.game matches 1.. as @a[distance=..20,gamemode=!creative,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] run tag @s add kitpvp.at_tgt

# 装填：只在"装填状态 且 有靶子"时推进，封顶 60（3 秒）
execute if score @s kitpvp.at_charge matches 0.. if entity @a[tag=kitpvp.at_tgt,distance=..20] run scoreboard players add @s kitpvp.at_charge 1
execute if score @s kitpvp.at_charge matches 61.. run scoreboard players set @s kitpvp.at_charge 60

# 装填满：开一炮（fire 里会把 at_charge 压到 -60、摘掉缓慢、给速度 I）
execute if score @s kitpvp.at_charge matches 60 at @s run function kitpvp:skill/earth/antitank_fire

# 跑位结束（-60 走到 0 的那一帧）：缓慢 III 接回来，重新装填
execute if score @s kitpvp.at_charge matches 0 run effect give @s minecraft:slowness infinite 2 true
