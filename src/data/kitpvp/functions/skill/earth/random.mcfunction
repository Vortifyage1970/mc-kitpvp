# 随机召一只生灵：1in2 连掷 7 次拼 0..127，再对"已实现的种类数"取模
# ⚠ 取模用的是实现数（29），不是 32：空号只是给未来预留的编号位置，不能真的掷中，
#   否则会白耗一枚蛋 + 白进 10 秒冷却。新增生灵时把数改成 30、31……并启用对应那行即可。
# 只负责"掷 + 召"：归属（link）、补货冷却、播报由调用方决定（地球职业在 summon，魂石在 soul/earth_step）
scoreboard players set #pool_size kitpvp.game 29

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

# 29..31 是给后续扩展预留的编号位置（目前不参与随机）：新增生灵时启用对应一行并把 #pool_size 加一
