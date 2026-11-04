# 炮台队槽：分配 ttid（若为 0）并把主人 join 回自己的炮台队。
# ⚠ 必须每次部署都跑：game/start_impl 开局会把所有人的 ttid 清零（队槽每局重建），
#   而职业是在大厅里选的、选职业时分配的 ttid 也会一起被清掉。
#   以前只在 kit/tainted_archer 里分配一次，开局后 ttid 已是 0 → 部署时谁都不进队
#   → 骷髅把主人当成敌人打（2026-11-05 实机 bug）。
execute if score @s kitpvp.ttid matches 0 run scoreboard players add #ttid kitpvp.game 1
execute if score @s kitpvp.ttid matches 0 if score #ttid kitpvp.game matches 7.. run scoreboard players set #ttid kitpvp.game 1
execute if score @s kitpvp.ttid matches 0 run scoreboard players operation @s kitpvp.ttid = #ttid kitpvp.game

execute if score @s kitpvp.ttid matches 1 run team join turret_1 @s
execute if score @s kitpvp.ttid matches 2 run team join turret_2 @s
execute if score @s kitpvp.ttid matches 3 run team join turret_3 @s
execute if score @s kitpvp.ttid matches 4 run team join turret_4 @s
execute if score @s kitpvp.ttid matches 5 run team join turret_5 @s
execute if score @s kitpvp.ttid matches 6 run team join turret_6 @s
