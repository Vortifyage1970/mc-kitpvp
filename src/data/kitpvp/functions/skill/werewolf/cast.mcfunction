# 首行无条件推进快照，漏写会每刻连发；令牌是消耗品，用不等冷却，cd 只卡补货（同纵火狂）
scoreboard players operation @s kitpvp.werewolf_last = @s kitpvp.werewolf_used

# at @s 锚定后 distance 才是"玩家附近"；8 格覆盖刷怪蛋右键射程
execute at @s if entity @e[type=minecraft:wolf,tag=kitpvp.werewolf_token,distance=..8] run function kitpvp:skill/werewolf/fire
# 当场清掉令牌刷出的那只狼，不在场上留生物（game/reset 另有兜底）
execute at @s run kill @e[type=minecraft:wolf,tag=kitpvp.werewolf_token,distance=..16]
