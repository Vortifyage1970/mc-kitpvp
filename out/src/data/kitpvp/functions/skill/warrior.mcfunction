# ===== 战士技能：补给 =====
# 用 minecraft.used:minecraft.golden_apple 统计精确检测"吃掉"事件：
#   - 丢地上：统计不动 → 不触发冷却、不补发
#   - 放箱子/交出：统计不动 → 同上
#   - 真正吃掉：统计 +1  → 由 warrior_consume 转入 40 秒冷却
#
# 状态机（只用一个 tag + 一个 cd）：
#   持有中   tag=kitpvp.skill_ready   cd = 0        已发 1 个，等玩家吃
#   冷却中   tag 已摘掉               cd = 800..1   正在走 40 秒
#   待补发   tag 已摘掉               cd = 0        冷却刚走完 → 本刻补发
#
# 调用方：tick.mcfunction -> skill/dispatch（cd<=0 时）
#   进入条件：kitpvp.kit=1 且 kitpvp.alive=1 且 kitpvp.cd <= 0

# 待补发状态 → 立刻发一份；否则什么都不做
execute if entity @s[tag=!kitpvp.skill_ready] run function kitpvp:skill/warrior_ready
