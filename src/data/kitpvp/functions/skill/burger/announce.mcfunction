# 25 秒提示：全场一次
scoreboard players set @s kitpvp.burger_announced 1
tellraw @a [{"text":"[汉堡小子] ","color":"light_purple","bold":true},{"text":"有人蓄力已达 ","color":"yellow"},{"text":"25","color":"gold"},{"text":" 秒，汉堡兽即将诞生……","color":"yellow"}]
playsound minecraft:block.note_block.bell master @a ~ ~ ~ 0.6 1.4
