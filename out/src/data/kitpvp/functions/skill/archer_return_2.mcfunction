# ===== 弓箭手：30 秒后归还"2 号弓" =====

execute as @a[scores={kitpvp.bowid=2},tag=kitpvp.bow_stolen] run item replace entity @s weapon.offhand with minecraft:bow{KitBowOwner:2b,Unbreakable:1b} 1
execute as @a[scores={kitpvp.bowid=2},tag=kitpvp.bow_stolen] run tellraw @s [{"text":"你的弓已被归还","color":"green"}]
execute as @a[scores={kitpvp.bowid=2},tag=kitpvp.bow_stolen] run tag @s remove kitpvp.bow_stolen
