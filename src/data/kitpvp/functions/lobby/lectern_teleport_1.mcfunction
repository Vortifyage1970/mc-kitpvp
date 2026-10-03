# 右击 (-20,64,98) 的讲台 → 传送到目标坐标
advancement revoke @s only kitpvp:player/lectern_teleport_1 
#execute as @s run schedule function kitpvp:lobby/teleport_playsound 1t replace
tp @s -226 70 94
playsound minecraft:entity.enderman.teleport master @s -226 70.5 94 0.8 1.4