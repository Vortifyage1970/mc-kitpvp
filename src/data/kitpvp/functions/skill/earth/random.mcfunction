# 随机召一只生灵：1in2 连掷 7 次拼 0..127，再对"已实现的种类数"取模
# ⚠ 取模用的是实现数（40），不是 2 的幂：空号会让某些编号永远掷不中，所以这个数必须等于"已实现的行数"。
#   新增生灵时把数加一并启用对应那行即可（现在 0..38 都满了，再加就要同时加行 + 加数）。
# 只负责"掷 + 召"：归属（link）、补货冷却、播报由调用方决定（地球职业在 summon，魂石在 soul/earth_step）
scoreboard players set #pool_size kitpvp.game 40

scoreboard players set @s kitpvp.rng 0
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.rng 1
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.rng 2
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.rng 4
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.rng 8
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.rng 16
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.rng 32
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.rng 64

scoreboard players operation @s kitpvp.rng %= #pool_size kitpvp.game

execute if score @s kitpvp.rng matches 0 run function kitpvp:summon/earth_ghost_minion
execute if score @s kitpvp.rng matches 1 run function kitpvp:summon/earth_turret
execute if score @s kitpvp.rng matches 2 run function kitpvp:summon/earth_ilsacul
execute if score @s kitpvp.rng matches 3 run function kitpvp:summon/earth_sheep
execute if score @s kitpvp.rng matches 4 run function kitpvp:summon/earth_brick_knockback
execute if score @s kitpvp.rng matches 5 run function kitpvp:summon/earth_brick_fire
execute if score @s kitpvp.rng matches 6 run function kitpvp:summon/earth_axe
execute if score @s kitpvp.rng matches 7 run function kitpvp:summon/earth_forester
execute if score @s kitpvp.rng matches 8 run function kitpvp:summon/earth_astronaut
execute if score @s kitpvp.rng matches 9 run function kitpvp:summon/earth_big_bomb
execute if score @s kitpvp.rng matches 10 run function kitpvp:summon/earth_tracker_bomb
execute if score @s kitpvp.rng matches 11 run function kitpvp:summon/earth_stone
execute if score @s kitpvp.rng matches 12 run function kitpvp:summon/earth_dispenser
execute if score @s kitpvp.rng matches 13 run function kitpvp:summon/earth_farmer
execute if score @s kitpvp.rng matches 14 run function kitpvp:summon/earth_ascend
execute if score @s kitpvp.rng matches 15 run function kitpvp:summon/earth_mercury
execute if score @s kitpvp.rng matches 16 run function kitpvp:summon/earth_disruptor
execute if score @s kitpvp.rng matches 17 run function kitpvp:summon/earth_fisher1
execute if score @s kitpvp.rng matches 18 run function kitpvp:summon/earth_fisher2
execute if score @s kitpvp.rng matches 19 run function kitpvp:summon/earth_ascend2
execute if score @s kitpvp.rng matches 20 run function kitpvp:summon/earth_boatman_wet
execute if score @s kitpvp.rng matches 21 run function kitpvp:summon/earth_boatman_dry
execute if score @s kitpvp.rng matches 22 run function kitpvp:summon/earth_hacker
execute if score @s kitpvp.rng matches 23 run function kitpvp:summon/earth_retainer
execute if score @s kitpvp.rng matches 24 run function kitpvp:summon/earth_grass
execute if score @s kitpvp.rng matches 25 run function kitpvp:summon/earth_qin
execute if score @s kitpvp.rng matches 26 run function kitpvp:summon/earth_target
execute if score @s kitpvp.rng matches 27 run function kitpvp:summon/earth_gearbox
execute if score @s kitpvp.rng matches 28 run function kitpvp:summon/earth_cop
execute if score @s kitpvp.rng matches 29 run function kitpvp:summon/earth_gentleman
execute if score @s kitpvp.rng matches 30 run function kitpvp:summon/earth_ollama
execute if score @s kitpvp.rng matches 31 run function kitpvp:summon/earth_vagrant
execute if score @s kitpvp.rng matches 32 run function kitpvp:summon/earth_spellblade
execute if score @s kitpvp.rng matches 33 run function kitpvp:summon/earth_bigbee
execute if score @s kitpvp.rng matches 34 run function kitpvp:summon/earth_jupiter
# 35 = 矿车：这一号内部再掷一次 1in2，带速度 VI 的与原味各占一半（分配在 earth_minecart_pick 里）
execute if score @s kitpvp.rng matches 35 run function kitpvp:summon/earth_minecart_pick
execute if score @s kitpvp.rng matches 36 run function kitpvp:summon/earth_cop_cleaner
execute if score @s kitpvp.rng matches 37 run function kitpvp:summon/earth_mobilizer
execute if score @s kitpvp.rng matches 38 run function kitpvp:summon/earth_skater
execute if score @s kitpvp.rng matches 39 run function kitpvp:summon/earth_cop_blink

# 0..39 已经全满：再加生灵就往下补一行，并把第 5 行的 #pool_size 一起加一
# 若某个号要拆成两个变体（像矿车这样），保持这一号的行数为 1、把变体分发交给 <name>_pick 之类的子函数
