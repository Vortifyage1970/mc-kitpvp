# 命数归 0 → 旁观：清职业 tag、清背包与效果，最后触发胜负判定
tag @s remove kitpvp.respawn_pending
tag @s remove kitpvp.invincible

tag @s remove kitpvp.shield_held
tag @s remove kitpvp.assassin_hidden
tag @s remove kitpvp.pirate_reload_cd

scoreboard players set @s kitpvp.lives 0
scoreboard players set @s kitpvp.alive 0
scoreboard players set @s kitpvp.inv 0
tag @s add kitpvp.spectator

gamemode spectator @s
clear @s
effect clear @s
tag @s remove kitpvp.selected

title @s times 5 40 10
title @s title {"text":"你死完了！","color":"red","bold":true}
playsound minecraft:entity.villager.death master @s ~ ~ ~ 1 0.6

tellraw @a [{"text":"[淘汰] ","color":"dark_red","bold":true},{"selector":"@s","color":"white"},{"text":" 已死完","color":"red"}]
