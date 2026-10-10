# ===== 渔夫：判定是否补戟 =====
# 调用方：skill/fisher_cast（玩家右键寻戟令牌，cd 归零时）
# @s = 渔夫
#
# 两条互斥分支：
#   ① 已持有带 KitFisherTrident 标记的三叉戟 → 仅提示，不进冷却
#      （技能没生效，不该罚冷却；被消耗的令牌会在下一 tick 由 tick 兜底补回）
#   ② 未持有 → 转交 skill/fisher_refill 补一把，由后者进 60 秒冷却
#
# ⚠ ① 必须写在 ② 之前：refill 里会 give 一把戟，一旦给了，
#   背包检查立刻变"有戟"，后面的分支如果还用同一条件判断就会被自己骗到。
#   所以"是否补发"这层判断只做一次，在给物品之前。

execute if data entity @s Inventory[{tag:{KitFisherTrident:1b}}] run title @s actionbar {"text":"你已持有三叉戟","color":"gray"}
execute unless data entity @s Inventory[{tag:{KitFisherTrident:1b}}] run function kitpvp:skill/fisher_refill
