# 串联体光环：以"每一对"为单位处理，保证一对里只有离玩家近的那节被减速
# @s = 那一对的僵尸底座；先挑最近的活人，再在那个人的位置里挑最近的一节
execute at @s at @p[distance=..40,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f},sort=nearest] run function kitpvp:skill/earth/tanden_pick
