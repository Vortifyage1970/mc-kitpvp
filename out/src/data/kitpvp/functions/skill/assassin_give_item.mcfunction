# ===== 刺客：发放"隐匿令牌"（末影人刷怪蛋） =====
# 调用方：
#   kit/assassin        （选职业时）
#   tick.mcfunction     （令牌被用掉 / 丢失后的兜底补发）
#
# 令牌物品：minecraft:enderman_spawn_egg，带 KitAssassinEgg:1b 标记
#   - 右键会生成一只末影人（原版行为），并让 minecraft.used 统计 +1
#   - 生成的末影人由 tick 立刻 kill 掉，不会留场
#   - 令牌本身不产生隐身/速度，所有效果由 assassin_fire 给
#
# 幂等：已经持有令牌时不再重复发放
# 判据：Inventory 数组里存在任一带 KitAssassinEgg:1b 标记的物品

execute unless data entity @s Inventory[{tag:{KitAssassinEgg:1b}}] run give @s minecraft:enderman_spawn_egg{KitAssassinEgg:1b,display:{Name:'{"text":"隐匿令牌","color":"dark_purple","bold":true}'}} 1
