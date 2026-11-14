# 停音乐 + 停歌词（#mars_music 幂等：只在第一次真正执行）
execute if score #mars_music kitpvp.game matches 0 run execute as @a run function kitpvp:music/rumbling/stop
execute if score #mars_music kitpvp.game matches 0 run function kitpvp:music/rumbling_lyric/stop
execute if score #mars_music kitpvp.game matches 0 run scoreboard players set #mars_music kitpvp.game 1
