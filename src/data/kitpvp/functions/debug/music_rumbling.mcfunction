# debug 点歌：Rumbling（音乐 + 歌词一起放，和雨爱一致）
execute as @a run function kitpvp:music/rumbling/play
function kitpvp:music/rumbling_lyric/start
tellraw @a {"text":"[音乐] The Rumbling","color":"dark_red"}
