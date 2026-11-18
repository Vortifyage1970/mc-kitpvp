# 炮台队槽：分配 ttid（若为 0）——ttid 既是「炮台组编号」也是 turret_owner 的 owner id（计数用）
# ⚠ 必须每次部署都跑：start_impl 开局把 ttid 清零（队槽每局重建），大厅选职业时分配的也会被清。
execute if score @s kitpvp.ttid matches 0 run scoreboard players add #ttid kitpvp.game 1
execute if score @s kitpvp.ttid matches 0 if score #ttid kitpvp.game matches 7.. run scoreboard players set #ttid kitpvp.game 1
execute if score @s kitpvp.ttid matches 0 run scoreboard players operation @s kitpvp.ttid = #ttid kitpvp.game

# 只有「主人当前不在任何队」时，才把他 join 进 turret_N 并占一个炮台槽；
# 如果他已经通过魂石/阴兵等进了别的队，就沿用那套，**绝不动他自己的队**（否则旧召唤物会翻脸）。
# 炮台本身由 turret_fire 按「主人当前队」join（见那里）。
function kitpvp:util/team_index
execute if score #steam kitpvp.game matches 0 if score @s kitpvp.ttid matches 1 run team join turret_1 @s
execute if score #steam kitpvp.game matches 0 if score @s kitpvp.ttid matches 2 run team join turret_2 @s
execute if score #steam kitpvp.game matches 0 if score @s kitpvp.ttid matches 3 run team join turret_3 @s
execute if score #steam kitpvp.game matches 0 if score @s kitpvp.ttid matches 4 run team join turret_4 @s
execute if score #steam kitpvp.game matches 0 if score @s kitpvp.ttid matches 5 run team join turret_5 @s
execute if score #steam kitpvp.game matches 0 if score @s kitpvp.ttid matches 6 run team join turret_6 @s
