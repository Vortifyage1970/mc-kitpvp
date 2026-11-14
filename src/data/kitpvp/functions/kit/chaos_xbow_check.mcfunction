# 大型手炮：预装填的弩射击后 Charged 由 1 变 0 —— 只有这样才确定"真的射出去了"
# （used:crossbow 对预装填弩不涨：CrossbowItem.use 在已装填分支返回 consume，不记 item_used）
execute if predicate kitpvp:chaos_xbow_charged run scoreboard players set @s kitpvp.chaos_xbow_charge 1
execute unless predicate kitpvp:chaos_xbow_charged if score @s kitpvp.chaos_xbow_charge matches 1 run function kitpvp:kit/chaos_xbow_fired
