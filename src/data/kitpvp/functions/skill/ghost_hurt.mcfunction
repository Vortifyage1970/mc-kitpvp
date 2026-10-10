# ===== 幽灵：受到伤害 → 发光 1 秒 =====
# 由 advancement kitpvp:player/ghost_hurt 在被伤害玩家身上触发
# @s = 受伤的玩家
#
# 首行无条件 revoke：advancement 完成状态必须先清掉，
# 下一次受伤才能再次触发（advancement 只在"完成"那一刻执行 rewards）。
# 本行不能加任何前置条件，否则会把这次触发机会白费掉。

advancement revoke @s only kitpvp:player/ghost_hurt

# 只有幽灵职业才真的发光；
# 其它职业也会拿到本 advancement（触发器是全局的），函数内靠 kit 值筛掉。
execute if score @s kitpvp.kit matches 6 run effect give @s minecraft:glowing 1 0 true
