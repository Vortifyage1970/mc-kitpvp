# ===== 纵火狂：点一格火 + 挂一个守护 marker =====
# 执行位置：已精确落在要放火的方块上（由 arsonist_place 的 positioned 给出）
# marker 不可见、无碰撞、无重力，只用来在 5 秒内记住"这一格必须有火"

setblock ~ ~ ~ fire
summon minecraft:marker ~ ~ ~ {Tags:["kitpvp.arsonist_fire","kitpvp.arsonist_new"]}
