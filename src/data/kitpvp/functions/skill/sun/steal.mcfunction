# 只清带 KitSunBow:1b 的弓；replace 保证重复被捡只保留最后一次归还计时
clear @s minecraft:bow{KitSunBow:1b}

title @s actionbar {"text":"这把弓不属于你，已没收","color":"red"}
playsound minecraft:entity.item.break master @s ~ ~ ~ 0.8 1.0

tellraw @a [{"text":"[!] ","color":"red","bold":true},{"selector":"@s","color":"white"},{"text":" 捡走了太阳的弓，30 秒后归还","color":"gray"}]

schedule function kitpvp:skill/sun/return 600t replace
