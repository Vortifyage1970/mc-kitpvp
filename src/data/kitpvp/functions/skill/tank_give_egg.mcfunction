# ===== 坦克：发放"举盾令牌"（铁傀儡刷怪蛋） =====
# 调用方：
#   kit/tank            （选职业时）
#   tick.mcfunction     （令牌被用掉 / 丢失后的兜底补发）
#   player/after_death  （重生后清理）
#
# 令牌物品：minecraft:iron_golem_spawn_egg，带 KitTankEgg:1b 标记
#   - 右键会生成一只铁傀儡（原版行为），并让 minecraft.used 统计 +1
#   - 生成的铁傀儡由 tick 立刻 kill 掉，不会留场
#   - 令牌没有其它效果，右键不消耗 CD 之外的东西
#
# 幂等：已经持有令牌时不再重复发放
# 判据：Inventory 数组里存在任一带 KitTankEgg:1b 标记的物品

execute unless data entity @s Inventory[{tag:{KitTankEgg:1b}}] run give @s minecraft:iron_golem_spawn_egg{KitTankEgg:1b,display:{Name:'{"text":"举盾令牌","color":"aqua","bold":true}'}} 1
