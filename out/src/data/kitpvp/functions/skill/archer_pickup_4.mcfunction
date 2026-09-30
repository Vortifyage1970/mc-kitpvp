# ===== 弓箭手：捡起"4 号弓" =====

execute if score @s kitpvp.bowid matches 4 run function kitpvp:skill/archer_refill

execute unless score @s kitpvp.bowid matches 4 run clear @s minecraft:bow{KitBowOwner:4b}
execute unless score @s kitpvp.bowid matches 4 run tag @a[scores={kitpvp.bowid=4}] add kitpvp.bow_stolen
execute unless score @s kitpvp.bowid matches 4 run tellraw @a [{"text":"[换弹] ","color":"gold","bold":true},{"selector":"@s","color":"white"},{"text":" 捡走了 ","color":"gray"},{"selector":"@a[scores={kitpvp.bowid=4}]","color":"aqua"},{"text":" 的弓，30 秒后归还","color":"gray"}]
execute unless score @s kitpvp.bowid matches 4 run schedule function kitpvp:skill/archer_return_4 600t replace

advancement revoke @s only kitpvp:player/archer_pickup_4
