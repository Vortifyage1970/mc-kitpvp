# @s = 篝火：刚被打了（HurtTime ≥ 1）且当前处于"待点火"（fire_left ≤ 0）⇒ 点着 5 秒
scoreboard players set @s kitpvp.fire_left 100
data merge entity @s {Fire:100s}
playsound minecraft:item.firecharge.use master @a[distance=..24] ~ ~ ~ 1.0 1.1
playsound minecraft:block.fire.ambient master @a[distance=..24] ~ ~ ~ 0.8 1.0
particle minecraft:flame ~ ~1 ~ 0.6 0.8 0.6 0.02 30
particle minecraft:smoke ~ ~1.2 ~ 0.6 0.8 0.6 0.01 12
# 兜底：近身打它的人一定在 3.5 格内 —— advancement 那条走"谁打中它"最精确，但这里再补一次，
# 保证至少近战的人一定被点着（远程箭伤仍由 advancement 负责）；玩家不能改 NBT，所以用 burn_left 计时器
execute at @s run scoreboard players set @a[distance=..3.5,gamemode=!creative,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] kitpvp.burn_left 100
