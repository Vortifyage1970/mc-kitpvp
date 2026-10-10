# ==== 临时探针版，跑完务必还原成正式版 ====
tellraw @a [{"text":"[pass] 进入，cur = "},{"score":{"name":"#cur","objective":"kitpvp.tmp"}}]
execute as @r[tag=kitpvp.selected,tag=!kitpvp.spawn_assigned,tag=!kitpvp.spectator] run tellraw @a {"text":"[pass] @r 命中一个玩家","color":"green"}
execute if score #cur kitpvp.tmp matches 2 as @r[tag=kitpvp.selected,tag=!kitpvp.spawn_assigned,tag=!kitpvp.spectator] run tellraw @a {"text":"[pass] cur==2 且 @r 都成立","color":"yellow"}
execute if score #cur kitpvp.tmp matches 2 as @r[tag=kitpvp.selected,tag=!kitpvp.spawn_assigned,tag=!kitpvp.spectator] run function kitpvp:map/earth/spawn_2
