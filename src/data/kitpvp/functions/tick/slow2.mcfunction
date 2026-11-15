# 慢拍 · 每 2 刻：只放「读 used 快照」的触发与「cd 到点才补」的发放（幂等，晚 2 刻无感）。
# 这些行是从 tick/kits_* 里原样搬过来的；不要把它们改回每刻 —— 除非确实需要每刻精度。
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1,kitpvp.kit=3},tag=!kitpvp.spectator] if score @s kitpvp.tank_used > @s kitpvp.tank_last run function kitpvp:skill/tank/dispatch
execute as @a[scores={kitpvp.kit=3,kitpvp.alive=1,kitpvp.cd=0},tag=kitpvp.tank_handout,tag=!kitpvp.spectator] run function kitpvp:skill/tank/handout
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1,kitpvp.kit=4},tag=!kitpvp.spectator] if score @s kitpvp.assassin_used > @s kitpvp.assassin_last run function kitpvp:skill/assassin/dispatch
execute as @a[scores={kitpvp.kit=4,kitpvp.alive=1,kitpvp.cd=0},tag=kitpvp.assassin_handout,tag=!kitpvp.spectator] run function kitpvp:skill/assassin/handout
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1,kitpvp.kit=29},tag=!kitpvp.spectator] at @s if score @s kitpvp.tainted_turret_used > @s kitpvp.tainted_turret_last run function kitpvp:skill/tainted_archer/turret_cast
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1,kitpvp.kit=29},tag=!kitpvp.spectator] at @s if score @s kitpvp.tainted_core_used > @s kitpvp.tainted_core_last run function kitpvp:skill/tainted_archer/dispatch
execute as @a[scores={kitpvp.kit=24,kitpvp.alive=1,kitpvp.cd=0,kitpvp.tmp=..2},tag=!kitpvp.spectator] run function kitpvp:skill/tainted_archer/give_token_turret
execute as @a[scores={kitpvp.kit=24,kitpvp.alive=1,kitpvp.cd2=0,kitpvp.tmp=..0},tag=!kitpvp.spectator] run function kitpvp:skill/tainted_archer/give_token_core
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1,kitpvp.kit=29},tag=!kitpvp.spectator] if score @s kitpvp.tainted_fisher_blue_used > @s kitpvp.tainted_fisher_blue_last run function kitpvp:skill/tainted_fisher/blue_cast
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1,kitpvp.kit=29},tag=!kitpvp.spectator] if score @s kitpvp.tainted_fisher_domain_used > @s kitpvp.tainted_fisher_domain_last run function kitpvp:skill/tainted_fisher/domain_cast
execute as @a[scores={kitpvp.kit=29,kitpvp.alive=1,kitpvp.cd=0,kitpvp.cd2=0},tag=kitpvp.tainted_fisher_handout,tag=!kitpvp.spectator] run function kitpvp:skill/tainted_fisher/handout
execute if score #state kitpvp.game matches 1 as @a[scores={kitpvp.kit=12,kitpvp.alive=1,kitpvp.cd=..0},tag=!kitpvp.spectator] at @s run function kitpvp:skill/alchemist/refill_splash
execute as @a[scores={kitpvp.kit=30,kitpvp.alive=1},tag=!kitpvp.spectator] at @s if score @s kitpvp.ttamer_zombie_used > @s kitpvp.ttamer_zombie_last run function kitpvp:skill/tainted_tamer/cast1
execute as @a[scores={kitpvp.kit=30,kitpvp.alive=1},tag=!kitpvp.spectator] at @s if score @s kitpvp.ttamer_skeleton_used > @s kitpvp.ttamer_skeleton_last run function kitpvp:skill/tainted_tamer/cast1
execute as @a[scores={kitpvp.kit=30,kitpvp.alive=1},tag=!kitpvp.spectator] at @s if score @s kitpvp.ttamer_creeper_used > @s kitpvp.ttamer_creeper_last run function kitpvp:skill/tainted_tamer/cast1
execute as @a[scores={kitpvp.kit=30,kitpvp.alive=1},tag=!kitpvp.spectator] at @s if score @s kitpvp.ttamer_vindicator_used > @s kitpvp.ttamer_vindicator_last run function kitpvp:skill/tainted_tamer/cast2
execute as @a[scores={kitpvp.kit=30,kitpvp.alive=1},tag=!kitpvp.spectator] at @s if score @s kitpvp.ttamer_witch_used > @s kitpvp.ttamer_witch_last run function kitpvp:skill/tainted_tamer/cast2
execute as @a[scores={kitpvp.kit=30,kitpvp.alive=1},tag=!kitpvp.spectator] at @s if score @s kitpvp.ttamer_vex_used > @s kitpvp.ttamer_vex_last run function kitpvp:skill/tainted_tamer/cast2
execute as @a[scores={kitpvp.kit=30,kitpvp.alive=1},tag=!kitpvp.spectator] at @s if score @s kitpvp.ttamer_blaze_used > @s kitpvp.ttamer_blaze_last run function kitpvp:skill/tainted_tamer/cast2
execute if score #state kitpvp.game matches 1 as @a[scores={kitpvp.kit=30,kitpvp.alive=1,kitpvp.cd=..0},tag=!kitpvp.spectator] at @s run function kitpvp:skill/tainted_tamer/refill1
execute if score #state kitpvp.game matches 1 as @a[scores={kitpvp.kit=30,kitpvp.alive=1,kitpvp.cd2=..0},tag=!kitpvp.spectator] at @s run function kitpvp:skill/tainted_tamer/refill2
execute as @a[scores={kitpvp.kit=67,kitpvp.alive=1},tag=!kitpvp.spectator] at @s if score @s kitpvp.venus_chill_used > @s kitpvp.venus_chill_last run function kitpvp:skill/venus/chill_cast
execute as @a[scores={kitpvp.kit=67,kitpvp.alive=1},tag=!kitpvp.spectator] at @s if score @s kitpvp.venus_arm_used > @s kitpvp.venus_arm_last run function kitpvp:skill/venus/arm_cast
execute as @a[scores={kitpvp.kit=67,kitpvp.alive=1},tag=!kitpvp.spectator] at @s if score @s kitpvp.venus_bomb_used > @s kitpvp.venus_bomb_last run function kitpvp:skill/venus/bomb_cast
execute if score #state kitpvp.game matches 1 as @a[scores={kitpvp.kit=67,kitpvp.alive=1,kitpvp.cd=..0},tag=!kitpvp.spectator] at @s run function kitpvp:skill/venus/refill_chill
execute if score #state kitpvp.game matches 1 as @a[scores={kitpvp.kit=67,kitpvp.alive=1,kitpvp.cd2=..0},tag=!kitpvp.spectator] at @s run function kitpvp:skill/venus/refill_arm
execute if score #state kitpvp.game matches 1 as @a[scores={kitpvp.kit=67,kitpvp.alive=1,kitpvp.venus_cd3=..0},tag=!kitpvp.spectator] at @s run function kitpvp:skill/venus/refill_bomb
execute as @a[scores={kitpvp.kit=19,kitpvp.alive=1},tag=!kitpvp.spectator] at @s if score @s kitpvp.bomb_used > @s kitpvp.bomb_last run function kitpvp:skill/bomber/dispatch
execute as @a[scores={kitpvp.kit=32,kitpvp.alive=1},tag=!kitpvp.spectator] at @s if score @s kitpvp.bomb_used > @s kitpvp.bomb_last run function kitpvp:skill/tainted_bomber/dispatch
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1},tag=!kitpvp.spectator] if score @s kitpvp.soul_ep_used > @s kitpvp.soul_ep_last run function kitpvp:skill/soul/use_ep
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1},tag=!kitpvp.spectator] if score @s kitpvp.soul_farm_used > @s kitpvp.soul_farm_last run function kitpvp:skill/soul/use_farm
execute as @a[scores={kitpvp.kit=45,kitpvp.alive=1},tag=!kitpvp.spectator] if score @s kitpvp.chaos_skill_used > @s kitpvp.chaos_skill_last run function kitpvp:kit/chaos_skill
execute as @a[scores={kitpvp.kit=7,kitpvp.alive=1},tag=!kitpvp.spectator] if score @s kitpvp.fisher_used > @s kitpvp.fisher_last run function kitpvp:skill/fisher/cast
execute as @a[scores={kitpvp.kit=7,kitpvp.alive=1,kitpvp.cd=0},tag=kitpvp.fisher_handout,tag=!kitpvp.spectator] run function kitpvp:skill/fisher/handout
execute as @a[scores={kitpvp.kit=18,kitpvp.alive=1},tag=!kitpvp.spectator] if score @s kitpvp.werewolf_used > @s kitpvp.werewolf_last run function kitpvp:skill/werewolf/cast
execute as @a[scores={kitpvp.kit=11,kitpvp.alive=1},tag=!kitpvp.spectator] if score @s kitpvp.tamer_used > @s kitpvp.tamer_last run function kitpvp:skill/tamer/cast
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1,kitpvp.kit=34},tag=!kitpvp.spectator] if score @s kitpvp.tf_rise_used > @s kitpvp.tf_rise_last run function kitpvp:skill/tainted_farmer/rise_dispatch
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1,kitpvp.kit=34},tag=!kitpvp.spectator] if score @s kitpvp.tf_rally_used > @s kitpvp.tf_rally_last run function kitpvp:skill/tainted_farmer/rally_dispatch
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1,kitpvp.kit=34,kitpvp.cd=..0},tag=!kitpvp.spectator] at @s unless entity @e[type=minecraft:item,nbt={Item:{id:"minecraft:husk_spawn_egg",tag:{KitTaintedRally:1b}}},distance=..16] run function kitpvp:skill/tainted_farmer/rally_refill
execute as @a[tag=kitpvp.selected,scores={kitpvp.kit=65,kitpvp.alive=1},tag=!kitpvp.spectator] at @s if score @s kitpvp.sun_flare_used > @s kitpvp.sun_flare_last run function kitpvp:skill/sun/flare_cast
execute as @a[tag=kitpvp.selected,scores={kitpvp.kit=65,kitpvp.alive=1},tag=!kitpvp.spectator] at @s if score @s kitpvp.sun_spot_used > @s kitpvp.sun_spot_last run function kitpvp:skill/sun/spot_cast
execute if score #state kitpvp.game matches 1 as @a[scores={kitpvp.kit=65,kitpvp.alive=1,kitpvp.cd=0},tag=!kitpvp.spectator] at @s run function kitpvp:skill/sun/refill_flare
execute if score #state kitpvp.game matches 1 as @a[scores={kitpvp.kit=65,kitpvp.alive=1,kitpvp.cd2=0},tag=!kitpvp.spectator] at @s run function kitpvp:skill/sun/refill_spot
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1},tag=!kitpvp.spectator] if score @s kitpvp.soul_warrior_used > @s kitpvp.soul_warrior_last run function kitpvp:skill/soul/dispatch_warrior
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1},tag=!kitpvp.spectator] if score @s kitpvp.soul_archer_used > @s kitpvp.soul_archer_last run function kitpvp:skill/soul/use_archer
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1},tag=!kitpvp.spectator] if score @s kitpvp.soul_pirate_used > @s kitpvp.soul_pirate_last run function kitpvp:skill/soul/use_pirate
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1},tag=!kitpvp.spectator] if score @s kitpvp.soul_fisher_used > @s kitpvp.soul_fisher_last run function kitpvp:skill/soul/use_fisher
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1},tag=!kitpvp.spectator] if score @s kitpvp.soul_zombie_used > @s kitpvp.soul_zombie_last run function kitpvp:skill/soul/use_zombie
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1},tag=!kitpvp.spectator] if score @s kitpvp.soul_earth_used > @s kitpvp.soul_earth_last run function kitpvp:skill/soul/use_earth
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1},tag=!kitpvp.spectator] if score @s kitpvp.soul_li_used > @s kitpvp.soul_li_last run function kitpvp:skill/soul/use_li
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1},tag=!kitpvp.spectator] if score @s kitpvp.soul_slime_used > @s kitpvp.soul_slime_last run function kitpvp:skill/soul/use_slime
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1},tag=!kitpvp.spectator] if score @s kitpvp.soul_tamer_used > @s kitpvp.soul_tamer_last run function kitpvp:skill/soul/use_tamer
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1},tag=!kitpvp.spectator] if score @s kitpvp.soul_sun_used > @s kitpvp.soul_sun_last run function kitpvp:skill/soul/use_sun
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1},tag=!kitpvp.spectator] if score @s kitpvp.soul_mercury_used > @s kitpvp.soul_mercury_last run function kitpvp:skill/soul/use_mercury
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1},tag=!kitpvp.spectator] at @s if entity @e[tag=kitpvp.soul_mercury_token,distance=..4] run function kitpvp:skill/soul/use_mercury
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1},tag=!kitpvp.spectator] if score @s kitpvp.soul_venus_used > @s kitpvp.soul_venus_last run function kitpvp:skill/soul/use_venus
execute as @a[scores={kitpvp.kit=1..,kitpvp.alive=1}] if score @s kitpvp.cd matches ..0 run function kitpvp:skill/dispatch
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1},tag=!kitpvp.spectator] if score @s kitpvp.soul_ghost_used > @s kitpvp.soul_ghost_last run function kitpvp:skill/soul/use_ghost
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1},tag=!kitpvp.spectator] if score @s kitpvp.soul_mars_used > @s kitpvp.soul_mars_last run function kitpvp:skill/soul/use_mars
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1,kitpvp.kit=70},tag=!kitpvp.spectator] if score @s kitpvp.mars_domain_used > @s kitpvp.mars_domain_last run function kitpvp:skill/mars/domain_cast
execute if score #state kitpvp.game matches 1 as @a[scores={kitpvp.kit=69,kitpvp.alive=1,kitpvp.halley_cd=..0},tag=!kitpvp.spectator] at @s run function kitpvp:skill/halley/auto
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1,kitpvp.kit=69},tag=!kitpvp.spectator] if score @s kitpvp.halley_used > @s kitpvp.halley_last run function kitpvp:skill/halley/cast
