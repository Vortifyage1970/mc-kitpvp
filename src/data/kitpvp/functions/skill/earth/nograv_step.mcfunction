# @s = 一只无重力召唤物，at 它身上：朝最近的玩家走一步
# ★ 照抄最早"泥土骑士"那版：24 格内每刻都沿视线方向挪 0.12 格（≈2.4 格/秒），不做任何方块检查 ⇒ 会穿墙
#   穿墙是刻意的：检查方块会被墙卡住、还容易把乘客挤在方块里，那版手感更烦（作者要的就是这个手感）
# ★ 视线用 execute facing 指向玩家脚底（含俯仰），上下楼时跟着往上飘
# ★ 唯一保留的兜底：玩家跑到 24 格外才直接贴过去（刚召唤、玩家传送走了），不是日常移动
# ★ 代价：卡进方块里时乘客（僵尸）会吃窒息伤害 —— 飞行兵身上挂着抗性提升 II，掉得慢一些
scoreboard players add #nograv_runs kitpvp.game 1
execute if entity @p[distance=1.5..24,sort=nearest] facing entity @p[distance=1.5..24,sort=nearest] feet run tp @s ^ ^ ^0.12
execute unless entity @p[distance=..24,sort=nearest] if entity @p[distance=24..64,sort=nearest] run tp @s @p[distance=24..64,sort=nearest]