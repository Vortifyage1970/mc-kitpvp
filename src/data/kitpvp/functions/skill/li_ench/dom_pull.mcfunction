# 领域内白抽：不扣血，重置 40 刻的下一抽
scoreboard players set @s kitpvp.li_dom_pull 40
function kitpvp:skill/li_ench/pull
playsound minecraft:block.note_block.hat master @s ~ ~ ~ 0.5 1.2
