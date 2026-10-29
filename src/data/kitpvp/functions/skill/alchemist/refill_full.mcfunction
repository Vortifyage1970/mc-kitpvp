# 整批被用掉时补一套并提示（refill_splash 每刻都被调到，提示不能写那边）
function kitpvp:skill/alchemist/give_splash

title @s actionbar {"text":"药剂已补满","color":"green"}
playsound minecraft:block.brewing_stand.brew master @s ~ ~ ~ 0.7 1.2
