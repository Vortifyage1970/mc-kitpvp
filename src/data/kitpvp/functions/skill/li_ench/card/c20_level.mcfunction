# 大当：剑与护甲各 +1 级（直接灌 3 点再走 ench_check）
scoreboard players add @s kitpvp.ench_sw 3
scoreboard players add @s kitpvp.ench_ap 3
execute if score @s kitpvp.ench_sw matches 4.. run scoreboard players set @s kitpvp.ench_sw 3
execute if score @s kitpvp.ench_ap matches 4.. run scoreboard players set @s kitpvp.ench_ap 3
function kitpvp:skill/enchanter/ench_check
tellraw @s [{"text":"★ 大当！","color":"gold","bold":true},{"text":" 剑与护甲各升 1 级","color":"yellow"}]
playsound minecraft:block.anvil.use master @s ~ ~ ~ 1.0 0.8
particle minecraft:totem_of_undying ~ ~1 ~ 0.6 0.6 0.6 0.2 40
