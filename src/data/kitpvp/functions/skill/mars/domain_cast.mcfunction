# 地鸣：聊天栏两行 + 音效 + 召唤巨人（一次性道具，用掉就没了）
scoreboard players operation @s kitpvp.mars_domain_last = @s kitpvp.mars_domain_used

tellraw @a [{"text":"━━━━━━━━ ","color":"dark_red","bold":true},{"text":"领域展开","color":"gold","bold":true},{"text":" ━━━━━━━━","color":"dark_red","bold":true}]
tellraw @a [{"text":"❖ ","color":"gold","bold":true},{"text":"地 鸣","color":"dark_red","bold":true},{"text":" ❖","color":"gold","bold":true}]

playsound minecraft:entity.warden.roar master @a ~ ~ ~ 1 0.7
execute as @a at @s run playsound minecraft:entity.warden.sonic_boom master @s ~ ~ ~ 0.6 1.1
execute as @a at @s run playsound minecraft:entity.ender_dragon.growl master @s ~ ~ ~ 0.6 0.8
playsound minecraft:entity.wither.spawn master @a ~ ~ ~ 0.9 0.6
playsound minecraft:block.beacon.deactivate master @a ~ ~ ~ 1 0.5
particle minecraft:dust 0.6 0.05 0.05 3 ~ ~1 ~ 3 2 3 0.2 200 normal

execute at @r[tag=kitpvp.selected,scores={kitpvp.alive=1},tag=!kitpvp.spectator] run function kitpvp:skill/mars/giant_spawn
scoreboard players set #mars_music kitpvp.game 0
scoreboard players set #mars_active kitpvp.game 1
schedule function kitpvp:skill/mars/song_end 1810t replace
execute as @a run function kitpvp:music/rumbling/play
function kitpvp:music/rumbling_lyric/start
execute at @s run kill @e[tag=kitpvp.mars_token,distance=..32]
execute at @s run kill @e[name="地鸣",distance=..32]
execute at @s run kill @e[type=minecraft:vex,distance=..8,tag=!kitpvp.displayitem]
