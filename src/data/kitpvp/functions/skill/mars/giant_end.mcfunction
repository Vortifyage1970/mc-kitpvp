# 巨人死亡：驾驶员一起死、音效收尾、生灵清场、音乐停
scoreboard players set #mars_music kitpvp.game 0
kill @e[tag=kitpvp.mars_controller]
kill @e[tag=kitpvp.mars_wild]
execute as @a run function kitpvp:music/rumbling/stop
function kitpvp:music/rumbling_lyric/stop
playsound minecraft:entity.wither.death master @a ~ ~ ~ 0.8 0.7
tellraw @a [{"text":"❖ ","color":"gold","bold":true},{"text":"地鸣停止了","color":"gray","italic":true}]
