# 鹦鹉跟着本体：**骑在身上**（乘客随载具移动，所有客户端都会渲染）
# ⚠ 旧写法是每刻 `tp @s ~ ~1.85 ~` 钉在头顶：本机看得见、别的玩家完全看不见那只鸟
#   （2026-11-26 实机；玩家回忆"杀一次再复活就好"= 让实体重新注册一次，正是这个症状）
#   每刻 tp 的实体在别的客户端容易不被渲染，改成乘客就没有这个问题。
# 调用方需 `as 玩家 at 玩家`（本函数用 ~ 取调用位置）
scoreboard players operation #ptid kitpvp.game = @s kitpvp.ptid

# 1) 还没骑上就上鞍
execute unless data entity @s Passengers[{id:"minecraft:parrot"}] run function kitpvp:skill/pluto/mount

# 2) 兜底：万一某种情况下骑不上（例如玩家当载具被拒），退回旧的每刻 tp，至少位置是对的
execute unless data entity @s Passengers[{id:"minecraft:parrot"}] as @e[type=minecraft:parrot,tag=kitpvp.pluto_parrot] if score @s kitpvp.parrot_owner = #ptid kitpvp.game run tp @s ~ ~1.85 ~
