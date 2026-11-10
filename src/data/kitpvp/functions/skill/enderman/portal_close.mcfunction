# @s = 传送门 marker：到期收场（先出收尾粒子再删自己）
function kitpvp:skill/enderman/portal_puff
scoreboard players set @s kitpvp.tep_life 0
kill @s
