# 地球·81 电压门控钾通道：开放期结束，进入不应期
scoreboard players set @s kitpvp.kv_state 2
scoreboard players set @s kitpvp.kv_ref 60
scoreboard players set @s kitpvp.kv_v -150
playsound minecraft:block.conduit.deactivate hostile @a[distance=..12] ~ ~ ~ 0.8 1.2
particle minecraft:dust 0.2 0.3 0.45 1 ~ ~1.2 ~ 1.4 0.1 1.4 0.02 18 normal
