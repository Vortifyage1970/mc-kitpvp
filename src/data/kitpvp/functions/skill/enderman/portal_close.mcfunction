# @s = 传送门 marker：到期收场（先出收尾粒子再删自己）
function kitpvp:skill/enderman/portal_puff
execute if entity @s[tag=kitpvp.tep_a] run bossbar set kitpvp:tep_hud_orange name {"text":"□ 橙门","color":"dark_gray"}
execute if entity @s[tag=kitpvp.tep_a] run bossbar set kitpvp:tep_hud_orange color white
execute if entity @s[tag=kitpvp.tep_a] run bossbar set kitpvp:tep_hud_orange value 0
execute if entity @s[tag=kitpvp.tep_b] run bossbar set kitpvp:tep_hud_blue name {"text":"□ 蓝门","color":"dark_gray"}
execute if entity @s[tag=kitpvp.tep_b] run bossbar set kitpvp:tep_hud_blue color white
execute if entity @s[tag=kitpvp.tep_b] run bossbar set kitpvp:tep_hud_blue value 0
execute if entity @s[tag=kitpvp.tep_r] run bossbar set kitpvp:tep_hud_red name {"text":"□ 红门","color":"dark_gray"}
execute if entity @s[tag=kitpvp.tep_r] run bossbar set kitpvp:tep_hud_red color white
execute if entity @s[tag=kitpvp.tep_r] run bossbar set kitpvp:tep_hud_red value 0
execute if entity @s[tag=kitpvp.tep_p] run bossbar set kitpvp:tep_hud_purple name {"text":"□ 紫门","color":"dark_gray"}
execute if entity @s[tag=kitpvp.tep_p] run bossbar set kitpvp:tep_hud_purple color white
execute if entity @s[tag=kitpvp.tep_p] run bossbar set kitpvp.tep_hud_purple value 0
scoreboard players set @s kitpvp.tep_life 0
kill @s
