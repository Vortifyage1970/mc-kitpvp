# ===== 海盗：捡起手炮 → 分流 =====
# 触发：advancement kitpvp:player/pirate_pickup
#       （thrown_item_picked_up_by_player + crossbow + KitCrossbow:1b）
# @s = 捡起弩的玩家
#
# 分工与弓箭手（skill/archer_pickup）完全同构：
#   本人是海盗（kit=9）→ 换弹
#   其他职业           → 弩被没收，30 秒后归还

# 首行 revoke 是铁律：advancement grant 后不再执行 reward，
# 不 revoke 则整套只会生效一次。
advancement revoke @s only kitpvp:player/pirate_pickup

# 海盗本人 → 换弹
execute if score @s kitpvp.kit matches 9 run function kitpvp:skill/pirate_reload

# 非海盗 → 没收弩 + 启动 30 秒归还计时
execute unless score @s kitpvp.kit matches 9 run function kitpvp:skill/pirate_steal
