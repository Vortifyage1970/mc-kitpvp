# ===== 渔夫：发放"寻戟令牌"（溺尸刷怪蛋） =====
# 调用方：
#   kit/fisher          （选职业时）
#   tick.mcfunction     （令牌被用掉 / 丢失后的兜底补发）
#
# 令牌物品：minecraft:drowned_spawn_egg，带 KitFisherEgg:1b 标记
#   - 右键会生成一只溺尸（原版行为），并让 minecraft.used 统计 +1
#   - 生成的溺尸由 tick 立刻 kill 掉，不会留场
#   - 令牌本身不补三叉戟，补戟由 fisher_refill 执行
#
# ⚠ 令牌的 display.Name 会成为生成溺尸的 CustomName（原版行为，已实测），
#   所以 tick 的清怪行用 name="寻戟令牌" 精确匹配，不必另打 tag。
#
# 幂等：已经持有令牌时不再重复发放
# 判据：Inventory 数组里存在任一带 KitFisherEgg:1b 标记的物品

execute unless data entity @s Inventory[{tag:{KitFisherEgg:1b}}] run give @s minecraft:drowned_spawn_egg{KitFisherEgg:1b,display:{Name:'{"text":"寻戟令牌","color":"blue","bold":true}'}} 1
