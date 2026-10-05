# ===== 纵火狂 =====
# 喷溅药水本服有多个来源（纵火狂本体、后续药剂师、魂石、野刷），
# minecraft.used:splash_potion 只能当粗筛信号，不能单独作为施法依据。
# 分流方式：
#   A. 每刻把"上一刻手持燃烧瓶"记进 kitpvp.hold_fb_prev
#   B. 每刻重建"当前手持燃烧瓶"= kitpvp.hold_fb
#   C. 只要有喷溅药水投掷（used 增长）就调 arsonist_cast；
#      "是不是燃烧瓶"由 cast 内部用 hold_fb_prev 决定
# ⚠ C 的调用条件里绝对不能加 hold_fb_prev：否则投其它药水时 last 不推进，
#   之后切到燃烧瓶会把历史投掷当成新投掷，误触发一次施法。

# A. 推进 prev（引用上一刻的 hold_fb）
tag @a remove kitpvp.hold_fb_prev
tag @a[tag=kitpvp.hold_fb] add kitpvp.hold_fb_prev

# B. 重建当前刻 hold_fb
tag @a remove kitpvp.hold_fb
execute as @a if data entity @s SelectedItem.tag.KitFireBomb run tag @s add kitpvp.hold_fb

# C. 投掷入口（无条件调用，由 cast 内部用 hold_fb_prev 分流）
execute as @a[scores={kitpvp.kit=5,kitpvp.alive=1},tag=!kitpvp.spectator] if score @s kitpvp.arsonist_used > @s kitpvp.arsonist_last run function kitpvp:skill/arsonist_cast

# 燃烧瓶即将落地 → 铺火
execute as @e[type=minecraft:potion,nbt={Item:{tag:{KitFireBomb:1b}}},tag=!kitpvp.arsonist_burst] at @s unless block ~ ~-0.5 ~ air unless block ~ ~-0.5 ~ cave_air unless block ~ ~-0.5 ~ void_air run function kitpvp:skill/arsonist_burst

# 掉进虚空的燃烧瓶
kill @e[type=minecraft:potion,nbt={Item:{tag:{KitFireBomb:1b}}},y=-100,dy=100]

# 火焰 5 秒保护
function kitpvp:skill/arsonist_flame_tick
