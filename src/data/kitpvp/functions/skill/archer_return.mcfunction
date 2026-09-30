# ===== 30 秒到：把弓归还给弓箭手 =====
# 触发：schedule function kitpvp:skill/archer_return 600t replace
# 说明：本函数会顺手把"已经拿着弓"的弓箭手也刷新一遍
#       （同类弓全局只有一种，刷新无副作用；代价是该玩家若正在拉弓会被打断）

# 1. 清掉所有弓箭手手上的 KitBow 弓，防止归还后叠加成多把
execute as @a[scores={kitpvp.kit=2}] run clear @s minecraft:bow{KitBow:1b}

# 2. 每个仍在局内的弓箭手重新发一把
execute as @a[scores={kitpvp.kit=2,kitpvp.alive=1},tag=!kitpvp.spectator] run function kitpvp:skill/archer_give_bow

# 3. 公告
tellraw @a [{"text":"[!] ","color":"green","bold":true},{"text":"弓箭手的弓已归还","color":"gray"}]