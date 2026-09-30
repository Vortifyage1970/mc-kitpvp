# ===== 弓箭手：捡起"1 号弓" =====
# 触发：advancement kitpvp:player/archer_pickup_1
# 条件：被捡起的物品是带 KitBowOwner:1b 标记的 minecraft:bow
# @s = 捡起者
#
# 分支：
#   A. 捡起者是 1 号弓箭手本人 → 换弹（箭补到 12）
#   B. 捡起者是其他人（包括其他弓箭手）→ 从对方背包清除这把弓，30 秒后归还本人

# ----- A. 本人换弹 -----
execute if score @s kitpvp.bowid matches 1 run function kitpvp:skill/archer_refill

# ----- B. 抢夺处理 -----
# 1) 从捡起者背包清除这把弓（只清 KitBowOwner:1b 的一把，对方自己的弓不受影响）
execute unless score @s kitpvp.bowid matches 1 run clear @s minecraft:bow{KitBowOwner:1b}
# 2) 标记原主人处于"弓被抢走"状态（归还时用这个 tag 判断）
execute unless score @s kitpvp.bowid matches 1 run tag @a[scores={kitpvp.bowid=1}] add kitpvp.bow_stolen
# 3) 公告
execute unless score @s kitpvp.bowid matches 1 run tellraw @a [{"text":"[换弹] ","color":"gold","bold":true},{"selector":"@s","color":"white"},{"text":" 捡走了 ","color":"gray"},{"selector":"@a[scores={kitpvp.bowid=1}]","color":"aqua"},{"text":" 的弓，30 秒后归还","color":"gray"}]
# 4) 30 秒后归还（600 刻）
execute unless score @s kitpvp.bowid matches 1 run schedule function kitpvp:skill/archer_return_1 600t replace

# ----- 一次性触发器：必须 revoke，否则下次捡弓不会再触发 -----
advancement revoke @s only kitpvp:player/archer_pickup_1
