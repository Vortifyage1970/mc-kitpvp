execute as @a[tag=!kitpvp.joined] run function kitpvp:player/join

execute as @a[scores={kitpvp.cd=1..}] run scoreboard players remove @s kitpvp.cd 1
execute as @a[scores={kitpvp.cd2=1..}] run scoreboard players remove @s kitpvp.cd2 1
execute as @a[scores={kitpvp.sun_reload=1..}] run scoreboard players remove @s kitpvp.sun_reload 1
execute as @a[scores={kitpvp.venus_cd3=1..}] run scoreboard players remove @s kitpvp.venus_cd3 1
execute as @a[tag=kitpvp.pirate_reload_cd,tag=kitpvp.selected,tag=!kitpvp.spectator,scores={kitpvp.kit=9,kitpvp.alive=1,kitpvp.cd=..0}] run title @s actionbar {"text":"手炮换弹已就绪","color":"dark_blue"}
tag @a[tag=kitpvp.pirate_reload_cd,scores={kitpvp.cd=..0}] remove kitpvp.pirate_reload_cd

