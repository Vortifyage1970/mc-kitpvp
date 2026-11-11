# 蓄力：落地且按住 shift 时每刻 +1，满 40 刻（2 秒）= 跳跃提升 XVI（amplifier 15）
# 1.20.1 没有"是否在地面"的 predicate 标志，只能用玩家 NBT 的 OnGround
execute if predicate kitpvp:sneaking if entity @s[nbt={OnGround:1b}] run scoreboard players add @s kitpvp.rocket_charge 1
execute if score @s kitpvp.rocket_charge matches 41.. run scoreboard players set @s kitpvp.rocket_charge 40
# 起跳时玩家仍按着 shift，只能靠离地归零；跳完后效果还留 4 秒，用来吃满落地减伤（跳跃提升每级减 1 点摔落伤害）
execute unless entity @s[nbt={OnGround:1b}] if score @s kitpvp.rocket_charge matches 1.. run scoreboard players set @s kitpvp.rocket_charge 0
execute unless predicate kitpvp:sneaking if score @s kitpvp.rocket_charge matches 1.. run scoreboard players set @s kitpvp.rocket_charge 0

# 线性档位：amplifier = floor(charge × 3 / 8)，40 刻正好到 XV（等级 XVI）。跳跃提升只有一个效果槽，每刻按档位重挂 4 秒
execute if score @s kitpvp.rocket_charge matches 0..2 run effect give @s minecraft:jump_boost 4 0 true
execute if score @s kitpvp.rocket_charge matches 3..5 run effect give @s minecraft:jump_boost 4 1 true
execute if score @s kitpvp.rocket_charge matches 6..7 run effect give @s minecraft:jump_boost 4 2 true
execute if score @s kitpvp.rocket_charge matches 8..10 run effect give @s minecraft:jump_boost 4 3 true
execute if score @s kitpvp.rocket_charge matches 11..13 run effect give @s minecraft:jump_boost 4 4 true
execute if score @s kitpvp.rocket_charge matches 14..16 run effect give @s minecraft:jump_boost 4 5 true
execute if score @s kitpvp.rocket_charge matches 17..18 run effect give @s minecraft:jump_boost 4 6 true
execute if score @s kitpvp.rocket_charge matches 19..21 run effect give @s minecraft:jump_boost 4 7 true
execute if score @s kitpvp.rocket_charge matches 22..24 run effect give @s minecraft:jump_boost 4 8 true
execute if score @s kitpvp.rocket_charge matches 25..26 run effect give @s minecraft:jump_boost 4 9 true
execute if score @s kitpvp.rocket_charge matches 27..29 run effect give @s minecraft:jump_boost 4 10 true
execute if score @s kitpvp.rocket_charge matches 30..32 run effect give @s minecraft:jump_boost 4 11 true
execute if score @s kitpvp.rocket_charge matches 33..34 run effect give @s minecraft:jump_boost 4 12 true
execute if score @s kitpvp.rocket_charge matches 35..37 run effect give @s minecraft:jump_boost 4 13 true
execute if score @s kitpvp.rocket_charge matches 38..39 run effect give @s minecraft:jump_boost 4 14 true
execute if score @s kitpvp.rocket_charge matches 40..40 run effect give @s minecraft:jump_boost 4 15 true

# 蓄力音效：每 10 刻一声、音高往上走，音量加大；满蓄力再响一声（charge 停在 40，用 rocket_full 保证只响一次）
execute if score @s kitpvp.rocket_charge matches 10 run playsound minecraft:block.note_block.hat master @s ~ ~ ~ 0.8 1.3
execute if score @s kitpvp.rocket_charge matches 20 run playsound minecraft:block.note_block.hat master @s ~ ~ ~ 0.9 1.6
execute if score @s kitpvp.rocket_charge matches 30 run playsound minecraft:block.note_block.hat master @s ~ ~ ~ 1.0 2.0
execute if score @s kitpvp.rocket_charge matches 40 unless entity @s[tag=kitpvp.rocket_full] run playsound minecraft:block.amethyst_block.chime master @s ~ ~ ~ 1.0 1.2
execute if score @s kitpvp.rocket_charge matches 40 run tag @s add kitpvp.rocket_full
execute if score @s kitpvp.rocket_charge matches ..39 run tag @s remove kitpvp.rocket_full

# 落地即清（落地后第一刻）：先清掉蓄力留下的效果，再让常驻来源自己补回（见 skill/tainted_slime/land）
execute if entity @s[nbt={OnGround:1b}] if entity @s[tag=kitpvp.rocket_air] run function kitpvp:skill/tainted_slime/land
execute if entity @s[nbt={OnGround:1b}] run tag @s remove kitpvp.rocket_air
execute unless entity @s[nbt={OnGround:1b}] run tag @s add kitpvp.rocket_air
