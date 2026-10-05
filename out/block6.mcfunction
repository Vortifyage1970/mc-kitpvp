# 药剂师（假设 kit=6、药水标记 KitPotionAlch:1b）
tag @a remove kitpvp.hold_pa_prev
tag @a[tag=kitpvp.hold_pa] add kitpvp.hold_pa_prev
tag @a remove kitpvp.hold_pa
execute as @a if data entity @s SelectedItem.tag.KitPotionAlch run tag @s add kitpvp.hold_pa
execute as @a[scores={kitpvp.kit=6,kitpvp.alive=1},tag=!kitpvp.spectator] if score @s kitpvp.potion_used > @s kitpvp.potion_last run function kitpvp:skill/alchemist_cast
