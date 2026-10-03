# 右击 (-20,64,98) 的讲台 → 传送到目标坐标
# TODO: 填入目标坐标后，取消下面 tp 那一行的注释（想指定朝向就在坐标后再加 <yaw> <pitch>）
advancement revoke @s only kitpvp:player/lectern_teleport
# tp @s 0.0 0.0 0.0
playsound minecraft:entity.enderman.teleport master @s ~ ~ ~ 0.8 1.2
