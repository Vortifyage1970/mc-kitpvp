# 击杀被动：饱和 I 5 刻（→ +5 饱食 +10 饱和）+ 力量 I 10 秒（普通效果的单位才是秒），没有冷却
effect give @s minecraft:saturation 5 0 true
effect give @s minecraft:strength 10 0 true

title @s actionbar {"text":"猎杀：+5 饱食 +10 饱和，10 秒力量 I","color":"dark_red"}
execute at @s run playsound minecraft:entity.wolf.howl master @s ~ ~ ~ 1 1.0
