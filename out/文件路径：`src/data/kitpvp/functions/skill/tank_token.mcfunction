# ===== 坦克：发放"举盾"触发令牌 =====
# 调用方：
#   kit/tank            （选职业时）
#   player/after_death  （重生后补发）
#   tick.mcfunction     （令牌丢失时兜底补发，见 tick）
#
# 令牌物品：胡萝卜钓竿（carrot_on_a_stick），带 KitShieldToken:1b 标记
# 说明：
#   carrot_on_a_stick 是 1.20.1 里右键会进入"使用"状态的物品。
#   advancement 触发器 minecraft:using_item 依靠它捕捉右键动作。
#   令牌本身没有右键效果、右键不消耗、不进冷却，纯粹是技能按钮。
#
# 幂等：已经持有令牌时不再重复发放
# 判据：Inventory 数组里存在任一带 KitShieldToken:1b 标记的物品
# 副作用：如果玩家把令牌丢在地上被别人捡走，判据会失败 → 自己再被补一份，
#        但"抢走的那个"还是能被使用触发（它的 NBT 里带 KitShieldToken），
#        这是设计取舍：令牌可以传递，但对方右键时是他的坦克身份在消耗冷却——
#        如果对方不是坦克，则 skill/tank_cast 里 cd 归零分支照样执行。
#        若要防这一点，把 tank_cast 首行改成"非坦克直接中断"（详后）。

execute unless data entity @s Inventory[{tag:{KitShieldToken:1b}}] run give @s minecraft:carrot_on_a_stick{KitShieldToken:1b,display:{Name:'{"text":"举盾令牌","color":"aqua","bold":true}'}} 1
