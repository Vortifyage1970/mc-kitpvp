# 到期：摘掉 +20 的修饰符（当前血量高于新上限时原版会自己压回上限）
attribute @s minecraft:generic.max_health modifier remove 00000000-0000-0000-0000-000000000014

tag @s remove kitpvp.soul_zombie_active
scoreboard players set @s kitpvp.soul_zombie_timer 0

title @s actionbar {"text":"魂石·血怒已消散","color":"gray"}
