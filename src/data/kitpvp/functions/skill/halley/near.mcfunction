# 被动 2：攻击距离内有玩家 → 自己获得速度 II + 发光（每刻续 1 秒，离开自然消失）
# ⚠ 1.20.1 里 type= 只对 @e 生效，@a 上写 type 会让整份函数不加载；用 distance 下界排除自己
execute if entity @a[distance=0.5..3.5,tag=!kitpvp.spectator,scores={kitpvp.alive=1}] run effect give @s minecraft:speed 1 1 true
execute if entity @a[distance=0.5..3.5,tag=!kitpvp.spectator,scores={kitpvp.alive=1}] run effect give @s minecraft:glowing 1 0 true
