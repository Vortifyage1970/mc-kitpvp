# ===== 幽灵：永久被动效果 =====
# 隐身 I + 速度 I，常态挂着
# 死亡会清空玩家的全部药水效果，重生后由 player/after_death 重新挂上
# 调用方：
#   kit/ghost              （选职业时）
#   player/after_death     （重生之后）
#
# ⚠ 1.20.1 没有"无限时长效果"，infinite 关键字是 1.20.2+ 才有。
#   用 999999 秒近似（≈11.5 天，长于一局比赛）。
#   amplifier 0 = I 级；true = 隐藏粒子
#
# ⚠ 隐身只隐藏玩家皮肤，不隐藏装备。
#   头盔、手持武器、装甲仍会露出，这是原版机制，不是 bug。

effect give @s minecraft:invisibility 999999 0 true
effect give @s minecraft:speed 999999 0 true
