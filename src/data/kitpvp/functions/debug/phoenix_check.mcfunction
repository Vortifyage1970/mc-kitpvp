# 凤凰自检：本体几只、守卫几只、每个守卫的阶段与孵化倒计时、场上蛋几个
tellraw @a [{"text":"═══ 凤凰自检 ═══","color":"gold","bold":true}]
scoreboard players set #phx1 kitpvp.game 0
scoreboard players set #phx2 kitpvp.game 0
scoreboard players set #phx3 kitpvp.game 0
execute as @e[tag=kitpvp.earth_phoenix] run scoreboard players add #phx1 kitpvp.game 1
execute as @e[tag=kitpvp.earth_phoenix_guard] run scoreboard players add #phx2 kitpvp.game 1
execute as @e[tag=kitpvp.phx_egg] run scoreboard players add #phx3 kitpvp.game 1
tellraw @a [{"text":"本体 = ","color":"gray"},{"score":{"name":"#phx1","objective":"kitpvp.game"},"color":"white"},{"text":"   守卫 = ","color":"gray"},{"score":{"name":"#phx2","objective":"kitpvp.game"},"color":"white"},{"text":"   蛋 = ","color":"gray"},{"score":{"name":"#phx3","objective":"kitpvp.game"},"color":"white"}]
# 阶段：0 = 第一形态还活着，1 = 已留蛋在倒数，2 = 复活过一次（再死就收工）
execute as @e[tag=kitpvp.earth_phoenix_guard,limit=1,sort=nearest] run tellraw @a [{"text":"最近守卫的阶段 = ","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.phx_stage"},"color":"white"},{"text":"   孵化倒计时 = ","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.phx_life"},"color":"white"},{"text":"   主人编号 = ","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.earth_owner"},"color":"white"}]
