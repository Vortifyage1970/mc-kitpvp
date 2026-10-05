# ===== 纵火狂 =====
# 投掷燃烧瓶检测（统计 objective）
execute as @a[scores={kitpvp.kit=5,kitpvp.alive=1},tag=!kitpvp.spectator] if score @s kitpvp.arsonist_used > @s kitpvp.arsonist_last run function kitpvp:skill/arsonist_cast

# 燃烧瓶即将落地 → 铺火
# @e 选择器依赖药水实体的 Item.tag，只有带 KitFireBomb 标记的喷溅药水会被捕捉
execute as @e[type=minecraft:potion,nbt={Item:{tag:{KitFireBomb:1b}}},tag=!kitpvp.arsonist_burst] at @s unless block ~ ~-0.5 ~ air unless block ~ ~-0.5 ~ cave_air unless block ~ ~-0.5 ~ void_air run function kitpvp:skill/arsonist_burst

# 掉进虚空的燃烧瓶直接清掉，不放火
# 副作用：只会命中药水实体，不涉及其它实体
kill @e[type=minecraft:potion,nbt={Item:{tag:{KitFireBomb:1b}}},y=-100,dy=100]

# 火焰 5 秒保护
function kitpvp:skill/arsonist_flame_tick
