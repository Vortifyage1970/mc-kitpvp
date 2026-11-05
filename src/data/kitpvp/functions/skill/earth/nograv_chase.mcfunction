# 统一处理"自己不会走"的无重力召唤物：无重力僵尸（earth_zerog）、泥土骑士的蠹虫（earth_dirtknight）
# 原因：NoGravity ⇒ 竖直永不落地 ⇒ onGround 恒 false ⇒ 原版地面寻路的 canUpdatePath() 返回 false，AI 想走也发不出位移
# 只能每刻 tp 硬拖：先转向最近玩家（24 格内），再沿朝向迈 0.12 格（≈2.4 格/秒）；贴到 1.5 格内就停，交给它自己的近战 AI
# ★ tp 不做碰撞检测：它会直线穿过墙和地形逼近，这是这套写法的固有特征
execute as @e[tag=kitpvp.earth_zerog] at @s if entity @p[distance=..24,sort=nearest] run tp @s ~ ~ ~ facing entity @p[distance=..24,sort=nearest] feet
execute as @e[tag=kitpvp.earth_zerog] at @s if entity @p[distance=1.5..24,sort=nearest] run tp @s ^ ^ ^0.12
execute as @e[tag=kitpvp.earth_dirtknight] at @s if entity @p[distance=..24,sort=nearest] run tp @s ~ ~ ~ facing entity @p[distance=..24,sort=nearest] feet
execute as @e[tag=kitpvp.earth_dirtknight] at @s if entity @p[distance=1.5..24,sort=nearest] run tp @s ^ ^ ^0.12