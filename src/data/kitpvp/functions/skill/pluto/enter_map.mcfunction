# 开局进图：确保鹦鹉在身边（丢了就地补一只）→ 回满血 → 钉到肩头
# 由 game/start_impl 在 map/distribute 之后调用：此刻玩家已经站在地图落点，位置就是落点
# "回满血"只在这一处做：局内挨打该掉血就掉血，死了照常判死，别把它做成每命免费回血
function kitpvp:skill/pluto/respawn
scoreboard players set @s kitpvp.parrot_miss 0
scoreboard players operation #ptid kitpvp.game = @s kitpvp.ptid
execute as @e[type=minecraft:parrot,tag=kitpvp.pluto_parrot] if score @s kitpvp.parrot_owner = #ptid kitpvp.game run data modify entity @s Health set value 30.0f
execute at @s run function kitpvp:skill/pluto/follow
