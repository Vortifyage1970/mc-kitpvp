# Notch 模式：饱和 I + 生命恢复 X（amplifier 9）都设成无限，再点一次关掉
# 开关状态记在 #notch（0 关 / 1 开），用 %2 翻转；是否生效另挂 tag，debug/off 好一次收干净
scoreboard players set #notch_cap kitpvp.game 2
scoreboard players add #notch kitpvp.game 1
scoreboard players operation #notch kitpvp.game %= #notch_cap kitpvp.game

execute if score #notch kitpvp.game matches 1 run tag @s add kitpvp.notch_mode
execute if score #notch kitpvp.game matches 1 run effect give @s minecraft:saturation infinite 0 true
execute if score #notch kitpvp.game matches 1 run effect give @s minecraft:regeneration infinite 9 true
execute if score #notch kitpvp.game matches 1 run tellraw @s [{"text":"[debug] ","color":"light_purple","bold":true},{"text":"Notch 模式：已开启（饱和 I + 生命恢复 X，无限）。再点一次关闭。","color":"green"}]

execute if score #notch kitpvp.game matches 0 run tag @s remove kitpvp.notch_mode
execute if score #notch kitpvp.game matches 0 run effect clear @s minecraft:saturation
execute if score #notch kitpvp.game matches 0 run effect clear @s minecraft:regeneration
execute if score #notch kitpvp.game matches 0 run tellraw @s [{"text":"[debug] ","color":"light_purple","bold":true},{"text":"Notch 模式：已关闭。","color":"gray"}]

playsound minecraft:ui.button.click master @s ~ ~ ~ 1 1.2
