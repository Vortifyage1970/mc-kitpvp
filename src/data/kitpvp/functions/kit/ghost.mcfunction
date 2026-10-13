# 幽灵（kit = 6）：仅 1 条命；受伤发光由 advancement kitpvp:player/ghost_hurt 触发
function kitpvp:util/clear_player
scoreboard players set @s kitpvp.kit 6
scoreboard players set @s kitpvp.alive 1
scoreboard players set @s kitpvp.lives 1

give @s minecraft:golden_axe{Enchantments:[{id:"minecraft:sharpness",lvl:1}],Unbreakable:1b} 1
give @s minecraft:player_head{SkullOwner:"Ghost",Enchantments:[{id:"minecraft:protection",lvl:5}]} 1
give @s minecraft:golden_chestplate{Unbreakable:1b} 1
give @s minecraft:cooked_beef 24

function kitpvp:kit/ghost_passive

tag @s add kitpvp.selected
