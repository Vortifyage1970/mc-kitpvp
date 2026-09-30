# ===== 刺客：隐匿令牌使用检测 =====
# 统计 objective：右键末影人刷怪蛋的瞬间 used 自动 +1
# 本刻 used 比 last 大 → 刚用掉令牌，转交 skill/assassin_cast
# 必须在"冷却递减"之后再跑，避免 cd 被本 tick 的递减覆盖
execute as @a[scores={kitpvp.kit=4,kitpvp.alive=1}] if score @s kitpvp.assassin_used > @s kitpvp.assassin_last run function kitpvp:skill/assassin_cast

# ===== 刺客：隐匿 5 秒到期 =====
# cd 记 600（30 秒）：前 100 刻隐身+速度 III，后 500 刻纯冷却。
# 用 ..500（不是精确 =500）：即使服务端卡顿跳过某刻，也会被下一轮捕捉，不漏。
# tag=kitpvp.assassin_hidden 保证每次隐匿只触发一次，不会重复挂效果。
execute as @a[scores={kitpvp.cd=..500},tag=kitpvp.assassin_hidden,tag=!kitpvp.spectator] run function kitpvp:skill/assassin_unhide

# ===== 刺客：清除令牌生成的末影人 =====
# 令牌是末影人刷怪蛋，右键会在玩家附近生成一只末影人。
# 本行把它立刻清掉：只保留"按下右键"这个信号，不留残局生物。
# distance=..16 覆盖刷怪蛋的最大右键射程（约 4.5 格），
# 且避免误杀远处其它来源的末影人。
# ⚠ 若某张地图自带装饰性末影人且落在刺客 16 格内，会被一并清掉。
execute as @a[scores={kitpvp.kit=4}] at @s run kill @e[type=enderman,distance=..16]

# ===== 刺客：隐匿令牌兜底补发 =====
# 冷却结束、背包里又没有令牌时，补发一个，让刺客能继续施法
# 判据：Inventory 里存在任一带 KitAssassinEgg:1b 标记的物品
execute as @a[scores={kitpvp.kit=4,kitpvp.alive=1,kitpvp.cd=0},tag=!kitpvp.spectator] unless data entity @s Inventory[{tag:{KitAssassinEgg:1b}}] run function kitpvp:skill/assassin_give_item
