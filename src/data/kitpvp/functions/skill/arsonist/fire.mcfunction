# last 推进已在 arsonist_cast 里做完，本函数不重复
# 令牌是消耗品：投出不等冷却、也不碰 cd 与弹药数；余量由 skill/arsonist/auto 用 clear ... 0 读真值（见 03 §2.13）

title @s actionbar {"text":"燃烧瓶已投出","color":"gold"}
playsound minecraft:entity.splash_potion.throw master @s ~ ~ ~ 0.8 1.0
