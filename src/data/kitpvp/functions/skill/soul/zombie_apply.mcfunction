# 20 秒：最大生命 +20（属性修饰符，到期只摘修饰符，不动职业的基础值）、瞬间治疗 I、生命恢复 I
# 修饰符是"加在当前上限上"，所以僵尸职业用就是 40+20=60，其他职业用就是 20+20=40
# UUID 固定，clear_player 与到期清理都按它摘（同水星移速修饰符的做法）
attribute @s minecraft:generic.max_health modifier add 00000000-0000-0000-0000-000000000014 "kitpvp.soul_zombie_health" 20 add
effect give @s minecraft:instant_health 1 0 true
effect give @s minecraft:regeneration 20 0 true

tag @s add kitpvp.soul_zombie_active
scoreboard players set @s kitpvp.soul_zombie_timer 400

title @s actionbar {"text":"魂石·血怒：生命上限 +20、瞬间治疗 I、生命恢复 I（20 秒）","color":"dark_green"}
playsound minecraft:item.totem.use master @s ~ ~ ~ 0.6 1.0
