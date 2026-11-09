# 地球·81 电压门控钾通道：每刻的状态机（@s = 通道本体，tick.mcfunction 已经 at @s 给好位置）
# state 0 静息：电位 kv_v 每刻 +1；被打一下额外 +8（HurtTime 只在受伤那一刻等于 9，一刀只算一次）
# state 1 开放：kv_ref 从 4 倒数，每刻电火花 + 6 格内的人被"钾外流"按住（缓慢 II / 2 秒）
# state 2 不应期：kv_ref 从 60 倒数，谁打都不催它，到点回 -140 重新静息
# 主人不该被自己的通道按住：owner 有效时按 etid 排除（owner 0/空时谁都算目标，手动召唤也能用）
scoreboard players set #kv_own kitpvp.game -1
execute if score @s kitpvp.earth_owner matches 1.. run scoreboard players operation #kv_own kitpvp.game = @s kitpvp.earth_owner

# —— 静息：去极化 ——
execute if score @s kitpvp.kv_state matches 0 run scoreboard players add @s kitpvp.kv_v 1
execute if score @s kitpvp.kv_state matches 0 if entity @s[nbt={HurtTime:9s}] run scoreboard players add @s kitpvp.kv_v 8
execute if score @s kitpvp.kv_state matches 0 if score @s kitpvp.kv_v matches -80.. run particle minecraft:dust 0.35 0.75 1.0 1 ~ ~1.35 ~ 0.3 0.3 0.3 0.01 3 normal

# —— 开放：钾外流 ——
execute if score @s kitpvp.kv_state matches 1 run particle minecraft:electric_spark ~ ~1.2 ~ 1.1 0.8 1.1 0.02 10 normal
execute if score @s kitpvp.kv_state matches 1 run particle minecraft:end_rod ~ ~1.2 ~ 0.9 0.7 0.9 0.02 6 normal
execute if score @s kitpvp.kv_state matches 1 as @a[distance=..6,gamemode=!creative,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] unless score @s kitpvp.etid = #kv_own run effect give @s minecraft:slowness 40 1 true
execute if score @s kitpvp.kv_state matches 1 run scoreboard players remove @s kitpvp.kv_ref 1

# —— 不应期：暗下去，只留一点灰粒子 ——
execute if score @s kitpvp.kv_state matches 2 run scoreboard players remove @s kitpvp.kv_ref 1
execute if score @s kitpvp.kv_state matches 2 run particle minecraft:dust 0.2 0.25 0.3 1 ~ ~1.35 ~ 0.2 0.2 0.2 0.01 1 normal

# —— 状态切换（放最后：开放/关闭的当刻行为由上面那几段下一刻接手）——
execute if score @s kitpvp.kv_state matches 0 if score @s kitpvp.kv_v matches -55.. run function kitpvp:skill/earth/kv_open
execute if score @s kitpvp.kv_state matches 1 if score @s kitpvp.kv_ref matches ..0 run function kitpvp:skill/earth/kv_close
execute if score @s kitpvp.kv_state matches 2 if score @s kitpvp.kv_ref matches ..0 run scoreboard players set @s kitpvp.kv_state 0
execute if score @s kitpvp.kv_state matches 0 if score @s kitpvp.kv_v matches ..-141 run scoreboard players set @s kitpvp.kv_v -140
