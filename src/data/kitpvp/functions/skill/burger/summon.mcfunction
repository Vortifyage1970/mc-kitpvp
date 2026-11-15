# 蓄满 50 秒：全场公告 + 在随机存活玩家处召出汉堡兽，然后清空自己的蓄力
tellraw @a [{"text":"[汉堡小子] ","color":"light_purple","bold":true},{"text":"汉堡兽降临！","color":"red","bold":true}]
playsound minecraft:entity.wither.spawn master @a ~ ~ ~ 0.8 0.8
execute at @r[tag=kitpvp.selected,scores={kitpvp.alive=1},tag=!kitpvp.spectator] run function kitpvp:summon/burger_beast
scoreboard players set @s kitpvp.burger_charge 0
scoreboard players set @s kitpvp.burger_snd 20
scoreboard players set @s kitpvp.burger_announced 0
