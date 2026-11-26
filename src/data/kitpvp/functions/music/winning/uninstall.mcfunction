tag @e remove nbs_winning
scoreboard objectives remove nbs_winning
scoreboard objectives remove nbs_winning_t
datapack disable "winning"
tellraw @s ["",{"text":"[NBS] ","color":"gold","bold":true},{"text":"Data pack ","color":"yellow"},{"text":"winning","color":"gold","underlined":true},{"text":" uninstalled successfully. You may now remove it from your data pack folder.","color":"yellow"}]