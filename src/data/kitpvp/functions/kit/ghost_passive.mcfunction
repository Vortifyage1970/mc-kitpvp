# ===== 幽灵永久被动：速度 I + 隐身 I =====
# 调用方：
#   kit/ghost          —— 选职业时
#   player/after_death —— 重生后重挂（clear_player 会 effect clear，需要补挂）
# 1.20.1 无"无限时长"效果，用超长 duration（999999 秒）近似；
# 高等级临时技能（如未来给幽灵的加速）到期后会自动回落到本函数的 I 级（见 05 §五）。

effect give @s minecraft:speed 999999 0 true
effect give @s minecraft:invisibility 999999 0 true
