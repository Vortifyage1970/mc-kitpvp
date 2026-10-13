# 强制结束：先重算 #survivors（决定 end 走"胜利"还是"平局"分支）
scoreboard players set #survivors kitpvp.game 0
execute as @a[tag=kitpvp.selected,tag=!kitpvp.spectator,gamemode=!spectator] run scoreboard players add #survivors kitpvp.game 1

function kitpvp:game/end
