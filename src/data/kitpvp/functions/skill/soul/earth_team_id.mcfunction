# 地球魂石的队槽识别：直接复用 util/team_index（0..36 一整套，含炸弹兵 / 里·农夫）
function kitpvp:util/team_index

# 不在任何队：给他分一个地球槽（复用地球职业那套 link）——只有这时换队，不会伤到任何旧召唤物
execute if score #steam kitpvp.game matches 0 run function kitpvp:skill/earth/link
execute if score #steam kitpvp.game matches 0 run scoreboard players operation #steam kitpvp.game = @s kitpvp.etid
execute if score #steam kitpvp.game matches 1..6 run scoreboard players add #steam kitpvp.game 18
# link 都没分到槽（极端情况）：退回 19（earth_1），至少不会和幽灵/炮台编号撞
execute if score #steam kitpvp.game matches 0 run scoreboard players set #steam kitpvp.game 19
