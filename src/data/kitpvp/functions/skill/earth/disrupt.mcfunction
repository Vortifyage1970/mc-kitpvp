# @s = 扰动者：每 3 秒对 11 格内玩家发动太阳耀斑的单体中招效果
execute at @s as @a[distance=..11,scores={kitpvp.alive=1},tag=!kitpvp.spectator] run function kitpvp:skill/sun/flare_hit
scoreboard players set @s kitpvp.earth_cd_a 60
