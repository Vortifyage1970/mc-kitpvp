# ===== 弓箭手：捡起"2 号弓" =====
# 触发：advancement kitpvp:player/archer_pickup_2
# 条件：被捡起的物品是带 KitBowOwner:2b 标记的 minecraft:bow
# @s = 捡起者

# ----- A. 本人换弹 -----
execute if score @s kitpvp.bowid matches 2 run function kitpvp:skill/archer_refill

# ----- B. 抢夺处理 -----
execute unless score @s kitpvp.bowid matches 2 run clear @s minecraft:bow{KitBowOwner:2b}
execute unless score @s kitpvp.bowid matches 2 run tag @a[scores={kitpvp.bowid=2}] add kitpvp.bow_stolen
execute unless score @s kitpvp.bowid matches 2 run tellraw @a [{"text":"[换弹] ","color":"gold","bold":true},{"selector":"@s","color":"white"},{"text":" 捡走了 ","color":"gray"},{"selector":"@a[scores={kitpvp.bowid=2}]","color":"aqua"},{"text":" 的弓，30 秒后归还","color":"gray"}]
execute unless score @s kitpvp.bowid matches 2 run schedule function kitpvp:skill/archer_return_2 600t replace

advancement revoke @s only kitpvp:player/archer_pickup_2
