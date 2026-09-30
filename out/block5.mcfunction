# ===== 发放一把"弓箭手之弓" =====
# 调用方：
#   kit/archer.mcfunction      （选职业时）
#   skill/archer_return        （30 秒归还）
#
# ⚠ 这里的弓 NBT 必须与 kit/archer.mcfunction 里那一串完全一致，
#   否则归还回来的弓可能被 archer_pickup.json 的触发器条件认不出来。
#   如果 kit/archer 里只写了 {KitBow:1b}，就把下面 Unbreakable 去掉。

give @s minecraft:bow{KitBow:1b,Unbreakable:1b} 1
