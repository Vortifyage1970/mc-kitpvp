# 地鸣结束：巨人 + 驾驶员一起清掉（生灵留着，不清）
scoreboard players set #mars_active kitpvp.game 0
schedule clear kitpvp:skill/mars/song_end
kill @e[tag=kitpvp.mars_giant]
kill @e[tag=kitpvp.mars_controller]
execute as @a at @s run function kitpvp:music/rumbling/stop
function kitpvp:music/rumbling_lyric/stop
tellraw @a [{"text":"❖ ","color":"gold","bold":true},{"text":"地鸣停止了","color":"gray","italic":true}]
# 结束音效（参考里渔夫的 domain_end）
execute as @a at @s run playsound minecraft:block.beacon.deactivate master @s ~ ~ ~ 0.6 1.2
execute as @a at @s run playsound minecraft:entity.wither.death master @s ~ ~ ~ 0.7 0.7
execute as @a at @s run playsound minecraft:item.trident.thunder master @s ~ ~ ~ 0.5 0.8
