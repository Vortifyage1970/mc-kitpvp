clear @s minecraft:bow{KitSoulBow:1b}
give @s minecraft:arrow{KitSoulArrow:1b,display:{Name:'{"text":"魂石之箭","color":"light_purple"}'}} 1
give @s minecraft:bow{KitSoulBow:1b,Enchantments:[{id:"minecraft:infinity",lvl:1},{id:"minecraft:punch",lvl:1},{id:"minecraft:power",lvl:1}],display:{Name:'{"text":"魂石之弓","color":"light_purple"}'}} 1

tag @s add kitpvp.soul_bow_held
scoreboard players set @s kitpvp.soul_bow_timer 400

title @s actionbar {"text":"魂石·疾射：无限 I 冲击 I（20 秒）","color":"green"}
playsound minecraft:entity.arrow.shoot master @s ~ ~ ~ 0.8 1.2
