# ===== 纵火狂：投掷燃烧瓶（入口） =====
# 触发：tick.mcfunction 检测到"刚投出一个喷溅药水"
#       判据：kitpvp.arsonist_used > kitpvp.arsonist_last
# @s = 纵火狂
#
# ⚠ 首行必须是快照推进，漏写会造成每刻重复触发
#   药水统计 minecraft.used:minecraft.splash_potion 在本服只有纵火狂一个来源

scoreboard players operation @s kitpvp.arsonist_last = @s kitpvp.arsonist_used

# 弹药 -1，下限 0（防止把瓶子丢地上又被补回时计数被刷成负数）
execute if score @s kitpvp.arsonist_ammo matches 1.. run scoreboard players remove @s kitpvp.arsonist_ammo 1

# 投掷即进入 45 秒（900 刻）补货冷却
scoreboard players set @s kitpvp.cd 900

title @s actionbar {"text":"燃烧瓶已投出","color":"gold"}
playsound minecraft:entity.splash_potion.throw master @s ~ ~ ~ 0.8 1.0
