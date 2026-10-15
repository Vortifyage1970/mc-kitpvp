# 击杀被动：5 秒饱和 I + 力量 I，没有冷却
effect give @s minecraft:saturation 5 0 true
effect give @s minecraft:strength 5 0 true

title @s actionbar {"text":"猎杀：5 秒饱和 I + 力量 I","color":"dark_red"}
execute at @s run playsound minecraft:entity.wolf.howl master @s ~ ~ ~ 1 1.0
