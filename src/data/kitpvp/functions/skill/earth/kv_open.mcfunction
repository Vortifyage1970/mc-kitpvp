# 地球·81 电压门控钾通道：到达 -55 mV，闸门打开
# 4 刻的开放期由 kv_tick 倒数；这里只负责开门、压电位、放音效和一圈粒子
scoreboard players set @s kitpvp.kv_state 1
scoreboard players set @s kitpvp.kv_ref 4
scoreboard players set @s kitpvp.kv_v -150
playsound minecraft:block.beacon.activate hostile @a[distance=..12] ~ ~ ~ 1.0 1.4
particle minecraft:end_rod ~ ~1.2 ~ 2.2 0.1 2.2 0.05 24 normal
