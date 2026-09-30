# ===== 弓箭手：拾弓触发入口 =====
# 触发器：minecraft:thrown_item_picked_up_by_player
#   条件：被捡起的物品是带 KitBow:1b 标记的 minecraft:bow
# @s = 捡起弓的玩家
#
# 简化说明：设计文档写的"弓被别人捡走 → 30 秒冷却 → 归还"未实现。
# 本版只做：捡起者是弓箭手 → 补箭；其他人 → 什么都不做。

# 弓箭手本人 → 换弹
execute if score @s kitpvp.kit matches 2 run function kitpvp:skill/archer_refill

# 一次性触发器：必须 revoke，否则下一次捡弓不会再触发
advancement revoke @s only kitpvp:player/archer_pickup
