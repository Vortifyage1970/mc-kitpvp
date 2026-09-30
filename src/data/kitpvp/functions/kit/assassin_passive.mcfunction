# ===== 刺客：永久被动效果 =====
# 死亡会清空玩家的全部药水效果，重生后需要重新挂上
# 调用方：
#   kit/assassin            （选职业时）
#   player/after_death      （重生之后）
#   skill/assassin_unhide   （隐匿结束时，恢复被速度 III 顶掉的速度 I）
#
# ⚠ 1.20.1 没有"无限时长效果"，infinite 关键字是 1.20.2+ 才有。
#   用 999999 秒近似（≈11.5 天，长于一局比赛）。
#   amplifier 0 = I 级；true = 隐藏粒子
#
# ⚠ 隐匿技能会临时给 speed III(amp 2)，会顶掉这里的 speed I，
#   隐匿结束后由 skill/assassin_unhide 重新挂回本效果。

effect give @s minecraft:speed 999999 0 true
