# 由 lobby/ready_on 调用（有人刚进入准备）
scoreboard players set #unready kitpvp.game 0
execute as @a[tag=kitpvp.in_lobby,tag=!kitpvp.ready,tag=!kitpvp.spectator] run scoreboard players add #unready kitpvp.game 1

# 只差 1 人未准备 → 向所有人公告一次（有人已准备 ⇒ 场上不止 1 人）
execute if score #unready kitpvp.game matches 1 if entity @a[tag=kitpvp.in_lobby,tag=kitpvp.ready] run tellraw @a [{"text":"[!] ","color":"yellow","bold":true},{"text":"只差 ","color":"gray"},{"selector":"@a[tag=kitpvp.in_lobby,tag=!kitpvp.ready,tag=!kitpvp.spectator]","color":"white"},{"text":" 未准备","color":"gray"}]

# 全员就绪 → 开局（#state=0 守卫，防结算期重复触发）
execute if score #unready kitpvp.game matches 0 if entity @a[tag=kitpvp.in_lobby,tag=kitpvp.ready] if score #state kitpvp.game matches 0 run function kitpvp:game/start
