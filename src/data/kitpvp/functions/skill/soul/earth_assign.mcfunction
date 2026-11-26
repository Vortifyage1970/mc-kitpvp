# 地球槽分配：**只在主人原本不在任何队时**由 earth_team_id 调用
# 复用地球职业的 link 拿一个 1..6 的 etid，再抬到地球段 19..24
function kitpvp:skill/earth/link
scoreboard players operation #steam kitpvp.game = @s kitpvp.etid
execute if score #steam kitpvp.game matches 1..6 run scoreboard players add #steam kitpvp.game 18
# link 都没分到槽（极端情况）：退回 19（earth_1），至少不与幽灵/炮台编号撞
execute if score #steam kitpvp.game matches 0 run scoreboard players set #steam kitpvp.game 19
