# 蓄力：落地且按住 shift 时每刻 +1，满 60 刻（3 秒，20 刻/秒）= 跳跃提升 XV
# 1.20.1 没有"是否在地面"的 predicate 标志，只能用玩家 NBT 的 OnGround
execute if predicate kitpvp:sneaking if entity @s[nbt={OnGround:1b}] run scoreboard players add @s kitpvp.rocket_charge 1
execute if score @s kitpvp.rocket_charge matches 61.. run scoreboard players set @s kitpvp.rocket_charge 60
# 起跳时玩家仍按着 shift，只能靠离地归零；跳完后效果还留 4 秒，用来吃满落地减伤（跳跃提升每级减 1 点摔落伤害）
execute unless entity @s[nbt={OnGround:1b}] if score @s kitpvp.rocket_charge matches 1.. run scoreboard players set @s kitpvp.rocket_charge 0
execute unless predicate kitpvp:sneaking if score @s kitpvp.rocket_charge matches 1.. run scoreboard players set @s kitpvp.rocket_charge 0

# 线性档位：每 4 刻升一级，I..XV。跳跃提升只有一个效果槽，所以每刻按当前档位重挂 4 秒
execute if score @s kitpvp.rocket_charge matches 1..4 run effect give @s minecraft:jump_boost 4 0 true
execute if score @s kitpvp.rocket_charge matches 5..8 run effect give @s minecraft:jump_boost 4 1 true
execute if score @s kitpvp.rocket_charge matches 9..12 run effect give @s minecraft:jump_boost 4 2 true
execute if score @s kitpvp.rocket_charge matches 13..16 run effect give @s minecraft:jump_boost 4 3 true
execute if score @s kitpvp.rocket_charge matches 17..20 run effect give @s minecraft:jump_boost 4 4 true
execute if score @s kitpvp.rocket_charge matches 21..24 run effect give @s minecraft:jump_boost 4 5 true
execute if score @s kitpvp.rocket_charge matches 25..28 run effect give @s minecraft:jump_boost 4 6 true
execute if score @s kitpvp.rocket_charge matches 29..32 run effect give @s minecraft:jump_boost 4 7 true
execute if score @s kitpvp.rocket_charge matches 33..36 run effect give @s minecraft:jump_boost 4 8 true
execute if score @s kitpvp.rocket_charge matches 37..40 run effect give @s minecraft:jump_boost 4 9 true
execute if score @s kitpvp.rocket_charge matches 41..44 run effect give @s minecraft:jump_boost 4 10 true
execute if score @s kitpvp.rocket_charge matches 45..48 run effect give @s minecraft:jump_boost 4 11 true
execute if score @s kitpvp.rocket_charge matches 49..52 run effect give @s minecraft:jump_boost 4 12 true
execute if score @s kitpvp.rocket_charge matches 53..56 run effect give @s minecraft:jump_boost 4 13 true
execute if score @s kitpvp.rocket_charge matches 57.. run effect give @s minecraft:jump_boost 4 14 true

# 提示音：0.75 秒一声、音高往上走；满蓄力另响一声（charge 会停在 60，用 rocket_full 保证只响一次）
execute if score @s kitpvp.rocket_charge matches 15 run playsound minecraft:block.note_block.hat master @s ~ ~ ~ 0.25 1.3
execute if score @s kitpvp.rocket_charge matches 30 run playsound minecraft:block.note_block.hat master @s ~ ~ ~ 0.3 1.6
execute if score @s kitpvp.rocket_charge matches 45 run playsound minecraft:block.note_block.hat master @s ~ ~ ~ 0.3 2.0
execute if score @s kitpvp.rocket_charge matches 60 unless entity @s[tag=kitpvp.rocket_full] run playsound minecraft:block.amethyst_block.chime master @s ~ ~ ~ 0.45 1.2
execute if score @s kitpvp.rocket_charge matches 60 run tag @s add kitpvp.rocket_full
execute if score @s kitpvp.rocket_charge matches ..59 run tag @s remove kitpvp.rocket_full

# 落地即清（落地后第一刻）：先清掉蓄力留下的效果，再让常驻来源自己补回（见 skill/tainted_slime/land）
execute if entity @s[nbt={OnGround:1b}] if entity @s[tag=kitpvp.rocket_air] run function kitpvp:skill/tainted_slime/land
execute if entity @s[nbt={OnGround:1b}] run tag @s remove kitpvp.rocket_air
execute unless entity @s[nbt={OnGround:1b}] run tag @s add kitpvp.rocket_air
