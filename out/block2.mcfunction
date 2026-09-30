# ===== 弓箭手：拾弓触发入口 =====
# 触发器：minecraft:thrown_item_picked_up_by_player
#   条件：被捡起的物品是带 KitBow:1b 标记的 minecraft:bow
# @s = 捡起弓的玩家
#
# 分流：
#   本人是弓箭手（kit=2）→ 换弹
#   其他职业             → 弓被没收，30 秒后归还

# 弓箭手本人 → 换弹
execute if score @s kitpvp.kit matches 2 run function kitpvp:skill/archer_refill

# 非弓箭手 → 没收弓 + 启动 30 秒归还计时
execute unless score @s kitpvp.kit matches 2 run function kitpvp:skill/archer_steal

# 一次性触发器：必须 revoke，否则下一次捡弓不会再触发
advancement revoke @s only kitpvp:player/archer_pickup
