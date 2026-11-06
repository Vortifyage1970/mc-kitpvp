# @s = 被随机抽中的那只：把它的名字写进通报（selector 会显示 CustomName）
tellraw @a [{"text":"本次事故责任人是","color":"gray"},{"selector":"@s","color":"red","italic":true},{"text":"。","color":"gray"}]
playsound minecraft:entity.villager.no master @a[distance=..32] ~ ~ ~ 0.7 0.8
