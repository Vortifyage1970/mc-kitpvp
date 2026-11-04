# 常态 +0.2 移动速度：玩家基础 0.1 → 0.3（加法修饰符，不是 Speed 效果）
# 重生时属性修饰符可能已被原版清除；先移除同 UUID 再添加，确保重复调用也不会叠加
# 常态最大生命 -7.5：20 → 12.5，与是否手持石剑无关（clear_player 会复位成 20）
attribute @s minecraft:generic.max_health base set 12.5
attribute @s minecraft:generic.movement_speed modifier remove 00000000-0000-0000-0000-000000000066
attribute @s minecraft:generic.movement_speed modifier add 00000000-0000-0000-0000-000000000066 kitpvp.mercury_speed 0.2 add
