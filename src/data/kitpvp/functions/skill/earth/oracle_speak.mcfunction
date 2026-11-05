# 预言家开口：15 秒一次，四句里按条件挑着说
scoreboard players set @s kitpvp.earth_cd_a 300

# 先现读一遍所有活着的玩家的血量（Health × 100，20.0 血 = 2000）
execute as @a[gamemode=!spectator,tag=!kitpvp.spectator] store result score @s kitpvp.hp_x10 run data get entity @s Health 100

# 第一句：场上还剩几个人
scoreboard players set #oracle_n kitpvp.game 0
execute as @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] run scoreboard players add #oracle_n kitpvp.game 1
tellraw @a [{"text":"[预言家] ","color":"light_purple","bold":true},{"text":"场上还剩 ","color":"white"},{"score":{"name":"#oracle_n","objective":"kitpvp.game"},"color":"gold"},{"text":" 个人","color":"white"}]

# 第二句：血最少的那些（低于 10 点整）；没人低于 10 就不说这句
execute if entity @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f},scores={kitpvp.hp_x10=..1000}] run tellraw @a [{"text":"[预言家] ","color":"light_purple","bold":true},{"text":"血快要见底的是：","color":"white"},{"selector":"@a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f},scores={kitpvp.hp_x10=..1000}]","color":"red"}]

# 第三句：谁离我最近（24 格内才说）
execute at @s if entity @a[distance=..24,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] run tellraw @a [{"text":"[预言家] ","color":"light_purple","bold":true},{"text":"离我最近的是 ","color":"white"},{"selector":"@p[distance=..24,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}]","color":"aqua"},{"text":"，就在我眼皮底下","color":"white"}]

# 第四句：有人贴到 4 格内才警告（这句最刺耳，听见说明它就快死了）
execute at @s if entity @a[distance=..4,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] run tellraw @a [{"text":"[预言家] ","color":"light_purple","bold":true},{"text":"有人已经贴到我身边了——","color":"red"},{"selector":"@p[distance=..4,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}]","color":"red","bold":true}]

playsound minecraft:block.amethyst_block.chime master @a[distance=..32] ~ ~ ~ 1 0.6
