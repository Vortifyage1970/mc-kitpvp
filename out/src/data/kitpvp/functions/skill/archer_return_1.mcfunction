# ===== 弓箭手：30 秒后归还"1 号弓" =====
# 由 archer_pickup_1 通过 schedule 触发
# 只有仍处于"弓被抢走"标记的 1 号弓箭手才会拿到归还

execute as @a[scores={kitpvp.bowid=1},tag=kitpvp.bow_stolen] run item replace entity @s weapon.offhand with minecraft:bow{KitBowOwner:1b,Unbreakable:1b} 1
execute as @a[scores={kitpvp.bowid=1},tag=kitpvp.bow_stolen] run tellraw @s [{"text":"你的弓已被归还","color":"green"}]
execute as @a[scores={kitpvp.bowid=1},tag=kitpvp.bow_stolen] run tag @s remove kitpvp.bow_stolen
