# ===== 弓箭手：捡起"5 号弓" =====

execute if score @s kitpvp.bowid matches 5 run function kitpvp:skill/archer_refill

execute unless score @s kitpvp.bowid matches 5 run clear @s minecraft:bow{KitBowOwner:5b}
execute unless score @s kitpvp.bowid matches 5 run tag @a[scores={kitpvp.bowid=5}] add kitpvp.bow_stolen
execute unless score @s kitpvp.bowid matches 5 run tellraw @a [{"text":"[换弹] ","color":"gold","bold":true},{"selector":"@s","color":"white"},{"text":" 捡走了 ","color":"gray"},{"selector":"@a[scores={kitpvp.bowid=5}]","color":"aqua"},{"text":" 的弓，30 秒后归还","color":"gray"}]
execute unless score @s kitpvp.bowid matches 5 run schedule function kitpvp:skill/archer_return_5 600t replace

advancement revoke @s only kitpvp:player/archer_pickup_5
