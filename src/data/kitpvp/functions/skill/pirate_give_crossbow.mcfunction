# ===== 发放一把"海盗手炮"（弩） =====
# 调用方：
#   skill/pirate_return        （30 秒归还）
#
# ⚠ 这里的弩 NBT 必须与 kit/pirate.mcfunction 里那一串完全一致，
#   否则归还回来的弩会被 pirate_pickup.json 的触发器条件认不出来。

give @s minecraft:crossbow{KitCrossbow:1b,Unbreakable:1b,display:{Name:'{"text":"手炮","color":"dark_blue"}'}} 1
