# 8 分钟归零时由 timer_tick 调用一次；此后 sudden_drop 自我调度
tellraw @a [{"text":"[!] ","color":"red","bold":true},{"text":"8 分钟已到，进入突然死亡！","color":"red","bold":true}]
playsound minecraft:entity.wither.spawn master @a ~ ~ ~ 1 1.5
effect give @a minecraft:glowing 10 0 true

execute as @a[scores={kitpvp.alive=1},tag=kitpvp.selected] run tag @s add kitpvp.sudden_death

function kitpvp:game/sudden_drop
