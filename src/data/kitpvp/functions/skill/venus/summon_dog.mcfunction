# 在 @s（金星玩家）脚下生成舔狗，并补上主人 UUID 与归属编号
# 狼是否"已驯服"只取决于 Owner 是否为空：set from entity @s UUID 就是自动驯服
execute at @s run function kitpvp:summon/venus_dog
execute as @s run data modify entity @e[type=minecraft:wolf,tag=kitpvp.venus_dog_new,sort=nearest,limit=1] Owner set from entity @s UUID
execute as @s run scoreboard players operation @e[type=minecraft:wolf,tag=kitpvp.venus_dog_new,sort=nearest,limit=1] kitpvp.dog_owner = @s kitpvp.vtid

tag @e[type=minecraft:wolf,tag=kitpvp.venus_dog_new] remove kitpvp.venus_dog_new
