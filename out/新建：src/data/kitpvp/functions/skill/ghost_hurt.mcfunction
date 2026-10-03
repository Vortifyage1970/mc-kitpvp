# ===== 幽灵：受伤反馈 =====
# 每次受到伤害时获得 1 秒发光效果（把自己的位置暴露出来）
# 调用方：tick.mcfunction 的"幽灵：受伤检测"行
#
# ⚠ 首行必须是快照推进：不推进，下一刻 damage_taken > last 依旧成立，
#   发光会被每刻重新挂上，等于永不熄灭。
#   （这也是 04-hazards-reminder 里"快照推进首行铁律"的通用做法，
#    只是判据从 minecraft.used: 换成了 minecraft.custom:minecraft.damage_taken）
scoreboard players operation @s kitpvp.ghost_damage_last = @s kitpvp.ghost_damage

# 给 1 秒发光（amplifier 0 = I 级，true = 隐藏粒子）
effect give @s minecraft:glowing 1 0 true
