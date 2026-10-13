# 前 100 刻隐身 + 速度 III，后 500 刻纯冷却；临时速度 III 到期后自动回落永久速度 I（实测，见 05 §五）
effect give @s minecraft:invisibility 5 0 true
effect give @s minecraft:speed 5 2 true

tag @s add kitpvp.assassin_hidden
scoreboard players set @s kitpvp.cd 600

title @s actionbar {"text":"隐匿：5 秒隐身 + 速度 III","color":"dark_purple"}
playsound minecraft:entity.enderman.teleport master @s ~ ~ ~ 0.8 1.4
