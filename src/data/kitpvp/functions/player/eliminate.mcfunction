# ===== 命数归 0：淘汰进入旁观 =====

# 不再重生
tag @s remove kitpvp.respawn_pending
tag @s remove kitpvp.invincible

# 清理职业性 tag（旁观的玩家不再持有任何专职技能标记）
tag @s remove kitpvp.shield_held
tag @s remove kitpvp.skill_ready
tag @s remove kitpvp.skill_consume
tag @s remove kitpvp.assassin_hidden

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

# 胜负判定（完整结算流程见 2.11）
function kitpvp:game/check_winner