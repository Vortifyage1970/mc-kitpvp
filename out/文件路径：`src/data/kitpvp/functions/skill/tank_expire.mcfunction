# ===== 坦克：护盾 15 秒到期 =====
# 触发：tick.mcfunction 检测到 cd <= 300 且 tag=kitpvp.shield_held
# @s = 持盾者
#
# 责任：
#   1. 清掉背包里带 KitShield 标记的盾
#   2. 摘掉持盾标记，防止 tick 重复触发
#   3. 提示本机玩家
#
# ⚠ 已知取舍：若玩家把盾丢地上被别人捡走，那把盾不会被本函数清掉
#   （clear @s 只作用于持有者）。流出的盾仍带 80 点剩余耐久，用完即碎，
#   不构成刷物品漏洞。

clear @s minecraft:shield{KitShield:1b}
tag @s remove kitpvp.shield_held

title @s actionbar {"text":"护盾已消失","color":"gray"}
