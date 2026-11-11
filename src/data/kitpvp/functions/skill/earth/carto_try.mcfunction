# @s = 被制图台打中的那名玩家（advancement: player/carto_hit 判定"伤害来源是带 kitpvp.earth_carto 的僵尸"）
# 只有这一名玩家会进来，所以 carto_line 里的 tellraw @s 只弹给他自己
advancement revoke @s only kitpvp:player/carto_hit
execute unless score @s kitpvp.earth_cd_a matches 1.. run function kitpvp:skill/earth/carto_line
