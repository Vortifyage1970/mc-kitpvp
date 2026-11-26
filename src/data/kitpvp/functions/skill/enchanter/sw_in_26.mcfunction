# 把 inventory.16 的金剑换到主手（手上原来拿着的东西先寄存在台子上）
tag @s remove kitpvp.sw_hand
execute at @s run summon minecraft:armor_stand ~ ~ ~ {Tags:["kitpvp.sw_bench"],Invisible:1b,NoGravity:1b,Invulnerable:1b}
item replace entity @e[tag=kitpvp.sw_bench,limit=1,sort=nearest] armor.chest from entity @s inventory.16
execute if data entity @s SelectedItem run tag @s add kitpvp.sw_hand
execute if entity @s[tag=kitpvp.sw_hand] run item replace entity @e[tag=kitpvp.sw_bench,limit=1,sort=nearest] armor.legs from entity @s weapon.mainhand
item replace entity @s weapon.mainhand from entity @e[tag=kitpvp.sw_bench,limit=1,sort=nearest] armor.chest
execute unless entity @s[tag=kitpvp.sw_hand] run item replace entity @s inventory.16 with minecraft:air
execute if entity @s[tag=kitpvp.sw_hand] run item replace entity @s inventory.16 from entity @e[tag=kitpvp.sw_bench,limit=1,sort=nearest] armor.legs
scoreboard players set @s kitpvp.ench_sslot 26
function kitpvp:skill/enchanter/sw_roll
