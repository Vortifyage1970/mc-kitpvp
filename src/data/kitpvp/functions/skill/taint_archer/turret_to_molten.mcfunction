# 首次变身喷一下火，之后每 20 刻续期时不再重复
execute unless entity @s[tag=kitpvp.turret_molten] run particle minecraft:flame ~ ~1 ~ 0.4 0.6 0.4 0.02 25
execute unless entity @s[tag=kitpvp.turret_molten] run playsound minecraft:block.lava.extinguish master @a[distance=..9] ~ ~ ~ 0.7 1.4
execute unless entity @s[tag=kitpvp.turret_molten] run scoreboard players add #buffcnt kitpvp.game 1

# 熔火形态：装备按"强化形态"给，与 turret_from_molten 成对
item replace entity @s armor.head with minecraft:magma_block
item replace entity @s armor.chest with minecraft:golden_chestplate{Enchantments:[{id:"minecraft:unbreaking",lvl:3}]}
item replace entity @s armor.legs with minecraft:golden_leggings{Enchantments:[{id:"minecraft:unbreaking",lvl:3}]}
item replace entity @s armor.feet with minecraft:golden_boots{Enchantments:[{id:"minecraft:unbreaking",lvl:3}]}
item replace entity @s weapon.mainhand with minecraft:bow{Enchantments:[{id:"minecraft:power",lvl:2},{id:"minecraft:punch",lvl:1},{id:"minecraft:flame",lvl:2}]}

# 抗性提升 IV（amplifier 3）：形态 30 秒，直接给满 30 秒（不再刷新续期）
effect give @s minecraft:resistance 30 3 true

tag @s add kitpvp.turret_molten
scoreboard players set @s kitpvp.turret_molten_timer 600
