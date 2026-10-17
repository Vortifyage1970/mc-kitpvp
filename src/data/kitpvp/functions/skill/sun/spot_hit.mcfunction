# 单句中招者：失明 10 秒（失明没有等级，放大器写了也不生效）
effect give @s minecraft:blindness 10 0 true

title @s actionbar {"text":"太阳黑子：失明 10 秒","color":"dark_purple"}
playsound minecraft:block.beacon.deactivate master @s ~ ~ ~ 1.0 0.5
