# 大奖：坐杀博徒领域（已在领域里就续时）
execute if entity @s[tag=kitpvp.ench_domain] run scoreboard players set @s kitpvp.ench_domain_t 1200
execute if entity @s[tag=kitpvp.ench_domain] run scoreboard players set @s kitpvp.li_dom_pull 40
execute if entity @s[tag=kitpvp.ench_domain] run effect give @s minecraft:speed 1200 1 true
execute if entity @s[tag=kitpvp.ench_domain] run effect give @s minecraft:haste 1200 1 true
execute if entity @s[tag=kitpvp.ench_domain] run effect give @s minecraft:regeneration 1200 0 true
execute if entity @s[tag=kitpvp.ench_domain] run title @s title [{"text":"★★★ 续时 60 秒","color":"light_purple","bold":true}]
execute unless entity @s[tag=kitpvp.ench_domain] run function kitpvp:skill/li_ench/start
execute unless entity @s[tag=kitpvp.ench_domain] run title @s title [{"text":"★★★ 坐杀博徒","color":"light_purple","bold":true}]
execute as @a at @s run playsound minecraft:entity.ender_dragon.growl master @s ~ ~ ~ 0.4 1.6
