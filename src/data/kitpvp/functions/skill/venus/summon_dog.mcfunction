# 在 @s（金星玩家）脚下生成舔狗，并补上主人 UUID 与归属编号
# 狼是否"已驯服"只取决于 Owner 是否为空：set from entity @s UUID 就是自动驯服

# 幂等闸门：同号只允许一只。复活计时误判、重选职业的竞态都会走到这里，先清掉可见的残留再生成
scoreboard players operation #vtid kitpvp.game = @s kitpvp.vtid
execute as @e[type=minecraft:wolf,tag=kitpvp.venus_dog] if score @s kitpvp.dog_owner = #vtid kitpvp.game run kill @s

execute at @s run function kitpvp:summon/venus_dog
execute as @s run data modify entity @e[type=minecraft:wolf,tag=kitpvp.venus_dog_new,sort=nearest,limit=1] Owner set from entity @s UUID
execute as @s run scoreboard players operation @e[type=minecraft:wolf,tag=kitpvp.venus_dog_new,sort=nearest,limit=1] kitpvp.dog_owner = @s kitpvp.vtid

tag @e[type=minecraft:wolf,tag=kitpvp.venus_dog_new] remove kitpvp.venus_dog_new
