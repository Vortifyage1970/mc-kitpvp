# 计时走完：在金星身边重新生成舔狗
function kitpvp:skill/venus/summon_dog
tag @s remove kitpvp.venus_dog_dead
scoreboard players set @s kitpvp.venus_dog_timer 0

title @s actionbar {"text":"舔狗已复活","color":"aqua"}
playsound minecraft:entity.wolf.ambient master @s ~ ~ ~ 0.8 1.2
