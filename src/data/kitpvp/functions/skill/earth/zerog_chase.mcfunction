# @s = 无重力僵尸。NoGravity 让它永远 onGround=false ⇒ 地面寻路被整段跳过，它自己一步都不会走
# 所以这里用 tp 硬拖：先转向最近的玩家，再沿朝向迈 0.12 格（约 2.4 格/秒，接近普通僵尸）
# 贴到 1.5 格以内就停手，剩下交给它自己的近战 AI（攻击判定不看重力）
# 注意：朝向是朝玩家脚底，所以玩家在下方时它会往下飘；不想要就把它当成"只会平追"
execute as @e[tag=kitpvp.earth_zerog] at @s if entity @p[distance=..24,sort=nearest] run tp @s ~ ~ ~ facing entity @p[distance=..24,sort=nearest] feet
execute as @e[tag=kitpvp.earth_zerog] at @s if entity @p[distance=1.5..24,sort=nearest] run tp @s ^ ^ ^0.12
