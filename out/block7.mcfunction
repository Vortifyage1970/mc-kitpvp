# ===== 主大厅：兜底补发大厅物品 =====
# 场景一：玩家选职业时 clear_player 清空背包，但人还在大厅（in_lobby 不清），
#         这段每刻检测，缺钓竿或缺大厅剑就补回。
# 场景二：玩家把物品丢地上，下一刻也会补一份（不阻塞玩法）。
# 幂等由 give_items 内部 Inventory 检测保证，不会重复堆叠。
# 只动 tag=kitpvp.in_lobby 的玩家，局内玩家不受影响。
execute as @a[tag=kitpvp.in_lobby,tag=!kitpvp.spectator] run function kitpvp:lobby/give_items

# ===== 主大厅：准备 / 取消准备（右键准备钓竿）=====
# 统计 objective：右键胡萝卜钓竿的瞬间 used 自动 +1
# ready_last 快照在 lobby/enter 里被推到当前值，
# 保证"进大厅之前"的历史右键不会在进大厅那一刻被误判
execute as @a[tag=kitpvp.in_lobby,tag=!kitpvp.spectator] if score @s kitpvp.ready_used > @s kitpvp.ready_last run function kitpvp:lobby/ready_toggle
