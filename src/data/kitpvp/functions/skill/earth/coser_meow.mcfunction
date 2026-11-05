# COSER 的猫叫：每隔 4 秒叫一声（贴着她走过去能听见）
# 猫叫有三个音色可选：entity.cat.ambient（普通喵）、entity.cat.purreow（喵呜～）、entity.cat.hiss（嘶）
# pitch 越高越尖：1.0 = 原声、1.2 = 小奶猫、0.8 = 老猫
playsound minecraft:entity.cat.ambient master @a[distance=..16] ~ ~ ~ 0.9 1.15
scoreboard players set @s kitpvp.earth_cd_a 80
