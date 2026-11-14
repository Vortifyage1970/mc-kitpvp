# 只停音乐（驾驶员死亡时用；巨人继续站着）
execute unless score #mars_music kitpvp.game matches 1 run scoreboard players set #mars_music kitpvp.game 1
execute if score #mars_music kitpvp.game matches 1 run execute as @a run function kitpvp:music/rumbling/stop
function kitpvp:music/rumbling_lyric/stop
