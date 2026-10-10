# ===== 渔夫：判定是否补戟 =====
# 调用方：skill/fisher_cast（玩家右键寻戟令牌，cd 归零时）
# @s = 渔夫
#
# 三分支，互斥，用「当前刻的背包状态 + 无戟计时器」一次判完：
#   ① 背包里已有带 KitFisherTrident 标记的三叉戟
#      → 提示"已持有"，不进冷却
#      （技能没生效，不该罚冷却；被消耗的令牌会在下一 tick 由 tick 兜底补回）
#
#   ② 背包里没有，但计时器 kitpvp.fisher_no_tri < 160（不足 8 秒）
#      → 说明三叉戟只是"暂时离手"（投出飞行中 / 刚被消耗等）
#      → 提示"尚未离场"，不进冷却
#
#   ③ 背包里没有，且计时器 >= 160
#      → 三叉戟已在背包外持续 8 秒以上，转交 fisher_refill 补一把并进冷却
#
# ⚠ 三条分支必须在同一刻读同一份背包状态；
#   一旦 refill 给了戟，后续任何"背包检查"都会看到新给的那把而自骗。
#   所以 Inventory 判断全部放最前，不给 refill 抢跑的机会。

execute if data entity @s Inventory[{tag:{KitFisherTrident:1b}}] run title @s actionbar {"text":"你已持有三叉戟","color":"gray"}

execute unless data entity @s Inventory[{tag:{KitFisherTrident:1b}}] unless score @s kitpvp.fisher_no_tri matches 160.. run title @s actionbar {"text":"三叉戟尚未离场","color":"gray"}

execute unless data entity @s Inventory[{tag:{KitFisherTrident:1b}}] if score @s kitpvp.fisher_no_tri matches 160.. run function kitpvp:skill/fisher_refill

