# 无敌 / 虚空 / 死亡
scoreboard players add @a kitpvp.inv 0
execute as @a[scores={kitpvp.inv=1..}] run scoreboard players remove @s kitpvp.inv 1
execute as @a[tag=kitpvp.invincible,scores={kitpvp.inv=0}] run function kitpvp:player/end_invincible
# 虚空兜底：y=-1024 配 dy=950 覆盖 y ∈ [-1024,-74]；改阈值只改 dy
execute as @a[tag=kitpvp.selected,tag=!kitpvp.spectator,gamemode=!spectator] if entity @s[y=-1024,dy=950] run damage @s 1000 minecraft:out_of_world
execute as @a[tag=!kitpvp.spectator,tag=!kitpvp.respawn_pending] if score @s kitpvp.death_detect > @s kitpvp.death_seen run function kitpvp:player/death_dispatch
# 死亡检测落在死亡那一 tick，但重生由客户端重生包驱动、要晚至少 1 刻，且重生会清空全部药水效果。
# 所以必须等 Health 归位（真正重生完成）再挂无敌与被动，否则等于没挂（见 04 第六节）。
execute as @a[tag=kitpvp.respawn_pending,tag=!kitpvp.spectator] unless entity @s[nbt={Health:0.0f}] run function kitpvp:player/after_death

# 胜负判定：必须排在死亡处理之后——同刻互杀要等两人都淘汰完再统计，
# 否则会先看到"幸存者=1"而误判胜者；同时覆盖掉线减员的兜底
execute if score #state kitpvp.game matches 1 run function kitpvp:game/check_winner
